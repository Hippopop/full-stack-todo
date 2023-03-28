import mysql from 'mysql2/promise'
/***  
You can create a single connection, and use that for `query` data. 
Or you can create a `[Pool]` configeration and use the `[Pool]` generated from that configeration.

The difference between these two ways, is a `[Pool]` will cache the connectiontions and keep some of the resources alive,
inorder to reduce the time of establishing a new connection.
["Using connection pools - npm(mysql2)"](https://www.npmjs.com/package/mysql2#using-connection-pools).
***/
const connection = mysql.createPool({
    connectionLimit: 10,
    host: "localhost",
    database: "full_stack_todo",
    user: "root",
    password: "",
});

export default connection;