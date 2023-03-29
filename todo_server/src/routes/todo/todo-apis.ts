import { NextFunction, Request, Response, Router } from "express";
import { getAllTodos } from "../../database/todo.js";
import { wrapperFunction } from "../../types/response-z.js";
import { TODOSchema } from "../../types/todo-z.js";

const todoRoute = Router();

todoRoute.get(
    '/all_todos',
    wrapperFunction({
        errorMsg: "Sorry! Couldn't get the TODOs.",
        successMsg: 'Request Successful! Got the TODOs.',
        schema: TODOSchema.array(),
        buisnessLogic: async (req: Request, res: Response, next?: NextFunction) => await getAllTodos(),
    }),
);

export default todoRoute;




