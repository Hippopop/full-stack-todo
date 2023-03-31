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
const dotenv = __importStar(require("dotenv"));
const promise_1 = __importDefault(require("mysql2/promise"));
/***
You can create a single connection, and use that for `query` data.
Or you can create a `[Pool]` configeration and use the `[Pool]` generated from that configeration.

The difference between these two ways, is a `[Pool]` will cache the connectiontions and keep some of the resources alive,
inorder to reduce the time of establishing a new connection.
["Using connection pools - npm(mysql2)"](https://www.npmjs.com/package/mysql2#using-connection-pools).
***/
dotenv.config();
const connection = promise_1.default.createPool({
    connectionLimit: 10,
    port: parseInt(process.env.SQLPORT ?? '3306'),
    user: process.env.SQLUSER,
    host: process.env.SQLHOST,
    database: process.env.DATABASENAME,
    password: process.env.SQLPASSWORD,
});
exports.default = connection;
//# sourceMappingURL=mysql-config.js.map