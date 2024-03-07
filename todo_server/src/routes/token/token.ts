import { NextFunction, Request, Response, Router } from "express";
import { wrapperFunction } from "../request-handler";
import { badRequest, success, unauthorized } from "../../Errors/error_codes";
import { AuthTokenSchema } from "../../types/auth/token-z";
import tokenizer from "../../utils/token/jwt_token";
import { getUserData } from "../../database/user";
import { updateRefreshToken } from "../../database/authentication";
import { RefreshTokenSchema } from "../../utils/token/models/refresh_token";
import { faultyRefreshToken, noRefreshTokenError } from "./errors/refresh_token_errors";

const tokenRoute = Router();

tokenRoute.post(
  "/refresh_token",
  wrapperFunction({
    successCode: success,
    schema: AuthTokenSchema.required(),
    successMsg: "Auth Token successfully refreshed!",
    errorMsg: "Sorry! Provided refresh token wasn't valid. Please login again.",

    businessLogic: async (req: Request, res: Response, next?: NextFunction) => {
      const { token, refreshToken } = req.body;
      if (!refreshToken) throw noRefreshTokenError;
      const refreshTokenData = await tokenizer.verifyRefreshTokenWithData(
        refreshToken,
        RefreshTokenSchema,
      );
      if (!refreshTokenData) {
        throw faultyRefreshToken;
      } else {
        const userData = await getUserData(refreshTokenData.uuid);
        if (!userData) throw faultyRefreshToken;

        const [newAccessToken, accessTokenExpire] = tokenizer.generateToken(userData);
        const [newRefreshToken, refreshTokenExpire] = tokenizer.generateRefreshToken({ uuid: refreshTokenData.uuid, token: newAccessToken, email: userData.email });
        await updateRefreshToken(refreshTokenData.email, newRefreshToken, refreshToken);
        return {
          token: newAccessToken,
          refreshToken: newRefreshToken,
          expiresAt: accessTokenExpire,
        };
      }
    },
  })
);

export default tokenRoute;
