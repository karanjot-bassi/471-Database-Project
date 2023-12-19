/*

Resources : ( we didn't not copy the code straight up from here , we just tried to get some ideas on how stuff work)
1) help with setting up the login(connection to database) :  https://www.youtube.com/watch?v=Mn0rdbJPWEo 
2) HELP WITH CHECKING AND AUTH : https://stackoverflow.com/questions/52982877/import-sql-file-using-express-js 
*/



const express = require('express');
const session = require('express-session');
const path = require('path');
const ejs = require('ejs');




const app = express();
app.set('view engine', 'ejs');



const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));

//const connection = require('./db');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));


var mysql = require("mysql2");


// connect to the database 
var connection = mysql.createConnection({
    host: 'localhost',
    database: 'unisports',
    user: 'root',
    password: 'Uniting481fall'
    //password:'marwane123'
	//password: 'root'
});


app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));

app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.json());

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/index.html'));
})

// for student 
app.post('/shome', (req, res) =>{

    let username = req.body.username;
	let password = req.body.password;

    if (username && password) {
		// GET THE SQL QUERY DATA
		connection.query('SELECT * FROM student WHERE Student_id = ? AND Spassword = ?', [username, password], function(error, results, fields) {
			//REPORT ERROR 
			if (error) throw error;
			// If the account exists
			if (results.length > 0) {
				// Authenticate the user
				req.session.loggedin = true;
				req.session.password = password;
				req.session.Student_id= username;
				// Redirect to home page
				res.redirect('shome');
			} else {
				res.render('index', {error: 'Incorrect Username and/or Password'});
			}			
		});
	} else {
		res.render('index', {error: 'Please Enter in Username and or Password'});
	}

});



// for admin : 

app.get('/shome', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/shome.html'));
})



app.set('views', path.join(__dirname, 'views'));

app.get('/settings', (req, res) => {
    const Student_id = req.session.Student_id;

    // Retrieve the user's payment info from the database
    const selectQuery = 'SELECT Card_number FROM student_payment_info WHERE Student_id = ?';
    connection.query(selectQuery, [Student_id], (error, results, fields) => {
        if (error) {
            console.error('Error retrieving data from student_payment_info table:', error);
            res.render('settings', { error: 'Error in adding payment' });
            return;
        }

        // Check if the user has entered payment info
        if (results.length > 0) {
			req.session.Card_number = results[0].Card_number;
        } else {
			req.session.Card_number = undefined;
		}

        // Render the settings page and pass the cardNumber to the template
		console.log("Card ", req.session.Card_number);
        res.render('settings', { Card_number: req.session.Card_number, error: req.query.error });
    });
});


app.post('/settings', (req, res) => {
    // Extract user input from the form
    const Name_on_card = req.body.Name_on_card;
    const Card_number = req.body.Card_number;
    const Card_expire = req.body.Card_expire;
    const CVV = req.body.CVV;

    const Student_id = req.session.Student_id;

    // FORMATTED DATE :
    const rawDate = req.body.Card_expire;
    const dateArray = rawDate.split('/');
    const formattedDate = `${dateArray[2]}/${dateArray[1]}/${dateArray[0]}`;

    console.log("captured", Name_on_card, Card_number, Card_expire, CVV, Student_id);
    // Validate the input as needed

    
    const insertQuery = 'INSERT INTO student_payment_info (Student_id,Name_on_card, Card_number, Card_expire, CVV) VALUES (?, ?, ?, ?, ?)';
	connection.query(insertQuery, [Student_id, Name_on_card, Card_number, formattedDate, CVV], (error, results, fields) => {
        if (error) {
            console.error('Error inserting data into student_payment_info table:', error);
            res.redirect('/settings?error=Error%20in%20adding%20payment');
            return;
        }

		if (!Name_on_card || !Card_number || !Card_expire || !CVV) {
			res.redirect('/settings?error=Please%20fill%20out%20all%20fields');
			return;
		}

        // Data inserted successfully
		req.session.Card_number = Card_number;
		console.log('SQL Query Results:', results);

        res.redirect('/settings');
    });
});


app.post('/delete-card', (req, res) => {
    const Student_id = req.session.Student_id;

    
    const deleteQuery = 'DELETE FROM student_payment_info WHERE Student_id = ?';
    connection.query(deleteQuery, [Student_id], (error, results, fields) => {
        if (error) {
			console.error('Error deleting data from student_payment_info table:', error);
            res.status(500).send('Internal Server Error');
            return;
        }

        // Delete operation successful
        req.session.Card_number = undefined; // Clear the stored card number in the session
        console.log('Deleted card information for Student ID:', Student_id);

        
        res.redirect('/settings');
    });
});

app.set('views', path.join(__dirname, 'views'));
app.get('/equipment', (req, res) => {
	let equipmentData;
	let rentalEquipmentData;
  
	connection.query('SELECT * FROM Equipment', (error, results, fields) => {
	  if (error) {
		console.error('Error fetching equipment data from MySQL:', error);
		res.status(500).send('Internal Server Error');
		return;
	  }
	  equipmentData = results;
  
	  
	  if (rentalEquipmentData !== undefined) {
		renderEquipmentView();
	  }
	});
  
	connection.query('SELECT * FROM Rentable_equipment', (error, results, fields) => {
	  if (error) {
		console.error('Error fetching rental equipment data from MySQL:', error);
		res.status(500).send('Internal Server Error');
		return;
	  }
	  rentalEquipmentData = results;
  
	  
	  if (equipmentData !== undefined) {
		renderEquipmentView();
	  }
	});
  
	function renderEquipmentView() {
	  res.render('equipment', { equipmentData, rentalEquipmentData, itemId:''});
	}
  });



/*
app.get('/book', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/book.html'));
})*/

app.set('views', path.join(__dirname, 'views'));
app.get('/book', (req, res) => {
	connection.query('SELECT * FROM Location', (error, results, fields) => {
	  if (error) {
		console.error('Error fetching location data from MySQL:', error);
		res.status(500).send('Internal Server Error');
		return;
	  }
	  const locationData = results;
	  // Render the template with the data
	  res.render('book', { locationData });
	});
});



app.set('views', path.join(__dirname, 'views'));
app.get('/programs', (req, res) => {
	connection.query('SELECT * FROM Program', (error, results, fields) => {
		if (error) {
		console.error('Error fetching equipment data from MySQL:', error);
		res.status(500).send('Internal Server Error');
		return;
		}
		const ProgramsData = results;
		// Render the template with the data
		res.render('programs', { ProgramsData });
	});
});



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
				res.render('adminsignin', {error: 'Incorrect Username and/or Password'});
			}			
		});
	} else {
		res.render('adminsignin', {error: 'Please Enter in Username and or Password'});
		res.end();
	}

});


app.get('/adminhome', (req, res) => {
    res.sendFile(path.join(__dirname, 'pages/adminhome.html'));
})






// TRYING TO SET UP SOME ACTIONS FOR THE PURCAHSE BUTTON 
app.post('/equipment/confirmPurchase', (req, res) => {
	const itemId = req.body.itemId;
	const studentId = req.session.Student_id; // Assuming you have a student ID in the session
  
	// Perform the necessary SQL update for the purchase confirmation
	const updateQuery = 'INSERT INTO purchased (Equipment_id, Student_id) VALUES (?, ?);';
  
	connection.query(updateQuery, [itemId, studentId], (error, results, fields) => {
	  if (error) {
		console.error('Error updating data in the table:', error);
		res.json({ success: false, error: 'Internal Server Error' });
		return;
	  }
  
	  // Data updated successfully
	  console.log('SQL Query Results:', results);
	  res.json({ success: true, message: 'Purchase confirmed successfully!' });
	});
});



app.post('/equipment/confirmRental', (req, res) => {
    const itemId = req.body.itemId;
    const selectedDates = req.body.selectedDates;

    // Validate and process the data as needed

	
    // Perform the necessary SQL insert for the rental confirmation
    const insertQuery = 'INSERT INTO Equipment_rental (Equipment_id, selectedDates) VALUES (?, ?)';

    connection.query(insertQuery, [itemName, selectedDates], (error, results, fields) => {
        if (error) {
            console.error('Error inserting data into the Equipment_rental table:', error);
            res.json({ success: false, error: 'Internal Server Error' });
            return;
        }

        // Data inserted successfully
        console.log('SQL Query Results:', results);
        res.json({ success: true, message: 'Rental confirmed successfully!' });
    });
});

function generateHourOptions() {
	let options = '';
	for (let hour = 0; hour < 24; hour++) {
	  options += `<option value="${hour}">${hour}:00</option>`;
	}
	return options;
}


const port = process.env.PORT || 3000;

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
    connection.connect(function(err){
        if(err) throw err;
        console.log('Database connected');
    });
});