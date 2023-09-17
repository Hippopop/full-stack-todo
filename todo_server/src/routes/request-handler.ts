import { Request, Response, NextFunction } from "express";
import { ZodError } from "zod";
import {
  ResponseWrapperSchema,
  WrapperProps,
} from "../types/response/response-z";
import {
  ResponseError,
  SimpleError,
  ZodErrorParser,
} from "../types/response/errors/error-z";
import {
  badRequest,
  server,
  success,
  unauthorized,
} from "../Errors/error_codes";
import { User, UserSchema } from "../types/user/user-z";
import tokenizer from "../utils/token/jwt_token";

/* 
This is the wrapper function for handling all the requests. It takes the [schema] to assure the structure of 
the returned data, [successMsg], [errorMsg], and the actual [buisnessLogic] as input.  
This function will call the buisness logic and try to get the  data from it. If the data is successfully fetched,
it will parse the data with the [schema]  and return the response. In case of *error*, it will take the error and 
turn it into a readable format and again parse it with the actual [responseSchema] and return the response.chema]. 

The response will be in the form of a [JSON] object with the following format: 
* On success -> 
  {
    status: 200,
    msg: "Success Message",
    data: "Data" // The data returned from the buisness logic with the given structure(*schema).
  } 
* On error -> 
  {
    msg: "Error Message",
    status: 400, // [400] for known logical errors. And [500] for unexpected errors.
    error: [
      {
        code: [string], // A short indicaion for the point of error.
        description: [string], // The description of the error.
      }
    ],
  }
*/

// I feel like I messed up, because I didn't had the knowledge about how the [NextFunction] system works!
// Bcz now for [Auth] and [Multimedia] support, I might need to use that system. 😅
export const wrapperFunction =
  <T>(wrapperProps: WrapperProps<T>) =>
  async (req: Request, res: Response, next: NextFunction) => {
    const {
      authenticate,
      successCode,
      schema,
      successMsg,
      errorMsg,
      businessLogic: businessLogic,
    } = wrapperProps;
    try {
      // *** Calls the actual business logic!
      var userData: User | undefined;
      if (authenticate) {
        const { authorization } = req.headers;
        if (!authorization)
          throw new ResponseError(
            badRequest,
            "Attempting Unauthorized Access!"
          );
        const token = authorization.split(" ")[1];
        const authData = tokenizer.verifyAccessTokenWithData(
          token!,
          UserSchema
        );
        if (authData) {
          userData = authData;
        } else throw new ResponseError(unauthorized, "Invalid access token!");
      }
      const data = await businessLogic(req, res);
      if (res.headersSent) {
        console.log(
          `Response was already sent from (BusinessLogic) call. \n REQ: ${req}`
        );
        return;
      }
      // *** Parses the data and gives it the form of an [Response]!
      const safeData = ResponseWrapperSchema(schema).safeParse({
        data: data,
        msg: successMsg,
        status: successCode,
      });
      // *** Checks if the end result is a valid [Response], In case of [success] send the response else throw!
      if (safeData.success) {
        return res.status(success).json(safeData.data);
      } else {
        throw safeData.error;
      }
    } catch (error) {
      console.log(error);
      // *** Actual [error] handling!
      await handleErrors(error, errorMsg, res);
    }

    if (!res.headersSent) {
      console.log(
        `#Response wasn't handled for this request. \n REQ: ${req.originalUrl}`
      );
      return;
    }
  };

// It has a lots of unnecessary double checks and overuse of [zod]!
async function handleErrors(error: any, errorMsg: string, res: Response) {
  if (error instanceof ResponseError) {
    console.log("Found an ResponseError");
    // *** If the error type is ResponseError, then parse it to a [SimpleError]!
    const safeData = ResponseWrapperSchema().safeParse({
      msg: errorMsg,
      status: error.status,
      error: error.serializeErrors(),
    });
    // *** Then send the response with the list of parsed errors!
    if (safeData.success) {
      return res.status(safeData.data.status).json(safeData.data);
    } else {
      console.log(`UnhandledError: ${safeData.error}`);
      // TODO: Handle Unexpected Situations.
      // TODO: Maybe Create a (log) file to store these errors.
    }
  } else if (error instanceof ZodError) {
    // *** If the error type is ZodError, then parse it to a [SimpleError]!
    const safeData = ResponseWrapperSchema().safeParse({
      status: badRequest,
      msg: errorMsg,
      error: ZodErrorParser(error),
    });
    // *** Then send the response with the list of parsed errors!
    if (safeData.success) {
      return res.status(safeData.data.status).json(safeData.data);
    } else {
      console.log(`UnhandledError: ${safeData.error}`);
      // TODO: Handle Unexpected Situations.
      // TODO: Maybe Create a (log) file to store these errors.
    }
  } else {
    // *** In case of unknown [Errors], do a vague parsing, with the error code of [500].
    const safeData = ResponseWrapperSchema().safeParse({
      status: server,
      msg: errorMsg,
      error: <SimpleError[]>[
        {
          codes: [server],
          description: `${error}`,
        },
      ],
    });
    // *** Then send the response with the list of parsed errors!
    if (safeData.success) {
      return res.status(safeData.data.status).json(safeData.data);
    } else {
      console.log(`UnhandledError: ${safeData.error}`);
      // TODO: Handle Unexpected Situations.
    }
  }
}
