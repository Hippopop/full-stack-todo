var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import connectionConfig from './mysql-config.js';
import { TODOSchema } from '../types/todo-z.js';
const getAllTodoQuery = "SELECT * FROM `todos`";
const deleteTodoQuery = "DELETE FROM `todos` WHERE `todos`.`id` = ?";
const insertTodoQuery = "INSERT INTO `todos`(`id`, `title`, `description`, `state`, `priority`) VALUES (?,?,?,?,?)";
const updateTodoQuery = "UPDATE `todos` SET `title` = ?, `description` = ?,`state` = ?, `priority` = ? WHERE `todos`.`id` = ?";
const insertTodo = (todo) => __awaiter(void 0, void 0, void 0, function* () {
    const [headers] = yield connectionConfig.query(insertTodoQuery, [todo.id, todo.title, todo.description, todo.state, todo.priority]);
    console.log(headers);
    return Object.assign({ id: headers.insertId }, todo);
});
const deleteTodo = (id) => __awaiter(void 0, void 0, void 0, function* () {
    const [headers] = yield connectionConfig.query(deleteTodoQuery, [id]);
    console.log(headers);
});
const updateTodo = (todo) => __awaiter(void 0, void 0, void 0, function* () {
    // *** This method automatically, creates a connection to the pool. And releases it after the query!
    const [headers, _] = yield connectionConfig.query(updateTodoQuery, [todo.title, todo.description, todo.state, todo.priority, todo.id]);
    console.log(headers);
    return Object.assign({ id: headers.insertId }, todo);
});
const getAllTodos = () => __awaiter(void 0, void 0, void 0, function* () {
    let dataList = [];
    // *** Here we manually created a connection. And released it manually after the query!
    const connection = yield connectionConfig.getConnection();
    const [rows, fields] = yield connection.query(getAllTodoQuery);
    rows.forEach((element) => {
        const parsedModel = TODOSchema.safeParse(element);
        if (parsedModel.success) {
            dataList.push(parsedModel.data);
        }
        else {
            // TODO: Handle ERROR!
        }
    });
    connection.release();
    return dataList;
});
export { getAllTodos, insertTodo, updateTodo, deleteTodo };
//# sourceMappingURL=todo.js.map