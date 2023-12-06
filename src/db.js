
var dotenv = require("dotenv");
dotenv.config();
var mysql = require("mysql2");

var connection = mysql.createConnection({
    host: process.env.MYSQL_HOST,
    database: process.env.MYSQL_DATABASE,
    user: process.env.MYSQL_USER,
    //password: 'Uniting481fall'
    password: process.env.MYSQL_PASSWORD
});


connection.query('SELECT * FROM student', function (error, results, fields) {
    if (error) {
        console.log('Error in executing query:', error);
    } else {
        console.log('Contents of "student":', results);
    }
    connection.end();
});

async function getEquipment (){
    const [rows] = connection.query('SELECT * from equipment', function (error, results, fields){
        if (error) {
            console.log('Error in executing query:', error);
        } else {
            return rows;
        }
        connection.end();
});
}

module.exports = connection;
