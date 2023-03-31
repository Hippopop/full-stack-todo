import * as dotenv from "dotenv";
import mysql from 'mysql2/promise'
/***  
You can create a single connection, and use that for `query` data. 
Or you can create a `[Pool]` configeration and use the `[Pool]` generated from that configeration.

The difference between these two ways, is a `[Pool]` will cache the connectiontions and keep some of the resources alive,
inorder to reduce the time of establishing a new connection.
["Using connection pools - npm(mysql2)"](https://www.npmjs.com/package/mysql2#using-connection-pools).
***/
dotenv.config();
const connection = mysql.createPool({
    connectionLimit: 10,
    port: parseInt(process.env.SQLPORT ?? '3306'),
    user: process.env.SQLUSER,
    host: process.env.SQLHOST,
    database: process.env.DATABASENAME,
    password: process.env.SQLPASSWORD,
});

export default connection;