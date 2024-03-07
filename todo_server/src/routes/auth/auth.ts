import fs from "fs/promises";
import auth from "../../database/authentication";
import { NextFunction, Request, Response, Router } from "express";
import { wrapperFunction } from "../request-handler";
import { AuthResModel } from "./models/auth_response";
import { LoginSchema } from "../../types/user/login-z";
import { userNotFoundError, wrongCredentialError } from "./errors/auth_errors";
import { createUser, getUserData } from "../../database/user";
import tokenizer from "../../utils/token/jwt_token";
import { success, successfullyCreated } from "../../Errors/error_codes";
import multerConfig from "../../utils/file_management/multer_config";
import { RegistrationUserSchema } from "./models/register";
import { insertImage, getProfileImage } from "../../database/images";


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
        const authData = await auth.getAuthData(loginData.data.email);
        if (authData) {
          const passMatched = await auth.passwordMatches(
            loginData.data.password,
            authData.password
          );
          if (!passMatched) throw wrongCredentialError;

          const userData = await getUserData(authData.email);
          const [accessToken, accessTokenExpire] = tokenizer.generateToken(userData!);
          const [refreshToken, refreshTokenExpire] = tokenizer.generateRefreshToken({ uuid: authData.uuid, email: authData.email, token: accessToken });
          await auth.updateRefreshToken(authData.uuid, refreshToken);
          return {
            token: {
              token: accessToken,
              refreshToken: refreshToken,
              expiresAt: accessTokenExpire,
            },
            user: { ...userData, phone: authData.phone },
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
      const data = RegistrationUserSchema.safeParse(req.body);
      if (data.success) {
        const authData = await auth.register(data.data);
        let imagePath: string | undefined;
        if (req.file) {
          const image = await insertImage({
            type: "profile",
            uuid: authData.uuid,
            extension: req.file.mimetype.split("/")[1] ?? "unknown",
            name: req.file.filename,
            imageFile: await fs.readFile(req.file.path),
          });
          imagePath = `auth/user_image?type=profile&uuid=${authData.uuid}&name=${image.name}`;
        }


        const userData = await createUser({
          uid: 0,
          ...authData,
          ...data.data,
          photo: imagePath,
        });
        const [accessToken, accessTokenExpire] = tokenizer.generateToken(userData);
        const [refreshToken, refreshExpire] = tokenizer.generateRefreshToken({ uuid: userData.uuid, email: userData.email, token: accessToken });
        await auth.updateRefreshToken(authData.uuid, refreshToken);
        return {
          token: {
            token: accessToken,
            refreshToken: refreshToken,
            expiresAt: accessTokenExpire,
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
    errorMsg: "Image not found!",
    successMsg: "Image fetched successfully!",
    businessLogic: async (req: Request, res: Response, next?: NextFunction) => {
      if (req.query.type && req.query.uuid && req.query.name) {
        const image = await getProfileImage(
          req.query.type as string,
          req.query.uuid as string,
          req.query.name as string
        );
        if (image) {
          res.writeHead(200, { "Content-Type": "image/jpeg" }).end(image.imageFile);
        } else {
          throw userNotFoundError;
        }
      } else {
        throw userNotFoundError;
      }
    },
  })
);

// TODO: Update profile system!




// TODO: Forget password system!

export default authRoute;
