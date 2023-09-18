import bcrypt from "bcrypt";
import { v4 as uuIdv4 } from "uuid";
import connectionConfig from "./mysql-config";

import { ResultSetHeader, RowDataPacket } from "mysql2";
import { AuthSchema, AuthType } from "../types/auth/auth-z";
import { Login } from "../types/user/login-z";

const tableName = "authentication";
const findAuth = `SELECT * FROM ${tableName} WHERE email = ?`;
const getToken = `SELECT token FROM ${tableName} WHERE (email = ? OR uuid = ?)`;
const registerAuth = `INSERT INTO ${tableName}(uuid, email, password) VALUES (?,?,?)`;
const updateTokenQuery = `UPDATE ${tableName} SET token = ? WHERE (uuid = ? OR email = ?)`;

export const register = async (data: Login): Promise<AuthType> => {
  const uuid = uuIdv4();
  const salt = await bcrypt.genSalt();
  const hash = await bcrypt.hash(data.password, salt);

  const [headers] = await connectionConfig.query<ResultSetHeader>(
    registerAuth,
    [uuid, data.email, hash]
  );

  const auth = AuthSchema.safeParse({
    uuid: uuid,
    token: [],
    password: hash,
    email: data.email,
    key: headers.insertId,
  });
  if (auth.success) {
    return auth.data;
  } else {
    throw auth.error;
  }
};

export const getAuthData = async (
  email: string
): Promise<AuthType | undefined> => {
  const [rows, _] = await connectionConfig.query<RowDataPacket[]>(findAuth, [
    email,
  ]);

  if (rows.length === 0 || !rows.at(0)) return undefined;

  const element = rows.at(0);
  const tokenContainingEmptyString = (element!.token as string).split(",");
  const token = tokenContainingEmptyString.filter((token) => token.length > 0);

  const purifiedData = AuthSchema.safeParse({ ...element, token });
  if (purifiedData.success) {
    return purifiedData.data;
  } else {
    throw purifiedData.error;
  }
};

export const passwordMatches = async function (
  input: string,
  hash: string
): Promise<boolean> {
  return await bcrypt.compare(input, hash);
};

export const updateToken = async function (
  uniqueData: string,
  token: string[]
) {
  const [headers, _] = await connectionConfig.query<ResultSetHeader>(
    updateTokenQuery,
    [token.join(","), uniqueData, uniqueData]
  );
};

export const getRefreshToken = async function (
  uniqueData: string
): Promise<string[] | undefined> {
  const [rows, _] = await connectionConfig.query<RowDataPacket[]>(getToken, [
    uniqueData,
    uniqueData,
  ]);
  if (rows.length === 0 || !rows.at(0)) return undefined;
  const element = rows.at(0);
  console.log(`Found the token: ${element}`);
  const tokenContainingEmptyString = (element!.token as string).split(",");
  const token = tokenContainingEmptyString.filter((token) => token.length > 0);
};

export default {
  getAuthData,
  register,
  passwordMatches,
  getRefreshToken,
  updateToken,
};
