var mysql = require("mysql2");

var connection = mysql.createConnection({
    host: 'localhost',
    database: 'unisports',
    user: 'root',
    password: 'Uniting481fall'
});


connection.query('SELECT * FROM student', function (error, results, fields) {
    if (error) {
        console.log('Error in executing query:', error);
    } else {
        console.log('Contents of "student":', results);
    }
    connection.end();
});

module.exports = connection;

