import connectionConfig from "../mysql-config";
import { ResultSetHeader, RowDataPacket } from "mysql2/promise";
import Image from "../../types/image/image";

const tableName = "images";
const findProfileImageQuery = `SELECT * FROM ${tableName} WHERE (type = ? AND uuid = ? AND name = ?) LIMIT 1`;
const createImageQuery = `INSERT INTO ${tableName}(uuid, type, extension, name, file) VALUES (?,?,?,?,?)`;

const insertImage = async (data: Image): Promise<Image> => {
  const [headers] = await connectionConfig.query<ResultSetHeader>(
    createImageQuery,
    [data.uuid, data.type, data.extension, data.name, data.imageFile],
  );
  return { ...data, id: headers.insertId! };
};

const getProfileImage = async (
  type: string,
  uuid: string,
  name: string,
): Promise<Image | undefined> => {
  const [rows, _] = await connectionConfig.query<RowDataPacket[]>(
    findProfileImageQuery,
    [type, uuid, name],
  );
  if (rows.length === 0 || !rows.at(0)) return undefined;
  const element = rows.at(0)!;
  return {
    id: element.id,
    uuid: element.uuid,
    type: element.type,
    extension: element.extension,
    name: element.name,
    imageFile: element.file,
  };
};

export { insertImage, getProfileImage };
