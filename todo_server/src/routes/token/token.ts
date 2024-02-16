import { NextFunction, Request, Response, Router } from "express";
import { wrapperFunction } from "../request-handler";
import z from "zod";
import { badRequest, success } from "../../Errors/error_codes";
import { AuthTokenSchema } from "../../types/auth/token-z";
import tokenizer from "../../utils/token/jwt_token";
import { getUserData } from "../../database/user";
import { updateToken } from "../../database/authentication";

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
      if (!refreshToken) throw badRequest;
      const uuid = tokenizer.verifyRefreshTokenWithData(
        refreshToken,
        z.string().uuid("Provided refresh token was corrupted!")
      );
      if (uuid) {
        const userData = await getUserData(uuid);
        if (!userData) throw badRequest;
        const accessToken = tokenizer.generateToken(userData);
        const refreshToken = tokenizer.generateRefreshToken(uuid);
        await updateToken(uuid, [refreshToken]);
        return {
          token: accessToken,
          refreshToken: refreshToken,
        };
      }
    },
  })
);

export default tokenRoute;
