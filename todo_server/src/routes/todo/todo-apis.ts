import { NextFunction, Request, Response, Router } from "express";
import {
  deleteTodo,
  getAllTodos,
  insertTodo,
  updateTodo,
} from "../../database/todo";
import { TODOSchema } from "../../types/todo/todo-z";
import { wrapperFunction } from "../request-handler";
import z from "zod";
import {
  success,
  successfullyChanged,
  successfullyCreated,
  successfullyDeleted,
} from "../../Errors/error_codes";

const todoRoute = Router();

todoRoute.get(
  "/all",
  wrapperFunction({
    authenticate: true,
    successCode: success,
    errorMsg: "Sorry! Couldn't get the TODOs.",
    successMsg: "Request Successful! Got the TODOs.",
    schema: TODOSchema.array(),
    buisnessLogic: async (req: Request, res: Response, next?: NextFunction) =>
      await getAllTodos(),
  })
);

todoRoute.post(
  "/add",
  wrapperFunction({
    successCode: successfullyCreated,
    errorMsg: "Sorry! Couldn't add the TODO.",
    successMsg: "Request Successful! Added the TODO.",
    schema: TODOSchema,
    buisnessLogic: async (req: Request, res: Response, next?: NextFunction) => {
      const todo = TODOSchema.safeParse(req.body);
      if (todo.success) {
        return await insertTodo(todo.data);
      } else {
        throw todo.error;
      }
    },
  })
);

/* 
This request takes data in raw [JSON] format. I've tried to make it work with [application/x-www-form-urlencoded] but apparently
in that format you can't differentiate between [String] and [Number]. So, I've decided to use [application/json] instead.
Example:
{
  "delete": [1, 2, 3] (or) 1,
}
*/
todoRoute.delete(
  "/delete",
  wrapperFunction({
    successCode: successfullyDeleted,
    errorMsg: "Sorry! Couldn't Delete.",
    successMsg: "Request Successful! Deleted the TODO(s).",
    schema: z.object({
      deleted: z.number().or(z.array(z.number())),
    }),
    buisnessLogic: async (req: Request, res: Response, next?: NextFunction) => {
      // *** This here will accept one single [TODO], or multiple [TODO]s to delete at once.
      const expectedSchema = z.object({
        delete: z.number().or(z.array(z.number())),
      });
      console.log(req.body);
      const purifiedBody = expectedSchema.safeParse(req.body);
      if (purifiedBody.success) {
        const result = await deleteTodo(purifiedBody.data.delete);
        return { deleted: result };
      } else {
        throw purifiedBody.error;
      }
    },
  })
);

/** Same Issue as [delete()] **/
todoRoute.put(
  "/update",
  wrapperFunction({
    successCode: successfullyChanged,
    errorMsg: "Sorry! Couldn't update the TODO.",
    successMsg: "Request Successful! Updated the TODO.",
    schema: TODOSchema,
    buisnessLogic: async (req: Request, res: Response, next?: NextFunction) => {
      const todo = TODOSchema.required({ id: true }).safeParse(req.body);
      if (todo.success) {
        return await updateTodo(todo.data);
      } else {
        throw todo.error;
      }
    },
  })
);

export default todoRoute;
