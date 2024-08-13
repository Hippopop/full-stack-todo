"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const todo_1 = require("../../database/todo_service/todo");
const todo_z_1 = require("../../types/todo/todo-z");
const request_handler_1 = require("../request-handler");
const zod_1 = __importDefault(require("zod"));
const error_codes_1 = require("../../errors/error_codes");
const todoRoute = (0, express_1.Router)();
todoRoute.get("/all", (0, request_handler_1.wrapperFunction)({
    authenticate: true,
    successCode: error_codes_1.success,
    errorMsg: "Sorry! Couldn't get the TODOs.",
    successMsg: "Request Successful! Got the TODOs.",
    schema: todo_z_1.TODOSchema.array(),
    businessLogic: async (req, res, next, user) => await (0, todo_1.getAllTodos)(user),
}));
todoRoute.post("/add", (0, request_handler_1.wrapperFunction)({
    authenticate: true,
    schema: todo_z_1.TODOSchema,
    successCode: error_codes_1.successfullyCreated,
    errorMsg: "Sorry! Couldn't add the TODO.",
    successMsg: "Request Successful! Added the TODO.",
    businessLogic: async (req, res, next, user) => {
        const todo = todo_z_1.TODOSchema.safeParse(req.body);
        if (todo.success) {
            return await (0, todo_1.insertTodo)(todo.data, user);
        }
        else {
            throw todo.error;
        }
    },
}));
/*
This request takes data in raw [JSON] format. I've tried to make it work with [application/x-www-form-urlencoded] but apparently
in that format you can't differentiate between [String] and [Number]. So, I've decided to use [application/json] instead.
Example:
{
  "delete": [1, 2, 3] (or) 1,
}
*/
todoRoute.delete("/delete", (0, request_handler_1.wrapperFunction)({
    authenticate: true,
    successCode: error_codes_1.successfullyDeleted,
    errorMsg: "Sorry! Couldn't Delete.",
    successMsg: "Request Successful! Deleted the TODO(s).",
    schema: zod_1.default.object({
        deleted: zod_1.default.number().or(zod_1.default.array(zod_1.default.number())),
    }),
    businessLogic: async (req, res, next, user) => {
        // *** This here will accept one single [TODO], or multiple [TODO]s to delete at once.
        const expectedSchema = zod_1.default.object({
            delete: zod_1.default.number().or(zod_1.default.array(zod_1.default.number())),
        });
        console.log(req.body);
        const purifiedBody = expectedSchema.safeParse(req.body);
        if (purifiedBody.success) {
            const result = await (0, todo_1.deleteTodo)(purifiedBody.data.delete, user);
            return { deleted: result };
        }
        else {
            throw purifiedBody.error;
        }
    },
}));
/** Same Issue as [delete()] **/
todoRoute.put("/update", (0, request_handler_1.wrapperFunction)({
    authenticate: true,
    successCode: error_codes_1.successfullyChanged,
    errorMsg: "Sorry! Couldn't update the TODO.",
    successMsg: "Request Successful! Updated the TODO.",
    schema: todo_z_1.TODOSchema,
    businessLogic: async (req, res, next, user) => {
        const todo = todo_z_1.TODOSchema.refine((val) => val.id, { message: "Please provide the (id) of the TODO, You want to update!", }).safeParse(req.body);
        if (todo.success) {
            return await (0, todo_1.updateTodo)(todo.data, user);
        }
        else {
            throw todo.error;
        }
    },
}));
exports.default = todoRoute;
//# sourceMappingURL=todo-apis.js.map