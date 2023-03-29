var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var _a;
import cors from 'cors';
import * as dotenv from 'dotenv';
import bodyparser from 'body-parser';
import { readFile } from "fs/promises";
import todoRoute from './routes/todo/todo-apis.js';
import express from "express";
dotenv.config();
const app = express();
const port = (_a = process.env.PORT) !== null && _a !== void 0 ? _a : 3001;
app.use(cors());
app.use(bodyparser.json()); // ** app.use(express.json()); **// @latest Express(since 4.16.0)!
app.use(bodyparser.urlencoded({ extended: false })); // ** app.use(express.urlencoded()); **// @latest Express(since 4.16.0)!
app.use('/todo', todoRoute);
app.get('/', function (req, res, next) {
    return __awaiter(this, void 0, void 0, function* () {
        console.log(`QUERY => ${JSON.stringify(req.query)}`);
        console.log(`BODY => ${JSON.stringify(req.body)}`);
        res.send(yield readFile('placeholder/placeholder.html', 'utf8'));
    });
});
app.listen(port, () => console.log(`Listening on port ${port} // http://localhost:${port}/`));
//# sourceMappingURL=index.js.map