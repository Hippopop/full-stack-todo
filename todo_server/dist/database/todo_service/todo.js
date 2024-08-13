"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteTodo = exports.updateTodo = exports.insertTodo = exports.getAllTodos = void 0;
const mysql_config_1 = __importDefault(require("../mysql-config"));
const todo_z_1 = require("../../types/todo/todo-z");
const tableName = "todos";
const getAllTodoQuery = `SELECT * FROM ${tableName} WHERE ${tableName}.uuid = ?`;
const deleteTodoQuery = `DELETE FROM ${tableName} WHERE (${tableName}.id IN (?) AND ${tableName}.uuid = ?)`;
const insertTodoQuery = `INSERT INTO ${tableName}(uuid, title, description, state, priority) VALUES (?,?,?,?,?)`;
const updateTodoQuery = `UPDATE ${tableName} SET title = ?, description = ?, state = ?, priority = ? WHERE (${tableName}.id = ? AND ${tableName}.uuid = ?)`;
const insertTodo = async (todo, user) => {
    const [headers] = await mysql_config_1.default.query(insertTodoQuery, [user.uuid, todo.title, todo.description, todo.state, todo.priority]);
    return { id: headers.insertId, ...todo };
};
exports.insertTodo = insertTodo;
const deleteTodo = async (id, user) => {
    const [headers] = await mysql_config_1.default.query(deleteTodoQuery, [id, user.uuid]);
    return id;
};
exports.deleteTodo = deleteTodo;
const updateTodo = async (todo, user) => {
    // *** This method automatically, creates a connection to the pool. And releases it after the query!
    const [headers, _] = await mysql_config_1.default.query(updateTodoQuery, [todo.title, todo.description, todo.state, todo.priority, todo.id, user.uuid]);
    return { id: headers.insertId, ...todo };
};
exports.updateTodo = updateTodo;
const getAllTodos = async (user) => {
    // *** Here we manually created a connection. And released it manually after the query!
    const connection = await mysql_config_1.default.getConnection();
    const [rows, fields] = await connection.query(getAllTodoQuery, [user.uuid]);
    const purifiedData = todo_z_1.TODOSchema.array().safeParse(rows);
    if (purifiedData.success) {
        connection.release();
        return purifiedData.data;
    }
    else {
        connection.release();
        throw purifiedData.error;
    }
};
exports.getAllTodos = getAllTodos;
//# sourceMappingURL=todo.js.map