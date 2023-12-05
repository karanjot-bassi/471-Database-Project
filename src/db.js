var mysql = require("mysql2");

var connection = mysql.createConnection({
    host: 'localhost',
    database: 'unisports',
    user: 'root',
    password: 'Uniting481fall'
});

module.exports = connection;

