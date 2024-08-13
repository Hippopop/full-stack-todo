"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getProfileImage = exports.insertImage = void 0;
const mysql_config_1 = __importDefault(require("../mysql-config"));
const tableName = "images";
const findProfileImageQuery = `SELECT * FROM ${tableName} WHERE (type = ? AND uuid = ? AND name = ?) LIMIT 1`;
const createImageQuery = `INSERT INTO ${tableName}(uuid, type, extension, name, file) VALUES (?,?,?,?,?)`;
const insertImage = async (data) => {
    const [headers] = await mysql_config_1.default.query(createImageQuery, [data.uuid, data.type, data.extension, data.name, data.imageFile]);
    return { ...data, id: headers.insertId };
};
exports.insertImage = insertImage;
const getProfileImage = async (type, uuid, name) => {
    const [rows, _] = await mysql_config_1.default.query(findProfileImageQuery, [type, uuid, name]);
    if (rows.length === 0 || !rows.at(0))
        return undefined;
    const element = rows.at(0);
    return {
        id: element.id,
        uuid: element.uuid,
        type: element.type,
        extension: element.extension,
        name: element.name,
        imageFile: element.file,
    };
};
exports.getProfileImage = getProfileImage;
//# sourceMappingURL=images.js.map