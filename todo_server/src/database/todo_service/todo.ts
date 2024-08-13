import connectionConfig from "../mysql-config";

import { ResultSetHeader, RowDataPacket } from "mysql2";
import { TODO, TODOSchema } from "../../types/todo/todo-z";
import { User } from "../../types/user/user-z";

const tableName = "todos";
const getAllTodoQuery = `SELECT * FROM ${tableName} WHERE ${tableName}.uuid = ?`;
const deleteTodoQuery = `DELETE FROM ${tableName} WHERE (${tableName}.id IN (?) AND ${tableName}.uuid = ?)`;
const insertTodoQuery = `INSERT INTO ${tableName}(uuid, title, description, state, priority) VALUES (?,?,?,?,?)`;
const updateTodoQuery = `UPDATE ${tableName} SET title = ?, description = ?, state = ?, priority = ? WHERE (${tableName}.id = ? AND ${tableName}.uuid = ?)`;


const insertTodo = async (todo: TODO, user: User): Promise<TODO> => {
  const [headers] = await connectionConfig.query<ResultSetHeader>(
    insertTodoQuery,
    [user.uuid, todo.title, todo.description, todo.state, todo.priority]
  );
  return { id: headers.insertId, ...todo };
};

const deleteTodo = async (id: number | number[], user: User) => {
  const [headers] = await connectionConfig.query<ResultSetHeader>(
    deleteTodoQuery,
    [id, user.uuid]
  );
  return id;
};

const updateTodo = async (todo: TODO, user: User): Promise<TODO> => {
  // *** This method automatically, creates a connection to the pool. And releases it after the query!
  const [headers, _] = await connectionConfig.query<ResultSetHeader>(
    updateTodoQuery,
    [todo.title, todo.description, todo.state, todo.priority, todo.id, user.uuid]
  );
  return { id: headers.insertId, ...todo };
};

const getAllTodos = async (user: User): Promise<TODO[]> => {
  // *** Here we manually created a connection. And released it manually after the query!
  const connection = await connectionConfig.getConnection();
  const [rows, fields] = await connection.query<RowDataPacket[]>(
    getAllTodoQuery, [user.uuid],
  );
  const purifiedData = TODOSchema.array().safeParse(rows);
  if (purifiedData.success) {
    connection.release();
    return purifiedData.data;
  } else {
    connection.release();
    throw purifiedData.error;
  }
};

export { getAllTodos, insertTodo, updateTodo, deleteTodo };
