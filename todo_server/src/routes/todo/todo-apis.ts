import { NextFunction, Request, Response, Router } from "express";
import { getAllTodos } from "../../database/todo";
import { wrapperFunction } from "../../types/response-z";
import { TODO, TODOSchema } from "../../types/todo-z";
import { log } from "console";

const todoRoute = Router();

todoRoute.get(
    '/all',
    wrapperFunction({
        errorMsg: "Sorry! Couldn't get the TODOs.",
        successMsg: 'Request Successful! Got the TODOs.',
        schema: TODOSchema.array(),
        buisnessLogic: async (req: Request, res: Response, next?: NextFunction) => await getAllTodos(),
    }),
);

todoRoute.post(
    '/add',
    wrapperFunction({
        errorMsg: "Sorry! Couldn't add the TODO.",
        successMsg: 'Request Successful! Added the TODO.',
        schema: TODOSchema,
        buisnessLogic: async (req: Request, res: Response, next?: NextFunction) => {
            console.log(req.body);
            console.log(req.params);
            const todo = TODOSchema.safeParse(req.body);
            if (todo.success) {

                log(todo);
            } else {
                log(todo);
                log(todo.error);
            }
            return Promise.resolve({ title: 'Test Title', state: 'active', priority: 'high' });
        },
    }),
);

export default todoRoute;




