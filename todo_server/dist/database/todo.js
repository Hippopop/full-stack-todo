"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteTodo = exports.updateTodo = exports.insertTodo = exports.getAllTodos = void 0;
const mysql_config_js_1 = __importDefault(require("./mysql-config.js"));
const todo_z_js_1 = require("../types/todo-z.js");
const getAllTodoQuery = "SELECT * FROM `todos`";
const deleteTodoQuery = "DELETE FROM `todos` WHERE `todos`.`id` = ?";
const insertTodoQuery = "INSERT INTO `todos`(`id`, `title`, `description`, `state`, `priority`) VALUES (?,?,?,?,?)";
const updateTodoQuery = "UPDATE `todos` SET `title` = ?, `description` = ?,`state` = ?, `priority` = ? WHERE `todos`.`id` = ?";
const insertTodo = async (todo) => {
    const [headers] = await mysql_config_js_1.default.query(insertTodoQuery, [todo.id, todo.title, todo.description, todo.state, todo.priority]);
    console.log(headers);
    return { id: headers.insertId, ...todo };
};
exports.insertTodo = insertTodo;
const deleteTodo = async (id) => {
    const [headers] = await mysql_config_js_1.default.query(deleteTodoQuery, [id]);
    console.log(headers);
};
exports.deleteTodo = deleteTodo;
const updateTodo = async (todo) => {
    // *** This method automatically, creates a connection to the pool. And releases it after the query!
    const [headers, _] = await mysql_config_js_1.default.query(updateTodoQuery, [todo.title, todo.description, todo.state, todo.priority, todo.id]);
    console.log(headers);
    return { id: headers.insertId, ...todo };
};
exports.updateTodo = updateTodo;
const getAllTodos = async () => {
    let dataList = [];
    // *** Here we manually created a connection. And released it manually after the query!
    const connection = await mysql_config_js_1.default.getConnection();
    const [rows, fields] = await connection.query(getAllTodoQuery);
    rows.forEach((element) => {
        const parsedModel = todo_z_js_1.TODOSchema.safeParse(element);
        if (parsedModel.success) {
            dataList.push(parsedModel.data);
        }
        else {
            // TODO: Handle ERROR!
        }
    });
    connection.release();
    return dataList;
};
exports.getAllTodos = getAllTodos;
//# sourceMappingURL=todo.js.map