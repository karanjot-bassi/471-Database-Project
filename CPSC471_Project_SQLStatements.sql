/*
SQL Statements
Group: 12
Group Members: Karanjot Bassi, Nicole Nguyen, Marwane Zaoudi
*/

/*
This section deals with table creation.
*/

-- Creates table of program administrators
CREATE TABLE Admin (
    Employee_id CHAR(8) PRIMARY KEY,
    First_name VARCHAR(20) NOT NULL,
    Last_name VARCHAR(20) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL
);

-- Creates table of students in system
CREATE TABLE Student (
    Student_id CHAR(8) PRIMARY KEY,
    First_name VARCHAR(20) NOT NULL,
    Last_name VARCHAR(20) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Account_balance DECIMAL(10, 2) NOT NULL,
    Employee_id INT,
FOREIGN KEY (Employee_id) REFERENCES Admin(Employee_id)
ON DELETE SET NULL
);

-- Creates table of student payment info
CREATE TABLE Student_payment_info (
    Student_id CHAR(8) NOT NULL,
    Name_on_card VARCHAR(20) NOT NULL,
    Card_number VARCHAR(16) NOT NULL,
    Card_expire DATE NOT NULL,
    CVV VARCHAR(4) NOT NULL,
);

-- Creates a table of all processed payments
    CREATE TABLE Payment (
    Invoiceid CHAR(8) PRIMARY KEY,
    Student_id CHAR(8),
FOREIGN KEY (Student_id) REFERENCES Student (student_id) ON DELETE
CASCADE
);

-- Creates a table of all the programs students are registered for
CREATE TABLE Registers_for (
    Student_id CHAR(8) NOT NULL,
    Program_id CHAR(4) NOT NULL,
FOREIGN KEY (Student_id) REFERENCES Student(Student_id) ON DELETE
CASCADE,
FOREIGN KEY (Program_id) REFERENCES Program(Program_id) ON DELETE
CASCADE
);

-- Creates a table of all the program offerings
CREATE TABLE Program (
    Program_id CHAR(4) PRIMARY KEY,
    Price DECIMAL(7, 2) NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Start_date DATE NOT NULL,
    End_date DATE NOT NULL,
    Available_slots INT NOT NULL,
    Description TEXT,
    Location_id CHAR(4) NOT NULL,
FOREIGN KEY (Location_id) REFERENCES Location(Location_id) ON DELETE SET
NULL
);

-- Creates a table of all the bookings made by students
CREATE TABLE Bookings (
    Booking_id CHAR(6) PRIMARY KEY,
    Booking_date DATE NOT NULL,
    Booking_duration VARCHAR(8) NOT NULL,
    Employee_id CHAR(8) NOT NULL,
    Location_id CHAR(4) NOT NULL,
    Student_id CHAR(8) NOT NULL,
FOREIGN KEY (Employee_id) REFERENCES Admin(Employee_id) ON DELETE SET
NULL,
FOREIGN KEY (Location_id) REFERENCES Location(Location_id) ON DELETE SET
NULL,
FOREIGN KEY (Student_id) REFERENCES Student(Student_id) ON DELETE
CASCADE
);

-- Creates a table of all possible booking locations
CREATE TABLE Location (
    Location_id CHAR(4) PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
);

-- Creates a table of the equipment inventory
CREATE TABLE Equipment (
    Equipment_id CHAR(4) PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Equipment_description TEXT,
    Amt_in_stock INT NOT NULL,
    Sport_category VARCHAR(50)
);

-- Creates a table of all the rentable equipment
CREATE TABLE Rentable (
    Equipment_id CHAR(4) NOT NULL,
    Rent_price DECIMAL(7, 2) NOT NULL,
    Max_duration VARCHAR(10) NOT NULL,
FOREIGN KEY (Equipment_id) REFERENCES Equipment (Equipment_id) ON DELETE
CASCADE
);

-- Creates a table of all the buyable equipment
CREATE TABLE Buyable (
    Equipment_id CHAR(4) NOT NULL,
    Purchase_price DECIMAL(7, 2) NOT NULL,
FOREIGN KEY (Equipment_id) REFERENCES Equipment (Equipment_id) ON DELETE
CASCADE
);

-- Creates a table of all equpiment rentals by students
CREATE TABLE Equipment_rental (
    Equipment_id CHAR(4) NOT NULL,
    Student_id CHAR(8) NOT NULL,
    RentalID CHAR(6) NOT NULL,
    Item_amt INT NOT NULL,
    Rental_date DATE NOT NULL,
    Pickup_date DATE NOT NULL,
    Expected_return_date DATE,
    Actual_return_date DATE,
FOREIGN KEY (Equipment_id) REFERENCES Equipment(Equipment_id) ON DELETE
CASCADE,
FOREIGN KEY (Student_id) REFERENCES Student(Student_id) ON DELETE
CASCADE
);

/* End of table creation section */

/* Beginning of sample data */
-- Admin sample data
INSERT INTO Admin (Employee_id, First_name, Last_name, Email, Phone) VALUES
    (A0000001, 'Admin', 'Admin', 'admin@ucalgary.ca', '403-100-1000'),
    (A0000002, 'Tim', 'Jones', 'johnjones@ucalgary.ca', '403-200-2000'),
    (A0000003, 'Sarah', 'John', 'sarahjohn@ucalgary.ca', '403-300-3000'),
    (A0000004, 'John', 'Doe', 'johndoe@ucalgary.ca', '403-400-4000')

-- Student sample data
INSERT INTO Student (Student_id, First_name, Last_name, Phone, Account_balance, Employee_id) VALUES 
    (S0011001, 'Lebron', 'James', 'lebronjames@ucalgary.ca', $0.00),
    (S0011002, 'Lionel', 'Messi', 'lionelmessi@ucalgary.ca', $0.00),
    (S0011003, 'Derrick', 'Rose', 'derrickrose@ucalgary.ca', $0.00),
    (S0011004, 'Cristiano', 'Ronaldo', 'cristianoronaldo@ucalgary.ca', $0.00)

-- Equipment sample data
INSERT INTO Equipment (Equipment_id, Name, Equipment_description, Amt_in_stock, Sport_category)VALUES
    (E001, 'Ball', 'Wilson Ball', 15, 'Basketball'),
    (E011, 'Ball', 'Wilson Ball (NEW)', 25, 'Basketball'),
    (E002, 'Ball', 'Spalding Ball', 10, 'Basketball'),
    (E003, 'Ball', 'Adidas Ball', 15, 'Soccer'),
    (E004, 'Squash racquet', 'Wilson', 20, 'Squash'),
    (E014, 'Squash racquet', 'Wilson (NEW)', 35, 'Squash'),
    (E005, 'Tennis racquet', 'Wilson', 15, 'Tennis'),
    (E015, 'Tennis racquet', 'Wilson (NEW)', 40, 'Tennis'),
    (E016, 'Goggles', 'Swimming Goggles', 50, 'Swimming'),
    (E009, 'Flippers', 'Speedo', 30, 'Swimming'),
    (E007, 'Bike', 'Mountain Bike', 50, 'Cycling'),
    (E008, 'Bike', 'Road Bike', 50, 'Cycling'),
    (E010, 'Volleyball', 'Mikasa', 15, 'Volleyball')

-- Rentable equipment sample data
INSERT INTO Rentable VALUES(R001, 0.00, '1 day')
INSERT INTO Rentable VALUES(R002, 0.00, '1 day')
INSERT INTO Rentable VALUES(R003, 0.00, '1 day')
INSERT INTO Rentable VALUES(R004, 2.00, '1 day')
INSERT INTO Rentable VALUES(R005, 2.00, '1 day')
INSERT INTO Rentable VALUES(R007, 40.00, '1 day')
INSERT INTO Rentable VALUES(R008, 30.00, '1 day')

-- Buyable equipment sample data
INSERT INTO Buyable VALUES(Q011, 35.00)
INSERT INTO Buyable VALUES(Q014, 60.00)
INSERT INTO Buyable VALUES(Q015, 70.00)
INSERT INTO Buyable VALUES(Q016, 25.00)

-- Location sample data
INSERT INTO Location VALUES (L001, 'Gold Gym')
INSERT INTO Location VALUES (L002, 'Red Gym')
INSERT INTO Location VALUES (L003, 'Jack simpson Gym')
INSERT INTO Location VALUES (L004, 'Swimming Center')
INSERT INTO Location VALUES (L005, 'Bouldering Wall')
INSERT INTO Location VALUES (L006, 'Weight Gym')
INSERT INTO Location VALUES (L007, 'Courts')

-- Bookings sample data
INSERT INTO Bookings (B00001, 2023-10-05, 2 , 20011001, 0007, 10011003)
INSERT INTO Bookings (B00002, 2023-10-07, 2 , 20011001, 0005, 10011002)
INSERT INTO Bookings (B00003, 2023-10-18, 2 , 20011002, 0007, 10011003)

-- Program sample data
INSERT INTO Program VALUES (P001, 150.00, '3v3 Ball', 2023-09-9, 2023-12-6, 45, '3 on 3
Basketball tournament', 'Gold Gym')
INSERT INTO Program VALUES (P002, 50.00, 'Swim Lessons', 2023-10-5, 2023-10-12, 30,
'Beginner Lessons', 'Swimming Center')
INSERT INTO Program VALUES (P003, 5.00, 'Bouldering', 2023-11-09, 2023-11-09, 25, 'Group
Bouldering', 'Bouldering Wall')
INSERT INTO Program VALUES (P004, 80.00, 'Gym Training', 2023-01-07, 2023-04-06, 45,
'Group Training', 'Weight Gym')
INSERT INTO Program VALUES (P005, 15.00, 'Badminton', 2023-11-01, 2023-12-06, 45, NULL,
'Red Gym')
INSERT INTO Program VALUES (P006, 165.00, 'Volleyball', 2023-09-9, 2023-12-6, 45,
'Volleyball tournament', 'Jack Simpson')

-- Equipment rental sample data
INSERT INTO Equipment_rental (ER001, 10011001, E001, 1, 2023-09-13, 2023-09-13,
2023-09-13, 2023-09-13)
INSERT INTO Equipment_rental (ER002, 10011001, E011, 1, 2023-09-14, 2023-09-14,
2023-09-14, 2023-09-15)
INSERT INTO Equipment_rental (ER001, 10011002, ER00111, 2, 2023-12-04, 2023-12-04, NULL,
NULL)
INSERT INTO Equipment_rental (ER001, 10011001, 000001, 1, 2023-12-04, 2023-12-04, NULL,
NULL)

-- Program registration sample data
INSERT INTO Registers_for VALUES (10011001, P002)
INSERT INTO Registers_for VALUES (10011002, P003)
INSERT INTO Registers_for VALUES (10011001, P001)
INSERT INTO Registers_for VALUES (10011003, P006)