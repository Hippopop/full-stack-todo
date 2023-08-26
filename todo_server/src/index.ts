import cors from "cors";
import * as dotenv from "dotenv";
import bodyparser from "body-parser";
import authRoute from "./routes/auth/auth";
import todoRoute from "./routes/todo/todo-apis";

import { readFile } from "fs/promises";
import express, { NextFunction, Request, Response } from "express";
import tokenRoute from "./routes/token/token";

dotenv.config();
const app = express();
const port = process.env.PORT ?? 8080;

app.use(cors());
app.use(bodyparser.json()); // ** app.use(express.json()); **// @latest Express(since 4.16.0)!
app.use(bodyparser.urlencoded({ extended: false })); // ** app.use(express.urlencoded()); **// @latest Express(since 4.16.0)!

/* API Routes! */
app.use("/auth", authRoute);
app.use("/todos", todoRoute);
app.use("/token", tokenRoute);

/* Rest of the handling! */
app.get("/", async function (req: Request, res: Response, next: NextFunction) {
  res.send(await readFile("placeholder/placeholder.html", "utf8"));
});

app.listen(port, () =>
  console.log(`Listening on port ${port} // http://localhost:${port}/`)
);
