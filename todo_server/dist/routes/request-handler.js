"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.wrapperFunction = void 0;
const zod_1 = require("zod");
const response_z_1 = require("../types/response/response-z");
const error_z_1 = require("../types/response/errors/error-z");
const error_codes_1 = require("../errors/error_codes");
const user_z_1 = require("../types/user/user-z");
const jwt_token_1 = __importDefault(require("../utils/token/jwt_token"));
/*
This is the wrapper function for handling all the requests. It takes the [schema] to assure the structure of
the returned data, [successMsg], [errorMsg], and the actual [businessLogic] as input.
This function will call the business logic and try to get the  data from it. If the data is successfully fetched,
it will parse the data with the [schema]  and return the response. In case of *error*, it will take the error and
turn it into a readable format and again parse it with the actual [responseSchema] and return the response.schema].

The response will be in the form of a [JSON] object with the following format:
* On success ->
  {
    status: 200,
    msg: "Success Message",
    data: "Data" // The data returned from the business logic with the given structure(*schema).
  }
* On error ->
  {
    msg: "Error Message",
    status: 400, // [400] for known logical errors. And [500] for unexpected errors.
    error: [
      {
        code: [string], // A short indication for the point of error.
        description: [string], // The description of the error.
      }
    ],
  }
*/
const wrapperFunction = (wrapperProps) => async (req, res, next) => {
    const { authenticate, successCode, schema, successMsg, errorMsg, businessLogic: businessLogic, } = wrapperProps;
    try {
        // *** Step: 0. If this request needed authorization, this is where it's checked!
        var userData;
        if (authenticate) {
            const { authorization } = req.headers;
            console.log(JSON.stringify(req.headers));
            if (!authorization)
                throw new error_z_1.ResponseError(error_codes_1.badRequest, "Attempting Unauthorized Access!");
            const token = authorization.split(" ")[1];
            console.log(`**${token}**`);
            const authData = await jwt_token_1.default.verifyAccessTokenWithData(token, user_z_1.UserSchema);
            if (authData) {
                userData = authData;
            }
            else
                throw new error_z_1.ResponseError(error_codes_1.unauthorized, "Invalid access token!");
        }
        // *** Step: 1. Calls the actual business logic!
        const data = await businessLogic(req, res, next, userData);
        if (res.headersSent) {
            console.log(`Response was already sent from (BusinessLogic) call. \n REQ: ${req}`);
            return;
        }
        // *** Step: 2. Parses the data and gives it the form of an [Response]!
        const safeData = (0, response_z_1.ResponseWrapperSchema)(schema).safeParse({
            data: data,
            msg: successMsg,
            status: successCode,
        });
        // *** Step: 3. Checks if the end result is a valid [Response], In case of [success] send the response else throw!
        if (safeData.success) {
            return res.status(error_codes_1.success).json(safeData.data);
        }
        else {
            throw safeData.error;
        }
    }
    catch (error) {
        console.log(error);
        // *** ErrorStep: Actual [error] handling!
        await handleErrors(error, errorMsg, res);
    }
    if (!res.headersSent) {
        console.log(`#Response wasn't handled for this request. \n REQ: ${req.originalUrl}`);
        return;
    }
};
exports.wrapperFunction = wrapperFunction;
// It has a lots of unnecessary double checks and overuse of [zod]!
async function handleErrors(error, errorMsg, res) {
    if (error instanceof error_z_1.ResponseError) {
        console.log("Found an ResponseError");
        // *** If the error type is ResponseError, then parse it to a [SimpleError]!
        const safeData = (0, response_z_1.ResponseWrapperSchema)().safeParse({
            msg: errorMsg,
            status: error.status,
            error: error.serializeErrors(),
        });
        // *** Then send the response with the list of parsed errors!
        if (safeData.success) {
            return res.status(safeData.data.status).json(safeData.data);
        }
        else {
            console.log(`UnhandledError: ${safeData.error}`);
            // TODO: Handle Unexpected Situations.
            // TODO: Maybe Create a (log) file to store these errors.
        }
    }
    else if (error instanceof zod_1.ZodError) {
        // *** If the error type is ZodError, then parse it to a [SimpleError]!
        const safeData = (0, response_z_1.ResponseWrapperSchema)().safeParse({
            status: error_codes_1.badRequest,
            msg: errorMsg,
            error: (0, error_z_1.ZodErrorParser)(error),
        });
        // *** Then send the response with the list of parsed errors!
        if (safeData.success) {
            return res.status(safeData.data.status).json(safeData.data);
        }
        else {
            console.log(`UnhandledError: ${safeData.error}`);
            // TODO: Handle Unexpected Situations.
            // TODO: Maybe Create a (log) file to store these errors.
        }
    }
    else {
        // *** In case of unknown [Errors], do a vague parsing, with the error code of [500].
        const safeData = (0, response_z_1.ResponseWrapperSchema)().safeParse({
            status: error_codes_1.server,
            msg: errorMsg,
            error: [
                {
                    codes: [error_codes_1.server],
                    description: `${error}`,
                },
            ],
        });
        // *** Then send the response with the list of parsed errors!
        if (safeData.success) {
            return res.status(safeData.data.status).json(safeData.data);
        }
        else {
            console.log(`UnhandledError: ${safeData.error}`);
            // TODO: Handle Unexpected Situations.
        }
    }
}
//# sourceMappingURL=request-handler.js.map