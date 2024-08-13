"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const promises_1 = __importDefault(require("fs/promises"));
const authentication_1 = __importDefault(require("../../database/authentication_service/authentication"));
const express_1 = require("express");
const request_handler_1 = require("../request-handler");
const auth_response_1 = require("./models/auth_response");
const login_z_1 = require("../../types/user/login-z");
const auth_errors_1 = require("./errors/auth_errors");
const user_1 = require("../../database/users_service/user");
const jwt_token_1 = __importDefault(require("../../utils/token/jwt_token"));
const error_codes_1 = require("../../errors/error_codes");
const multer_config_1 = __importDefault(require("../../utils/file_management/multer_config"));
const register_1 = require("./models/register");
const images_1 = require("../../database/image_service/images");
const authRoute = (0, express_1.Router)();
authRoute.post("/login", (0, request_handler_1.wrapperFunction)({
    successCode: error_codes_1.success,
    successMsg: "Logged in successfully!",
    errorMsg: "Login Failed!",
    schema: auth_response_1.AuthResModel,
    businessLogic: async (req, res, next) => {
        const loginData = login_z_1.LoginSchema.safeParse(req.body);
        if (loginData.success) {
            const authData = await authentication_1.default.getAuthData(loginData.data.email);
            if (authData) {
                const passMatched = await authentication_1.default.passwordMatches(loginData.data.password, authData.password);
                if (!passMatched)
                    throw auth_errors_1.wrongCredentialError;
                const userData = await (0, user_1.getUserData)(authData.email);
                const [accessToken, accessTokenExpire] = jwt_token_1.default.generateToken(userData);
                const [refreshToken, refreshTokenExpire] = jwt_token_1.default.generateRefreshToken({ uuid: authData.uuid, email: authData.email, token: accessToken });
                await authentication_1.default.updateRefreshToken(authData.uuid, refreshToken);
                return {
                    token: {
                        token: accessToken,
                        refreshToken: refreshToken,
                        expiresAt: accessTokenExpire,
                    },
                    user: { ...userData, phone: authData.phone },
                };
            }
            else {
                throw auth_errors_1.userNotFoundError;
            }
        }
        else {
            throw loginData.error;
        }
    },
}));
authRoute.post("/register", multer_config_1.default.single("image"), (0, request_handler_1.wrapperFunction)({
    successCode: error_codes_1.successfullyCreated,
    schema: auth_response_1.AuthResModel,
    successMsg: "Registration Successfully Completed!",
    errorMsg: "Sorry! Couldn't register with the given data.",
    businessLogic: async (req, res, next) => {
        const data = register_1.RegistrationUserSchema.safeParse(req.body);
        if (data.success) {
            const authData = await authentication_1.default.register(data.data);
            let imagePath;
            console.log(req.file?.path, req.file?.mimetype, req.file?.filename, req.file?.size, req.file?.buffer, req.file?.originalname);
            if (req.file) {
                console.log("Inserting file to DB!");
                const image = await (0, images_1.insertImage)({
                    type: "profile",
                    uuid: authData.uuid,
                    extension: req.file.mimetype.split("/")[1] ?? "unknown",
                    name: (req.file.filename ?? req.file.originalname),
                    imageFile: (req.file.path) ? (await promises_1.default.readFile(req.file.path)) : req.file.buffer,
                });
                imagePath = `auth/user_image?type=profile&uuid=${authData.uuid}&name=${image.name}`;
            }
            const userData = await (0, user_1.createUser)({
                uid: 0,
                ...authData,
                ...data.data,
                photo: imagePath,
            });
            const [accessToken, accessTokenExpire] = jwt_token_1.default.generateToken(userData);
            const [refreshToken, refreshExpire] = jwt_token_1.default.generateRefreshToken({ uuid: userData.uuid, email: userData.email, token: accessToken });
            await authentication_1.default.updateRefreshToken(authData.uuid, refreshToken);
            return {
                token: {
                    token: accessToken,
                    refreshToken: refreshToken,
                    expiresAt: accessTokenExpire,
                },
                user: { ...userData, phone: authData.phone },
            };
        }
        else {
            throw data.error;
        }
    },
}));
authRoute.get("/user_image", (0, request_handler_1.wrapperFunction)({
    successCode: 200,
    errorMsg: "Image not found!",
    successMsg: "Image fetched successfully!",
    businessLogic: async (req, res, next) => {
        if (req.query.type && req.query.uuid && req.query.name) {
            const image = await (0, images_1.getProfileImage)(req.query.type, req.query.uuid, req.query.name);
            if (image) {
                res.writeHead(200, { "Content-Type": "image/jpeg" }).end(image.imageFile);
            }
            else {
                throw auth_errors_1.userNotFoundError;
            }
        }
        else {
            throw auth_errors_1.userNotFoundError;
        }
    },
}));
// TODO: Update profile system!
// TODO: Forget password system!
exports.default = authRoute;
//# sourceMappingURL=auth-apis.js.map