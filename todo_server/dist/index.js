"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const cors_1 = __importDefault(require("cors"));
const dotenv = __importStar(require("dotenv"));
const body_parser_1 = __importDefault(require("body-parser"));
const auth_apis_1 = __importDefault(require("./routes/auth/auth-apis"));
const todo_apis_1 = __importDefault(require("./routes/todo/todo-apis"));
const promises_1 = require("fs/promises");
const express_1 = __importDefault(require("express"));
const token_1 = require("./routes/token/token");
dotenv.config();
const app = (0, express_1.default)();
const port = process.env.PORT ?? 8080;
app.use((0, cors_1.default)());
app.use(body_parser_1.default.json()); // ** app.use(express.json()); **// @latest Express(since 4.16.0)!
app.use(body_parser_1.default.urlencoded({ extended: false })); // ** app.use(express.urlencoded()); **// @latest Express(since 4.16.0)!
/* API Routes! */
app.use("/auth", auth_apis_1.default);
app.use("/todos", todo_apis_1.default);
app.use("/token", token_1.tokenRoute);
/* Rest of the handling! */
app.get("/", async function (req, res, next) {
    const file = await (0, promises_1.readFile)("placeholder/placeholder.html", "utf8");
    res.send(file);
});
app.all("*", async function (req, res, next) {
    const file = await (0, promises_1.readFile)("placeholder/not-found.html", "utf8");
    const formattedFile = file.replace("{%}", req.url);
    res.send(formattedFile);
});
app.listen(port, () => console.log(`Listening on port ${port} // http://localhost:${port}/`));
//# sourceMappingURL=index.js.map