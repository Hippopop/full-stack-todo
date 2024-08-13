"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getUserData = exports.createUser = void 0;
const mysql_config_1 = __importDefault(require("../mysql-config"));
const user_z_1 = require("../../types/user/user-z");
const tableName = "users";
const findUserQuery = `SELECT * FROM ${tableName} WHERE (email = ? OR uuid = ?) LIMIT 1`;
const findUserImageQuery = `SELECT photo FROM ${tableName} WHERE (email = ? OR uuid = ?) LIMIT 1`;
const createUserQuery = `INSERT INTO ${tableName}(uuid, email, name, photo, birthdate) VALUES (?,?,?,?,?)`;
const createUser = async (data) => {
    const [headers] = await mysql_config_1.default.query(createUserQuery, [data.uuid, data.email, data.name, data.photo, data.birthdate]);
    return { ...data, uid: headers.insertId };
};
exports.createUser = createUser;
const getUserData = async (uniqueData) => {
    const [rows, _] = await mysql_config_1.default.query(findUserQuery, Array.from({
        length: 3,
    }, () => uniqueData));
    if (rows.length === 0 || !rows.at(0))
        return undefined;
    const element = rows.at(0);
    console.log(element);
    const purifiedData = user_z_1.UserSchema.safeParse(element);
    if (purifiedData.success) {
        return purifiedData.data;
    }
    else {
        throw purifiedData.error;
    }
};
exports.getUserData = getUserData;
//# sourceMappingURL=user.js.map