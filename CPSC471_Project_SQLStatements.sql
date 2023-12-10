/*
SQL Statements
Group: 12
Group Members: Karanjot Bassi, Nicole Nguyen, Marwane Zaoudi
*/

DROP DATABASE IF EXISTS UniSports;
CREATE DATABASE UniSports; 
USE UniSports;


/*
This section deals with table creation.
*/

-- Creates table of program administrators
CREATE TABLE Admin (
    Employee_id CHAR(8) PRIMARY KEY,
    First_name VARCHAR(20) NOT NULL,
    Last_name VARCHAR(20) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    EPassword VARCHAR(20) NOT NULL
);

-- Creates table of students in system
CREATE TABLE Student (
    Student_id CHAR(8) PRIMARY KEY,
    First_name VARCHAR(20) NOT NULL,
    Last_name VARCHAR(20) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Employee_id CHAR(8),
    SPassword VARCHAR(20) NOT NULL,
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
FOREIGN KEY (Student_id) REFERENCES Student (Student_id)
);

-- Creates a table of all processed payments
CREATE TABLE Payment (
    Invoiceid CHAR(8) PRIMARY KEY,
    Student_id CHAR(8),
FOREIGN KEY (Student_id) REFERENCES Student (student_id) ON DELETE
CASCADE
);


-- Creates a table of all possible booking locations
CREATE TABLE Location (
    Location_id CHAR(4) PRIMARY KEY,
    Name VARCHAR(20) NOT NULL
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
FOREIGN KEY (Location_id) REFERENCES Location(Location_id) ON DELETE CASCADE
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

-- Creates a table of all the bookings made by students
CREATE TABLE Bookings (
    Booking_id CHAR(6) PRIMARY KEY,
    Booking_date DATE NOT NULL,
    time VARCHAR(8) NOT NULL,
    Employee_id CHAR(8) NOT NULL,
    Location_id CHAR(4) NOT NULL,
    Student_id CHAR(8) NOT NULL,
FOREIGN KEY (Employee_id) REFERENCES Admin(Employee_id) ON DELETE CASCADE,
FOREIGN KEY (Location_id) REFERENCES Location(Location_id) ON DELETE CASCADE,
FOREIGN KEY (Student_id) REFERENCES Student(Student_id) ON DELETE
CASCADE
);

-- Creates a table of the equipment inventory
CREATE TABLE Equipment(
    Equipment_id CHAR(4) PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Equipment_description TEXT,
    Amt_in_stock INT NOT NULL,
    Price DECIMAL(7,2) NOT NULL,
    Sport_category VARCHAR(50)
);

-- Creates a table of all the rentable equipment
CREATE TABLE Rentable_equipment (
    REquipment_id CHAR(4) PRIMARY KEY,
    Rent_price DECIMAL(7, 2) NOT NULL,
    Max_duration VARCHAR(10) NOT NULL
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
FOREIGN KEY (Equipment_id) REFERENCES Rentable_equipment(REquipment_id) ON DELETE
CASCADE,
FOREIGN KEY (Student_id) REFERENCES Student(Student_id) ON DELETE
CASCADE
);

/* End of table creation section */

/* Beginning of sample data */
-- Admin sample data
INSERT INTO Admin (Employee_id, First_name, Last_name, Email, Phone, EPassword) VALUES
    ('A0000001', 'Admin', 'Admin', 'admin@ucalgary.ca', '403-100-1000', 'red'),
    ('A0000002', 'Tim', 'Jones', 'johnjones@ucalgary.ca', '403-200-2000', 'orange'),
    ('A0000003', 'Sarah', 'John', 'sarahjohn@ucalgary.ca', '403-300-3000', 'yellow'),
    ('A0000004', 'John', 'Doe', 'johndoe@ucalgary.ca', '403-400-4000', 'green');

-- Student sample data
INSERT INTO Student (Student_id, First_name, Last_name, Phone, SPassword) VALUES 
    ('S0011001', 'Lebron', 'James', '000-000-0000', 'blue'),
    ('S0011002', 'Lionel', 'Messi', '111-111-1111', 'purple'),
    ('S0011003', 'Derrick', 'Rose', '222-222-2222', 'red'),
    ('S0011004', 'Cristiano', 'Ronaldo', '333-333-3333', 'orange'),
    ('S0011005', 'DeMar', 'DeRozan', '444-444-4444', 'yellow');

-- Equipment sample data
INSERT INTO Equipment (Equipment_id, Name, Equipment_description, Amt_in_stock, Price, Sport_category)VALUES
    ('E001', 'Ball', 'Wilson Ball', 15, 60.00, 'Basketball'),
    ('E011', 'Ball', 'Wilson Ball (NEW)', 25, 75.00, 'Basketball'),
    ('E002', 'Ball', 'Spalding Ball', 10, 45.00, 'Basketball'),
    ('E003', 'Ball', 'Adidas Ball', 15, 30.00, 'Soccer'),
    ('E004', 'Squash racquet', 'Wilson', 20, 120.00, 'Squash'),
    ('E014', 'Squash racquet', 'Wilson (NEW)', 35, 150.00, 'Squash'),
    ('E005', 'Tennis racquet', 'Wilson', 15, 125.00, 'Tennis'),
    ('E015', 'Tennis racquet', 'Wilson (NEW)', 40, 145.00, 'Tennis'),
    ('E016', 'Goggles', 'Swimming Goggles', 50, 20.00, 'Swimming'),
    ('E009', 'Flippers', 'Speedo', 30, 75.00, 'Swimming'),
    ('E007', 'Bike', 'Mountain Bike', 50, 1200, 'Cycling'),
    ('E008', 'Bike', 'Road Bike', 50, 1500.00, 'Cycling'),
    ('E010', 'Volleyball', 'Mikasa', 15, 80.00, 'Volleyball'),
    ('E020', 'Volleyball', 'Mikasa (NEW)', 15, 120.00, 'Volleyball');
    
-- Rentable equipment sample data
INSERT INTO Rentable_equipment (REquipment_id, Rent_price, Max_duration) VALUES
    ('RE01', 0.00, '1 day'),
    ('RE02', 0.00, '1 day'),
    ('RE03', 0.00, '1 day'),
    ('RE04', 2.00, '1 day'),
    ('RE05', 2.00, '1 day'),
    ('RE07', 40.00, '1 day'),
    ('RE08', 30.00, '1 day');

-- Location sample data
INSERT INTO Location (Location_id, Name) VALUES
    ('L001', 'Gold Gym'),
    ('L002', 'Red Gym'),
    ('L003', 'Jack Simpson Gym'),
    ('L004', 'Swimming Center'),
    ('L005', 'Bouldering Wall'),
    ('L006', 'Weight Gym'),
    ('L007', 'Courts');

-- Bookings sample data
INSERT INTO Bookings (Booking_id, Booking_date, time, Employee_id, Location_id, Student_id) VALUES
	('B00001', '2023-10-05', 2 , 'A0000001', 'L007', 'S0011003'),
	('B00002', '2023-10-07', 2 , 'A0000001', 'L005', 'S0011002'),
	('B00003', '2023-10-18', 2 , 'A0000002', 'L007', 'S0011003');

-- Program sample data
INSERT INTO Program 
	(Program_id, Price, Name, Start_date, End_date, Available_slots, Description, Location_id)
    VALUES
	('P001', 150.00, '3v3 Ball', '2023-09-9', '2023-12-6', 45, '3 on 3
	Basketball tournament', 'L001'),
	('P002', 50.00, 'Swim Lessons', '2023-10-5', '2023-10-12', 30,
	'Beginner Lessons', 'L004'),
	('P003', 5.00, 'Bouldering', '2023-11-09', '2023-11-09', 25, 'Group 
    Bouldering', 'L005'),
	('P004', 80.00, 'Gym Training', '2023-01-07', '2023-04-06', 45,
	'Group Training', 'L006'),
	('P005', 15.00, 'Badminton', '2023-11-01', '2023-12-06', 45, NULL,
	'L002'),
	('P006', 165.00, 'Volleyball', '2023-09-9', '2023-12-6', 45,
	'Volleyball tournament', 'L003');

-- Equipment rental sample data
INSERT INTO Equipment_rental (Equipment_id, Student_id, RentalID, Item_amt, Rental_date, Pickup_date, Expected_return_date, Actual_return_date)VALUES
	('RE01', 'S0011001', 'R00001', 1, '2023-09-13', '2023-09-13', '2023-09-13', '2023-09-13'),
	('RE02', 'S0011001', 'R00011', 1, '2023-09-14', '2023-09-14', '2023-09-14', '2023-09-15'),
	('RE01', 'S0011002', 'R00111', 2, '2023-12-04', '2023-12-04', NULL, NULL),
	('Re01', 'S0011001', 'R01111', 1, '2023-12-04', '2023-12-04', NULL, NULL);

-- Program registration sample data
INSERT INTO Registers_for (Student_id, Program_id) VALUES
	('S0011001', 'P002'),
	('S0011002', 'P003'),
	('S0011001', 'P001'),
	('S0011003', 'P006');