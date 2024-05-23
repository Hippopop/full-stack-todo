import cors from "cors";
import * as dotenv from "dotenv";
import bodyParser from "body-parser";
import authRoute from "./routes/auth/auth-apis";
import todoRoute from "./routes/todo/todo-apis";

import { readFile } from "fs/promises";
import express, { NextFunction, Request, Response } from "express";
import { tokenRoute } from "./routes/token/token";

dotenv.config();
const app = express();
const port = process.env.PORT ?? 8080;

app.use(cors());
app.use(bodyParser.json()); // ** app.use(express.json()); **// @latest Express(since 4.16.0)!
app.use(bodyParser.urlencoded({ extended: false })); // ** app.use(express.urlencoded()); **// @latest Express(since 4.16.0)!

/* API Routes! */
app.use("/auth", authRoute);
app.use("/todos", todoRoute);
app.use("/token", tokenRoute);

/* Rest of the handling! */
app.get("/", async function (req: Request, res: Response, next: NextFunction) {
  const file = await readFile("placeholder/placeholder.html", "utf8");
  res.send(file);
});

app.all("*", async function (req: Request, res: Response, next: NextFunction) {
  const file = await readFile("placeholder/not-found.html", "utf8");
  const formattedFile = file.replace("{%}", req.url);
  res.send(formattedFile);
});


app.listen(port, () =>
  console.log(`Listening on port ${port} // http://localhost:${port}/`)
);
