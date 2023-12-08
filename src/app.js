/*

Resources : 
1) help with setting up the login(connection to database) :  https://www.youtube.com/watch?v=Mn0rdbJPWEo 
2) HELP WITH CHECKING AND AUTH
*/

const express = require('express');
const session = require('express-session');
const path = require('path');
const app = express();


//const connection = require('./db');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));


var mysql = require("mysql2");

var connection = mysql.createConnection({
    host: 'localhost',
    database: 'UniSports',
    user: 'root',
    //password: 'Uniting481fall'
    password:'marwane123'
});



app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));



app.use(express.static(path.join(__dirname, 'public')));


app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/index.html'));
})

// for student 
app.post('/shome', (req, res) =>{

    let username = req.body.username;
	let password = req.body.password;

    // for testing purposes 
    //console.log("captured", username);
    // console.log("captured", password);

    if (username && password) {
		// GET THE SQL QUERY DATA
		connection.query('SELECT * FROM student WHERE Student_id = ? AND Spassword = ?', [username, password], function(error, results, fields) {
			// If there is an issue with the query, output the error
			if (error) throw error;
			// If the account exists
			if (results.length > 0) {
				// Authenticate the user
				req.session.loggedin = true;
				req.session.password = password;
				// Redirect to home page
				res.redirect('shome');
			} else {
				res.send('Incorrect Username and/or Password!');
			}			
		});
	} else {
		res.send('Please enter Username and Password!');
		res.end();
	}

});


// for admin : 




app.get('/shome', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/shome.html'));
})

app.get('/settings', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/settings.html'));
})

app.get('/equipment', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/equipment.html'));
})

app.get('/book', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/book.html'));
})

app.get('/programs', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/programs.html'));
})

app.get('/adminsignin', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/adminsignin.html'));
})


app.post('/adminhome', (req, res) =>{

    let username = req.body.username;
	let password = req.body.password;

    // for testing purposes 
    //console.log("captured", username);
    //console.log("captured", password);

    if (username && password) {
		// GET THE SQL QUERY DATA
		connection.query('SELECT * FROM Admin WHERE email = ? AND Epassword = ?', [username, password], function(error, results, fields) {


            // for testing 
            //console.log("captured", results);
			// If there is an issue with the query, output the error
			if (error) throw error;
			// If the account exists
			if (results.length > 0) {
				// Authenticate the user
				req.session.loggedin = true;
				req.session.password = password;
				// Redirect to home page
				res.redirect('adminhome');
			} else {
				res.send('Incorrect Username and/or Password!');
			}			
		});
	} else {
		res.send('Please enter Username and Password!');
		res.end();
	}

});

app.get('/adminhome', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/adminhome.html'));
})

app.get('/studentLU', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/studentLU.html'));
})

app.get('/buy', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/buy.html'));
})

const port = process.env.PORT || 3001;

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
    connection.connect(function(err){
        if(err) throw err;
        console.log('Database connected');
    });
});