var mysql = require("mysql2");

var connection = mysql.createConnection({
    host: 'localhost',
    database: 'unisports',
    user: 'root',
    //password: 'Uniting481fall'
    password:'marwane123'
});



connection.query('SELECT * FROM student WHERE Student_id = ? AND password = ?', [username,password], function (error, results, fields) {
    if (error) {
        console.log('Error in executing query:', error);
    }
    if(results.length > 0) {
        //test the data ; 
        //console.log('Contents of "student":', results);

        req.session.loggedin = true;
        req.username = username;

        res.redirect('/shome');
    }
    else{
        res.send("incorrect username or password");
    }

    
    connection.end();
});

module.exports = connection;

