"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const todo_1 = require("../../database/todo");
const response_z_1 = require("../../types/response-z");
const todo_z_1 = require("../../types/todo-z");
const todoRoute = (0, express_1.Router)();
todoRoute.get('/all_todos', (0, response_z_1.wrapperFunction)({
    errorMsg: "Sorry! Couldn't get the TODOs.",
    successMsg: 'Request Successful! Got the TODOs.',
    schema: todo_z_1.TODOSchema.array(),
    buisnessLogic: async (req, res, next) => await (0, todo_1.getAllTodos)(),
}));
exports.default = todoRoute;
//# sourceMappingURL=todo-apis.js.map