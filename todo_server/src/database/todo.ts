import connectionConfig from './mysql-config'

import { ResultSetHeader, RowDataPacket } from 'mysql2';
import { TODO, TODOSchema } from '../types/todo-z';


const getAllTodoQuery = "SELECT * FROM `todos`";
const deleteTodoQuery = "DELETE FROM `todos` WHERE `todos`.`id` = ?";
const insertTodoQuery = "INSERT INTO `todos`(`id`, `title`, `description`, `state`, `priority`) VALUES (?,?,?,?,?)";
const updateTodoQuery = "UPDATE `todos` SET `title` = ?, `description` = ?,`state` = ?, `priority` = ? WHERE `todos`.`id` = ?";


const insertTodo = async (todo: TODO): Promise<TODO> => {
    const [headers] = await connectionConfig.query<ResultSetHeader>(insertTodoQuery, [todo.id, todo.title, todo.description, todo.state, todo.priority],);
    console.log(headers);
    return { id: headers.insertId, ...todo };
}

const deleteTodo = async (id: number) => {
    const [headers] = await connectionConfig.query<ResultSetHeader>(deleteTodoQuery, [id]);
    console.log(headers);
}

const updateTodo = async (todo: TODO): Promise<TODO> => {
    // *** This method automatically, creates a connection to the pool. And releases it after the query!
    const [headers, _] = await connectionConfig.query<ResultSetHeader>(updateTodoQuery, [todo.title, todo.description, todo.state, todo.priority, todo.id],);
    console.log(headers);
    return { id: headers.insertId, ...todo };
}

const getAllTodos = async (): Promise<TODO[]> => {
    let dataList: TODO[] = [];
    // *** Here we manually created a connection. And released it manually after the query!
    const connection = await connectionConfig.getConnection();
    const [rows, fields] = await connection.query<RowDataPacket[]>(getAllTodoQuery);
    rows.forEach((element) => {
        const parsedModel = TODOSchema.safeParse(element);
        if (parsedModel.success) {
            dataList.push(parsedModel.data);
        } else {
            // TODO: Handle ERROR!
        }
    });

    connection.release();
    return dataList;
}

export { getAllTodos, insertTodo, updateTodo, deleteTodo };