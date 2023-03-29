"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const promise_1 = __importDefault(require("mysql2/promise"));
/***
You can create a single connection, and use that for `query` data.
Or you can create a `[Pool]` configeration and use the `[Pool]` generated from that configeration.

The difference between these two ways, is a `[Pool]` will cache the connectiontions and keep some of the resources alive,
inorder to reduce the time of establishing a new connection.
["Using connection pools - npm(mysql2)"](https://www.npmjs.com/package/mysql2#using-connection-pools).
***/
const connection = promise_1.default.createPool({
    connectionLimit: 10,
    user: process.env.USER,
    host: process.env.SQLHOST,
    database: process.env.DATABASE,
    password: process.env.PASSWORD,
});
exports.default = connection;
//# sourceMappingURL=mysql-config.js.map