import cors from 'cors';
import * as dotenv from 'dotenv';
import bodyparser from 'body-parser';
import { readFile } from "fs/promises";
import todoRoute from './routes/todo/todo-apis';
import express, { NextFunction, Request, Response } from "express";


dotenv.config();
const app = express();
const port = 8080/* process.env.PORT ?? 3001 */;

app.use(cors());
app.use(bodyparser.json()); // ** app.use(express.json()); **// @latest Express(since 4.16.0)!
app.use(bodyparser.urlencoded({ extended: false })); // ** app.use(express.urlencoded()); **// @latest Express(since 4.16.0)!

app.use('/todos', todoRoute);
app.get('/', async function (req: Request, res: Response, next: NextFunction) {
    res.send(await readFile('placeholder/placeholder.html', 'utf8'));
});

app.listen(port, () =>
    console.log(`Listening on port ${port} // http://localhost:${port}/`),
);