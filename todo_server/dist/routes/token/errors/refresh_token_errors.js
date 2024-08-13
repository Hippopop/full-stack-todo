"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.noRefreshTokenError = exports.faultyRefreshToken = void 0;
const error_codes_1 = require("../../../errors/error_codes");
const error_z_1 = require("../../../types/response/errors/error-z");
exports.faultyRefreshToken = new error_z_1.ResponseError(error_codes_1.unauthorized, "Provided refresh token was faulty!");
exports.noRefreshTokenError = new error_z_1.ResponseError(error_codes_1.badRequest, "Please provide the refresh token!");
//# sourceMappingURL=refresh_token_errors.js.map