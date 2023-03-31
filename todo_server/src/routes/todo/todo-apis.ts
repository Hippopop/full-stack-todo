import { NextFunction, Request, Response, Router } from "express";
import { getAllTodos } from "../../database/todo";
import { wrapperFunction } from "../../types/response-z";
import { TODOSchema } from "../../types/todo-z";

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




