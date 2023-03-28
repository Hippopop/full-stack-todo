import bodyparser from 'body-parser';
import { readFile } from "fs/promises";
import todoRoute from './routes/todo/todo-apis';
import express, { NextFunction, Request, Response } from "express";

const port = 5001;
const app = express();

app.use(bodyparser.json());
app.use(bodyparser.urlencoded({ extended: false }));


app.use('/todo', todoRoute);
app.get('/', async function (req: Request, res: Response, next: NextFunction) {
    res.send(await readFile('placeholder/placeholder.html', 'utf8'));
});

app.listen(port, () =>
    console.log(`Listening on port ${port} // http://localhost:${port}/`),
);