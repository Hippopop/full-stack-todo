import connectionConfig from "../mysql-config";
import { User, UserSchema } from "../../types/user/user-z";
import { ResultSetHeader, RowDataPacket } from "mysql2/promise";

const tableName = "users";
const findUserQuery = `SELECT * FROM ${tableName} WHERE (email = ? OR uuid = ?) LIMIT 1`;
const findUserImageQuery = `SELECT photo FROM ${tableName} WHERE (email = ? OR uuid = ?) LIMIT 1`;
const createUserQuery = `INSERT INTO ${tableName}(uuid, email, name, photo, birthdate) VALUES (?,?,?,?,?)`;

const createUser = async (data: User): Promise<User> => {
  const [headers] = await connectionConfig.query<ResultSetHeader>(
    createUserQuery,
    [data.uuid, data.email, data.name, data.photo, data.birthdate]
  );

  return { ...data, uid: headers.insertId };
};

const getUserData = async (uniqueData: string): Promise<User | undefined> => {
  const [rows, _] = await connectionConfig.query<RowDataPacket[]>(
    findUserQuery,
    Array.from(
      {
        length: 3,
      },
      () => uniqueData
    )
  );

  if (rows.length === 0 || !rows.at(0)) return undefined;
  const element = rows.at(0);
  console.log(element);
  const purifiedData = UserSchema.safeParse(element);
  if (purifiedData.success) {
    return purifiedData.data;
  } else {
    throw purifiedData.error;
  }
};

/* const getUserProfilePic = async (
  uniqueData: string
): Promise<Buffer | undefined> => {
  console.log("#Calling Image Function.");
  const [rows, _] = await connectionConfig.query<RowDataPacket[]>(
    findUserImageQuery,
    Array.from(
      {
        length: 3,
      },
      () => uniqueData
    )
  );
  console.log(rows);

  if (rows.length === 0 || !rows.at(0)) return undefined;
  const element = rows.at(0);
  return element!.photo;
}; */

export { createUser, getUserData, /* getUserProfilePic */ };
