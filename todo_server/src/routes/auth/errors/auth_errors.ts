import { notFound, notMatched } from "../../../Errors/error_codes";
import { ResponseError } from "../../../types/response/errors/error-z";

/* Errors for auth routes start: */
export const userNotFoundError = new ResponseError(
  notFound,
  "No user found with the given data!"
);

export const wrongCredentialError = new ResponseError(
  notMatched,
  "Invalid password!"
);
/* Errors for auth routes end! */
