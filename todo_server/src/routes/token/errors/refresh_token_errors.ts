import { badRequest, unauthorized } from "../../../Errors/error_codes";
import { ResponseError } from "../../../types/response/errors/error-z";

export const faultyRefreshToken = new ResponseError(
    unauthorized,
    "Provided refresh token was faulty!",
);

export const noRefreshTokenError = new ResponseError(
    badRequest,
    "Please provide the refresh token!"
);