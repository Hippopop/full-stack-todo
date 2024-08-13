"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const refresh_token_1 = require("./models/refresh_token");
const luxon_1 = require("luxon");
const node_crypto_1 = require("node:crypto");
const token_1 = require("./models/token");
const error_z_1 = require("../../types/response/errors/error-z");
const error_codes_1 = require("../../errors/error_codes");
const accessTokenTime = "2h";
const refreshTokenTime = "60 days";
const _tokenSchema = token_1.AccessTokenModelSchema.omit({ expire: true, timestamp: true });
function generateToken(data) {
    const tokenSecret = process.env.ACCESS_TOKEN;
    const expire = luxon_1.DateTime.now().plus({ hours: 2 }).toISO();
    const token = jsonwebtoken_1.default.sign(data, tokenSecret, {
        expiresIn: accessTokenTime,
    });
    return [token, expire];
}
const _generateRefreshTokenSchema = refresh_token_1.RefreshTokenSchema.omit({ sha256: true, expire: true, timestamp: true });
function generateRefreshToken(data) {
    const tokenSecret = process.env.REFRESH_TOKEN;
    const timeStamp = luxon_1.DateTime.now().toISO();
    const expire = luxon_1.DateTime.now().plus({ hours: 2 }).toISO();
    const newHash = (0, node_crypto_1.createHash)("sha256");
    const hashString = newHash.digest("hex");
    const signData = {
        ...data,
        expire: expire,
        sha256: hashString,
        timestamp: timeStamp,
    };
    const refreshToken = jsonwebtoken_1.default.sign(signData, tokenSecret, {
        expiresIn: refreshTokenTime,
        //** You can set the [expiresIn] only for [Object] types!
    });
    return [refreshToken, expire];
}
async function verifyRefreshTokenWithData(token, schema) {
    const tokenSecret = process.env.REFRESH_TOKEN;
    return await new Promise((resolve, reject) => {
        jsonwebtoken_1.default.verify(token, tokenSecret, async (err, data) => {
            if (data) {
                const purifiedData = schema.safeParse(data);
                if (purifiedData.success) {
                    resolve(purifiedData.data);
                }
                else {
                    reject(purifiedData.error);
                }
            }
            else
                reject(err);
        });
    });
}
async function verifyAccessTokenWithData(token, schema) {
    const tokenSecret = process.env.ACCESS_TOKEN;
    return new Promise((resolve, reject) => {
        jsonwebtoken_1.default.verify(token, tokenSecret, (err, data) => {
            if (data) {
                const purifiedData = schema.safeParse(data);
                if (purifiedData.success) {
                    resolve(purifiedData.data);
                }
                else {
                    reject(purifiedData.error);
                }
            }
            else {
                console.log(`Token isn't valid : ${err}`);
                reject(new error_z_1.ResponseError(error_codes_1.unauthorized, "JWT token has been expired!"));
            }
        });
    });
}
exports.default = {
    generateToken,
    generateRefreshToken,
    verifyAccessTokenWithData,
    verifyRefreshTokenWithData,
};
//# sourceMappingURL=jwt_token.js.map