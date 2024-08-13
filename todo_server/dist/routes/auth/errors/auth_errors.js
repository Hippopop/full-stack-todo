"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.wrongCredentialError = exports.userNotFoundError = void 0;
const error_codes_1 = require("../../../errors/error_codes");
const error_z_1 = require("../../../types/response/errors/error-z");
/* Errors for auth routes start: */
exports.userNotFoundError = new error_z_1.ResponseError(error_codes_1.notFound, "No user found with the given data!");
exports.wrongCredentialError = new error_z_1.ResponseError(error_codes_1.notMatched, "Invalid password!");
/* Errors for auth routes end! */
//# sourceMappingURL=auth_errors.js.map