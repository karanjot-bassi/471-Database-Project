Progress Report #3 - SQL Statements
Group: 12
Group Members: Karanjot Bassi, Nicole Nguyen, Marwane zaoudi
CREATE TABLE Admin (
Employee_id CHAR(8) PRIMARY KEY,
First_name VARCHAR(20) NOT NULL,
Last_name VARCHAR(20) NOT NULL,
Email VARCHAR(50) NOT NULL,
Phone VARCHAR(20) NOT NULL
);
CREATE TABLE Student (
Student_id CHAR(8) PRIMARY KEY,
First_name VARCHAR(20) NOT NULL,
Last_name VARCHAR(20) NOT NULL,
Phone VARCHAR(20) NOT NULL,
Account_balance DECIMAL(10, 2) NOT NULL,
Employee_id INT,
FOREIGN KEY (Employee_id) REFERENCES Admin(Employee_id) ON DELETE SET
NULL
);
CREATE TABLE Student_payment_info (
Student_id CHAR(8) NOT NULL,
Name_on_card VARCHAR(20) NOT NULL,
Card_number VARCHAR(16) NOT NULL,
Card_expire DATE NOT NULL,
CVV VARCHAR(4) NOT NULL,
);
CREATE TABLE Payment (
Invoiceid CHAR(8) PRIMARY KEY,
Student_id CHAR(8),
FOREIGN KEY (Student_id) REFERENCES Student (student_id) ON DELETE
CASCADE
);
CREATE TABLE Registers_for (
Student_id CHAR(8) NOT NULL,
Program_id CHAR(4) NOT NULL,
FOREIGN KEY (Student_id) REFERENCES Student(Student_id) ON DELETE
CASCADE,
FOREIGN KEY (Program_id) REFERENCES Program(Program_id) ON DELETE
CASCADE
);
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
CREATE TABLE Location (
Location_id CHAR(4) PRIMARY KEY,
Name VARCHAR(20) NOT NULL,
);
CREATE TABLE Equipment (
Equipment_id CHAR(4) PRIMARY KEY,
Name VARCHAR(20) NOT NULL,
Equipment_description TEXT,
Amt_in_stock INT NOT NULL,
Sport_category VARCHAR(50)
);
CREATE TABLE Rentable (
Equipment_id CHAR(4) NOT NULL,
Rent_price DECIMAL(7, 2) NOT NULL,
Max_duration VARCHAR(10) NOT NULL,
FOREIGN KEY (Equipment_id) REFERENCES Equipment (Equipment_id) ON DELETE
CASCADE
);
CREATE TABLE Buyable (
Equipment_id CHAR(4) NOT NULL,
Purchase_price DECIMAL(7, 2) NOT NULL,
FOREIGN KEY (Equipment_id) REFERENCES Equipment (Equipment_id) ON DELETE
CASCADE
);
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
INSERT INTO Admin VALUES (20011001, ‘Admin’, ‘Admin’, ‘admin@ucalgary.ca’,
‘403-100-1000’)
INSERT INTO Admin VALUES (20011002, ‘Tim’, ‘Jones’, ‘johnjones@ucalgary.ca’,
‘403-200-2000’)
INSERT INTO Admin VALUES (20011003, ‘Sarah’, ‘John’, ‘sarahjohn@ucalgary.ca’,
‘403-300-3000’)
INSERT INTO Student VALUES(10011001, ‘Lebron’, ‘James’, ‘lebronjames@ucalgary.ca’,
$0.00)
INSERT INTO Student VALUES(10011002, ‘Lionel’, ‘Messi’, ‘lionelmessi@ucalgary.ca’, $0.00)
INSERT INTO Student VALUES(10011003, ‘Derrick’, ‘Rose’, ‘derrickrose@ucalgary.ca’, $0.00)
INSERT INTO Equipment VALUES (0001, ‘Ball’, ‘Wilson Ball’, 15, ‘Basketball’)
INSERT INTO Equipment VALUES (0011, ‘Ball’, ‘Wilson Ball (NEW)’, 25, ‘Basketball’)
INSERT INTO Equipment VALUES (0002, ‘Ball’, Spalding Ball’, 10, ‘Basketball’)
INSERT INTO Equipment VALUES (0003, ‘Ball’, ‘Adidas Ball’, 15, ‘Soccer’)
INSERT INTO Equipment VALUES (0004, ‘Squash racquet, ‘Wilson’, 20, ‘Squash’)
INSERT INTO Equipment VALUES (0014, ‘Squash racquet, ‘Wilson (NEW)’, 35, ‘Squash’)
INSERT INTO Equipment VALUES (0005, ‘Tennis racquet’, ‘Wilson’, 15, ‘Tennis’)
INSERT INTO Equipment VALUES (0015, ‘Tennis racquet’, ‘Wilson (NEW)’, 40, ‘Tennis’)
INSERT INTO Equipment VALUES (0016, ‘Goggles’, ‘Swimming Goggles’, 50, ‘Swimming’)
INSERT INTO Equipment VALUES (0007, ‘Bike’, ‘Mountain Bike’, 50, ‘Cycling’)
INSERT INTO Equipment VALUES (0008, ‘Bike’, ‘Road Bike’, 50, ‘Cycling’)
INSERT INTO Rentable VALUES(0001, 0.00, ‘1 day’)
INSERT INTO Rentable VALUES(0002, 0.00, ‘1 day’)
INSERT INTO Rentable VALUES(0003, 0.00, ‘1 day’)
INSERT INTO Rentable VALUES(0004, 2.00, ‘1 day’)
INSERT INTO Rentable VALUES(0005, 2.00, ‘1 day’)
INSERT INTO Rentable VALUES(0007, 40.00, ‘1 day’)
INSERT INTO Rentable VALUES(0008, 30.00, ‘1 day’)
INSERT INTO Buyable VALUES(0011, 35.00)
INSERT INTO Buyable VALUES(0014, 60.00)
INSERT INTO Buyable VALUES(0015, 70.00)
INSERT INTO Buyable VALUES(0016, 25.00)
INSERT INTO Location VALUES (0001, ‘Gold Gym’)
INSERT INTO Location VALUES (0002, ‘Red Gym’)
INSERT INTO Location VALUES (0003, ‘Jack simpson Gym’)
INSERT INTO Location VALUES (0004, ‘Swimming Center’)
INSERT INTO Location VALUES (0005, ‘Bouldering Wall’)
INSERT INTO Location VALUES (0006, ‘Weight Gym’)
INSERT INTO Location VALUES (0007, ‘Courts’)
INSERT INTO Bookings (000001, 2023-10-05, 2 Hours, 20011001, 0007, 10011003)
INSERT INTO Bookings (000002, 2023-10-07, 2 Hours, 20011001, 0005, 10011002)
INSERT INTO Bookings (000003, 2023-10-18, 2 Hours, 20011002, 0007, 10011003)
INSERT INTO Program VALUES (0001, 150.00, ‘3v3 Ball’, 2023-09-9, 2023-12-6, 45, ‘3 on 3
Basketball tournament’, ‘Gold Gym’)
INSERT INTO Program VALUES (0002, 50.00, ‘Swim Lessons’, 2023-10-5, 2023-10-12, 30,
‘Beginner Lessons’, ‘Swimming Center’)
INSERT INTO Program VALUES (0003, 5.00, ‘Bouldering’, 2023-11-09, 2023-11-09, 25, ‘Group
Bouldering’, ‘Bouldering Wall’)
INSERT INTO Program VALUES (0004, 80.00, ‘Gym Training’, 2023-01-07, 2023-04-06, 45,
‘Group Training’, ‘Weight Gym’)
INSERT INTO Program VALUES (0005, 15.00, ‘Badminton’, 2023-11-01, 2023-12-06, 45, NULL,
‘Red Gym’)
INSERT INTO Program VALUES (0006, 165.00, ‘Volleyball’, 2023-09-9, 2023-12-6, 45,
‘Volleyball tournament’, ‘Jack Simpson’)
INSERT INTO Equipment_rental (0001, 10011001, 000001, 1, 2023-09-13, 2023-09-13,
2023-09-13, 2023-09-13)
INSERT INTO Equipment_rental (0002, 10011001, 000011, 1, 2023-09-14, 2023-09-14,
2023-09-14, 2023-09-15)
INSERT INTO Equipment_rental (0001, 10011002, 000111, 2, 2023-12-04, 2023-12-04, NULL,
NULL)
INSERT INTO Equipment_rental (0001, 10011001, 000001, 1, 2023-12-04, 2023-12-04, NULL,
NULL)
INSERT INTO Registers_for VALUES (10011001, 0002)
INSERT INTO Registers_for VALUES (10011002, 0003)
INSERT INTO Registers_for VALUES (10011001, 0001)
INSERT INTO Registers_for VALUES (10011003, 0006)