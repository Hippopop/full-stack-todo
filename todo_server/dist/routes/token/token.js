"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.tokenRoute = void 0;
const express_1 = require("express");
const request_handler_1 = require("../request-handler");
const error_codes_1 = require("../../errors/error_codes");
const token_z_1 = require("../../types/auth/token-z");
const jwt_token_1 = __importDefault(require("../../utils/token/jwt_token"));
const user_1 = require("../../database/users_service/user");
const authentication_1 = require("../../database/authentication_service/authentication");
const refresh_token_1 = require("../../utils/token/models/refresh_token");
const refresh_token_errors_1 = require("./errors/refresh_token_errors");
const tokenRoute = (0, express_1.Router)();
exports.tokenRoute = tokenRoute;
tokenRoute.post("/refresh_token", (0, request_handler_1.wrapperFunction)({
    successCode: error_codes_1.success,
    schema: token_z_1.AuthTokenSchema.required(),
    successMsg: "Auth Token successfully refreshed!",
    errorMsg: "Sorry! Provided refresh token wasn't valid. Please login again.",
    businessLogic: async (req, res, next) => {
        const { token, refreshToken } = req.body;
        if (!refreshToken)
            throw refresh_token_errors_1.noRefreshTokenError;
        const refreshTokenData = await jwt_token_1.default.verifyRefreshTokenWithData(refreshToken, refresh_token_1.RefreshTokenSchema);
        if (!refreshTokenData) {
            throw refresh_token_errors_1.faultyRefreshToken;
        }
        else {
            const userData = await (0, user_1.getUserData)(refreshTokenData.uuid);
            if (!userData)
                throw refresh_token_errors_1.faultyRefreshToken;
            const [newAccessToken, accessTokenExpire] = jwt_token_1.default.generateToken(userData);
            const [newRefreshToken, refreshTokenExpire] = jwt_token_1.default.generateRefreshToken({ uuid: refreshTokenData.uuid, token: newAccessToken, email: userData.email });
            await (0, authentication_1.updateRefreshToken)(refreshTokenData.email, newRefreshToken, refreshToken);
            return {
                token: newAccessToken,
                refreshToken: newRefreshToken,
                expiresAt: accessTokenExpire,
            };
        }
    },
}));
//# sourceMappingURL=token.js.map