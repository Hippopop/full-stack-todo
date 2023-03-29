var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { Router } from "express";
import { getAllTodos } from "../../database/todo.js";
import { wrapperFunction } from "../../types/response-z.js";
import { TODOSchema } from "../../types/todo-z.js";
const todoRoute = Router();
todoRoute.get('/all_todos', wrapperFunction({
    errorMsg: "Sorry! Couldn't get the TODOs.",
    successMsg: 'Request Successful! Got the TODOs.',
    schema: TODOSchema.array(),
    buisnessLogic: (req, res, next) => __awaiter(void 0, void 0, void 0, function* () { return yield getAllTodos(); }),
}));
export default todoRoute;
//# sourceMappingURL=todo-apis.js.map