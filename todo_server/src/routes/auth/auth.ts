import { NextFunction, Request, Response, Router } from "express";
import { wrapperFunction } from "../request-handler";
import { AuthResModel } from "./models/auth_response";
import {
  getAuthData,
  passwordMatches,
  register,
  updateToken,
} from "../../database/authentication";
import { LoginSchema } from "../../types/user/login-z";
import { userNotFoundError, wrongCredentialError } from "./errors/auth_errors";
import {
  createUser,
  getUserData,
  getUserProfilePic,
} from "../../database/user";
import tokenizer from "../../utils/token/jwt_token";
import { success, successfullyCreated } from "../../Errors/error_codes";
import multerConfig from "../../utils/file_management/multer_config";
import { RegisterUserSchema } from "../../types/user/register-z";
import z from "zod";

const authRoute = Router();

authRoute.post(
  "/login",
  wrapperFunction({
    successCode: success,
    successMsg: "Logged in successfully!",
    errorMsg: "Login Failed!",
    schema: AuthResModel,
    businessLogic: async (req: Request, res: Response, next?: NextFunction) => {
      const loginData = LoginSchema.safeParse(req.body);
      if (loginData.success) {
        const authData = await getAuthData(loginData.data.email);
        if (authData) {
          const passMatched = await passwordMatches(
            loginData.data.password,
            authData.password
          );
          if (!passMatched) throw wrongCredentialError;
          const userData = await getUserData(authData.email);
          const accessToken = tokenizer.generateToken(userData!);
          const refreshToken = tokenizer.generateRefreshToken(authData.uuid);
          await updateToken(authData.uuid, [refreshToken]);
          return {
            token: {
              token: accessToken,
              refreshToken: refreshToken,
            },
            user: userData,
          };
        } else {
          throw userNotFoundError;
        }
      } else {
        throw loginData.error;
      }
    },
  })
);

authRoute.post(
  "/register",
  multerConfig.single("image"),
  wrapperFunction({
    successCode: successfullyCreated,
    schema: AuthResModel,
    successMsg: "Registration Successfully Completed!",
    errorMsg: "Sorry! Couldn't register with the given data.",
    businessLogic: async (req: Request, res: Response, next?: NextFunction) => {
      const data = RegisterUserSchema.safeParse(req.body);
      if (data.success) {
        const authData = await register(data.data);
        const userData = await createUser({
          uid: 0,
          ...authData,
          ...data.data,
          photo: req.file?.path,
        });
        const accessToken = tokenizer.generateToken(userData);
        const refreshToken = tokenizer.generateRefreshToken(authData.uuid);
        await updateToken(authData.uuid, [refreshToken, ...authData.token]);
        return {
          token: {
            token: accessToken,
            refreshToken: refreshToken,
          },
          user: userData,
        };
      } else {
        throw data.error;
      }
    },
  })
);

authRoute.get(
  "/user_image",
  wrapperFunction<void>({
    successCode: 200,
    successMsg: "Image fetched successfully!",
    errorMsg: "Image not found!",
    businessLogic: async (req: Request, res: Response, next?: NextFunction) => {
      const { user } = req.query;
      if (user) {
        const image = await getUserProfilePic(user.toString());
        if (image) {
          res.writeHead(200, { "Content-Type": "image/jpeg" });
          res.end(image);
        } else {
          throw userNotFoundError;
        }
      } else {
        throw userNotFoundError;
      }
    },
  })
);

export default authRoute;
