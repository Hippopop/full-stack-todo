import { notFound, notMatched } from "../../../Errors/error_codes";
import { ResponseError } from "../../../types/response/errors/error-z";

/* Errors for auth routes start: */
export const userNotFoundError = new ResponseError(
  notFound,
  "No records found with the provided credentials!"
);

export const wrongCredentialError = new ResponseError(
  notMatched,
  "Credentials didn't matched!"
);
/* Errors for auth routes end! */
