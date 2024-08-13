"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getRefreshToken = exports.updateRefreshToken = exports.passwordMatches = exports.getAuthData = exports.register = void 0;
const bcrypt_1 = __importDefault(require("bcrypt"));
const uuid_1 = require("uuid");
const mysql_config_1 = __importDefault(require("../mysql-config"));
const auth_z_1 = require("../../types/auth/auth-z");
const tableName = "authentication";
const findAuth = `SELECT * FROM ${tableName} WHERE (email = ? OR uuid = ?)`;
const getToken = `SELECT token FROM ${tableName} WHERE (email = ? OR uuid = ?)`;
const registerAuth = `INSERT INTO ${tableName}(uuid, email, phone, password) VALUES (?,?,?,?)`;
const updateTokenQuery = `UPDATE ${tableName} SET token = ? WHERE (uuid = ? OR email = ?)`;
const register = async (data) => {
    const uuid = (0, uuid_1.v4)();
    const salt = await bcrypt_1.default.genSalt();
    const hash = await bcrypt_1.default.hash(data.password, salt);
    const [headers] = await mysql_config_1.default.query(registerAuth, [uuid, data.email, data.phone, hash]);
    const auth = auth_z_1.AuthSchema.safeParse({
        uuid: uuid,
        token: [],
        password: hash,
        phone: data.phone,
        email: data.email,
        key: headers.insertId,
    });
    if (auth.success) {
        return auth.data;
    }
    else {
        throw auth.error;
    }
};
exports.register = register;
const getAuthData = async (uniqueData) => {
    const [rows, _] = await mysql_config_1.default.query(findAuth, [
        uniqueData, uniqueData,
    ]);
    if (rows.length === 0 || !rows.at(0))
        return undefined;
    const element = rows.at(0);
    const tokenContainingEmptyString = element.token.split(",");
    const token = tokenContainingEmptyString.filter((token) => token.length > 0);
    const purifiedData = auth_z_1.AuthSchema.safeParse({ ...element, token });
    if (purifiedData.success) {
        return purifiedData.data;
    }
    else {
        throw purifiedData.error;
    }
};
exports.getAuthData = getAuthData;
const passwordMatches = async function (input, hash) {
    return await bcrypt_1.default.compare(input, hash);
};
exports.passwordMatches = passwordMatches;
const updateRefreshToken = async function (uniqueData, newToken, oldToken = null) {
    let currentTokenList = [];
    const [rows, _] = await mysql_config_1.default.query(getToken, [
        uniqueData,
        uniqueData,
    ]);
    const tokensEmpty = (rows.length === 0 || !(rows.at(0)?.token));
    if (!tokensEmpty) {
        const element = rows.at(0);
        const tokenContainingEmptyString = element.token.split(",");
        const token = tokenContainingEmptyString.filter((token) => token.length > 0);
        currentTokenList.concat(token);
    }
    ;
    if (oldToken && currentTokenList.includes(oldToken)) {
        currentTokenList = currentTokenList.filter((val) => val != oldToken);
    }
    currentTokenList.push(newToken);
    const [headers, __] = await mysql_config_1.default.query(updateTokenQuery, [currentTokenList, uniqueData, uniqueData]);
};
exports.updateRefreshToken = updateRefreshToken;
const getRefreshToken = async function (uniqueData) {
    const [rows, _] = await mysql_config_1.default.query(getToken, [
        uniqueData,
        uniqueData,
    ]);
    if (rows.length === 0 || !rows.at(0))
        return undefined;
    const element = rows.at(0);
    console.log(`Found the token: ${element}`);
    const tokenContainingEmptyString = element.token.split(",");
    return tokenContainingEmptyString.filter((token) => token.length > 0);
};
exports.getRefreshToken = getRefreshToken;
exports.default = {
    getAuthData: exports.getAuthData,
    register: exports.register,
    passwordMatches: exports.passwordMatches,
    getRefreshToken: exports.getRefreshToken,
    updateRefreshToken: exports.updateRefreshToken,
};
//# sourceMappingURL=authentication.js.map