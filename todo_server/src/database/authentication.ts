import bcrypt from "bcrypt";
import { v4 as uuIdv4 } from "uuid";
import connectionConfig from "./mysql-config";

import { ResultSetHeader, RowDataPacket } from "mysql2";
import { AuthSchema, AuthType } from "../types/auth/auth-z";
import { RegistrationUserModel } from "../routes/auth/models/register";

const tableName = "authentication";
const findAuth = `SELECT * FROM ${tableName} WHERE (email = ? OR uuid = ?)`;
const getToken = `SELECT token FROM ${tableName} WHERE (email = ? OR uuid = ?)`;
const registerAuth = `INSERT INTO ${tableName}(uuid, email, phone, password) VALUES (?,?,?,?)`;
const updateTokenQuery = `UPDATE ${tableName} SET token = ? WHERE (uuid = ? OR email = ?)`;

export const register = async (data: RegistrationUserModel): Promise<AuthType> => {
  const uuid = uuIdv4();
  const salt = await bcrypt.genSalt();
  const hash = await bcrypt.hash(data.password, salt);

  const [headers] = await connectionConfig.query<ResultSetHeader>(
    registerAuth,
    [uuid, data.email, data.phone, hash]
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
  uniqueData: string
): Promise<AuthType | undefined> => {
  const [rows, _] = await connectionConfig.query<RowDataPacket[]>(findAuth, [
    uniqueData, uniqueData,
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

export const updateRefreshToken = async function (
  uniqueData: string,
  newToken: string,
  oldToken: string | null = null,
) {

  let currentTokenList: string[] = [];
  const [rows, _] = await connectionConfig.query<RowDataPacket[]>(getToken, [
    uniqueData,
    uniqueData,
  ]);

  const tokensEmpty = (rows.length === 0 || !(rows.at(0)?.token));
  if (!tokensEmpty) {
    const element = rows.at(0);
    const tokenContainingEmptyString = (element!.token as string).split(",");
    const token = tokenContainingEmptyString.filter((token) => token.length > 0);
    currentTokenList.concat(token);
  };

  if (oldToken && currentTokenList.includes(oldToken)) {
    currentTokenList = currentTokenList.filter((val) => val != oldToken);
  }
  currentTokenList.push(newToken);
  const [headers, __] = await connectionConfig.query<ResultSetHeader>(
    updateTokenQuery,
    [currentTokenList, uniqueData, uniqueData]
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
  return tokenContainingEmptyString.filter((token) => token.length > 0);
};

export default {
  getAuthData,
  register,
  passwordMatches,
  getRefreshToken,
  updateRefreshToken,
};
