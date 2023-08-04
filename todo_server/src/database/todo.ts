import connectionConfig from "./mysql-config";

import { ResultSetHeader, RowDataPacket } from "mysql2";
import { TODO, TODOSchema } from "../types/todo-z";

const getAllTodoQuery = "SELECT * FROM `todos`";
const deleteTodoQuery = "DELETE FROM `todos` WHERE `todos`.`id` IN (?)";
const insertTodoQuery =
  // "INSERT INTO `todos`(`id`, `title`, `description`, `state`, `priority`) VALUES (?,?,?,?,?)";
  "INSERT INTO `todos`(`title`, `description`, `state`, `priority`) VALUES (?,?,?,?)";
const updateTodoQuery =
  "UPDATE `todos` SET `title` = ?, `description` = ?,`state` = ?, `priority` = ? WHERE `todos`.`id` = ?";

const insertTodo = async (todo: TODO): Promise<TODO> => {
  const [headers] = await connectionConfig.query<ResultSetHeader>(
    insertTodoQuery,
    [todo.title, todo.description, todo.state, todo.priority]
  );
  return { id: headers.insertId, ...todo };
};

const deleteTodo = async (id: number | number[]) => {
  const [headers] = await connectionConfig.query<ResultSetHeader>(
    deleteTodoQuery,
    [id]
  );
  return id;
};

const updateTodo = async (todo: TODO): Promise<TODO> => {
  // *** This method automatically, creates a connection to the pool. And releases it after the query!
  const [headers, _] = await connectionConfig.query<ResultSetHeader>(
    updateTodoQuery,
    [todo.title, todo.description, todo.state, todo.priority, todo.id]
  );
  return { id: headers.insertId, ...todo };
};

const getAllTodos = async (): Promise<TODO[]> => {
  // *** Here we manually created a connection. And released it manually after the query!
  const connection = await connectionConfig.getConnection();
  const [rows, fields] = await connection.query<RowDataPacket[]>(
    getAllTodoQuery
  );
  const purifiedData = TODOSchema.array().safeParse(rows);
  if (purifiedData.success) {
    connection.release();
    return purifiedData.data;
  } else {
    throw purifiedData.error;
  }
};

export { getAllTodos, insertTodo, updateTodo, deleteTodo };
