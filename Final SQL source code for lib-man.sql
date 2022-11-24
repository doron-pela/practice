drop DATABASE if exists Library_management;

CREATE DATABASE Library_management;
use Library_management;

CREATE TABLE Authors(
	AuthorID int auto_increment,
    f_name varchar(50) NOT NULL,
    l_name varchar(50) NOT NULL,
    Gender char(2),
	Country varchar(20) NOT NULL,
	PRIMARY KEY (AuthorID)
  );
  
CREATE TABLE Patron (
  PatronID int auto_increment,
  First_name varchar(20) NOT NULL,
  Last_name varchar(20) NOT NULL,
  Contact_number varchar(15) UNIQUE NOT NULL,
  Gender char(2),
  DOB date,
  NationalID varchar(25) unique NOT NULL,
  Points int NOT NULL,
  PRIMARY KEY (PatronID)
);

  
CREATE TABLE Publisher (
  publisherID int auto_increment,
  publisher_name varchar(25) UNIQUE,
  address varchar(30),
  contact_number varchar(15) UNIQUE,
  country varchar(20),
  PRIMARY KEY (publisherID)
);


CREATE TABLE Room (
  RoomID int auto_increment,
  Capacity int,
  Room_name varchar(20) UNIQUE,
  PRIMARY KEY(RoomID)
);

CREATE TABLE Supplier (
  SupplierID int auto_increment,
  Sup_name varchar(30),
  Country varchar(20),
  Address_location varchar(30),
  PhoneNumber varchar(15) NOT NULL UNIQUE,
  PRIMARY KEY (SupplierID)
);


CREATE TABLE Department (
  Department_NO int auto_increment,
  Dept_name varchar(20),
  managerID int,
  PRIMARY KEY (Department_NO)
);


CREATE TABLE Book(
  ISBN varchar(13),
  PublisherID int,
  Book_name varchar(25),
  Quantity int,
  date_published datetime,
  PRIMARY KEY (ISBN),
  FOREIGN KEY (PublisherID) REFERENCES Publisher(publisherID) ON DELETE CASCADE
);
  
  
CREATE TABLE Book_Authors (
  AuthorID int,
  ISBN varchar(13),
  FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE,
  FOREIGN KEY (ISBN) REFERENCES Book(ISBN) ON DELETE CASCADE,
  Primary key (AuthorID, ISBN)
);


CREATE TABLE Employees (
  EmployeeID int auto_increment,
  Emp_f_name varchar(20),
  Emp_l_name varchar(20),
  Gender char(2),
  tel_number varchar(15) UNIQUE,
  DOB date,
  email varchar(30) UNIQUE,
  address varchar(40),
  Department_NO int,
  Salary int,
  PRIMARY KEY (EmployeeID),
  FOREIGN KEY (Department_NO) REFERENCES Department(Department_NO) ON DELETE SET NULL
);

Alter table Department ADD FOREIGN KEY (managerID) REFERENCES Employees(EmployeeID) ON DELETE SET NULL;



CREATE TABLE Electronic (
  AssetID int auto_increment,
  SupplierID int,
  Device_name varchar(30),
  date_of_purchase date,
  warrantee_exp_date date,
  Model varchar(20),
  PRIMARY KEY (AssetID),
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID) ON DELETE CASCADE
);


CREATE TABLE Elderly (
  PatronID int,
  email varchar(40) UNIQUE,
  next_of_kin varchar(20),
  next_of_kin_tel_number varchar(15),
  FOREIGN KEY (PatronID) references Patron(PatronID) ON DELETE CASCADE
);

CREATE TABLE Kids (
  PatronID int,
  Caretaker_name varchar(20),
  Caretaker_number varchar(15),
FOREIGN KEY (PatronID) references Patron(PatronID) ON DELETE CASCADE
);

CREATE TABLE Adults (
  PatronID int,
  email varchar(40) UNIQUE,
  Occupation varchar(25) default 'Unemployed',
   FOREIGN KEY (PatronID) references Patron(PatronID) ON DELETE CASCADE
);

CREATE TABLE Instance_of_Use (
  BorrowID int auto_increment,
  PatronID int,
  AssetID int,
  Time_of_borrow datetime,
  Time_of_return datetime,
  PRIMARY KEY (BorrowID),
  FOREIGN KEY (AssetID) REFERENCES Electronic(AssetID) ON DELETE CASCADE,
  FOREIGN KEY (PatronID) REFERENCES Patron(PatronID) ON DELETE CASCADE
);



CREATE TABLE Borrow (
  Borrow_number int auto_increment,
  PatronID int,
  ISBN varchar(13),
  date_taken datetime,
  date_returned datetime,
  Star_rating int,
  PRIMARY KEY (Borrow_number),
  FOREIGN KEY (PatronID) REFERENCES Patron(PatronID) ON DELETE CASCADE,
  FOREIGN KEY (ISBN) REFERENCES Book(ISBN) ON DELETE CASCADE
);


CREATE TABLE Room_Booking (
  BookingID int auto_increment,
  Booking_date date,
  PatronID int,
  RoomID int,
  Start_time time,
  End_time time,
  PRIMARY KEY (BookingID),
  FOREIGN KEY (RoomID) REFERENCES Room(RoomID) ON DELETE CASCADE,
  FOREIGN KEY (PatronID) REFERENCES Patron(PatronID) ON DELETE CASCADE
);



CREATE TABLE Token (
  TokenID int auto_increment,
  Reward varchar(30),
  SupplierID int,
  PRIMARY KEY (TokenID),
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID) ON DELETE CASCADE
);

CREATE TABLE Service (
  Date_of_service date,
  EmployeeID int,
  PatronID int,
  Rating int,
  primary key(Date_of_service, EmployeeID, PatronID),
  FOREIGN KEY (PatronID) REFERENCES Patron(PatronID) ON DELETE CASCADE,
  FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);

CREATE TABLE Patron_Rewards (
  TokenID int,
  PatronID int,
  Time_of_issue datetime,
  FOREIGN KEY (TokenID) REFERENCES Token(TokenID) ON DELETE CASCADE,
  FOREIGN KEY (PatronID) REFERENCES Patron(PatronID) ON DELETE CASCADE
);

 
Insert into Authors(f_name, l_name, Gender, Country) values ('Scott', 'Fitzgerald', 'M', 'USA');
Insert into Authors(f_name, l_name, Gender, Country) values ('David', 'Hume', 'M', 'USA');
Insert into Authors(f_name, l_name, Gender, Country) values ('J.R.R', 'Tolkein', 'M', 'UK');
Insert into Authors(f_name, l_name, Gender, Country) values ('Leo', 'Tolstoy', 'M', 'UK');
Insert into Authors(f_name, l_name, Gender, Country) values ('Joy', 'Lewis', 'F', 'UK');
Insert into Authors(f_name, l_name, Gender, Country) values ('J.K.', 'Rowling', 'F', 'USA');
Insert into Authors(f_name, l_name, Gender, Country) values ('Neon', 'Yang', 'NB', 'China');


Insert into Patron (First_name,Last_name,Contact_number,Gender,DOB,NationalID,Points) VALUES ('Manu', 'Kele', '+67852627', 'M', '2002-06-12', 'X23P45', 1);
Insert into Patron (First_name,Last_name,Contact_number,Gender,DOB,NationalID,Points) VALUES ('Maia', 'Kele', '+67852986', 'F', '1992-09-11', 'D67H89', 1);
Insert into Patron (First_name,Last_name,Contact_number,Gender,DOB,NationalID,Points) VALUES ('Pie', 'Kellerman', '+67838900', 'M', '2011-04-02', 'X09YU8', 1);
Insert into Patron (First_name,Last_name,Contact_number,Gender,DOB,NationalID,Points) VALUES ('Mali', 'Key', '+67834561', 'F', '2010-03-12', 'X93P85', 2);
Insert into Patron (First_name,Last_name,Contact_number,Gender,DOB,NationalID,Points) VALUES ('Cairo', 'Jam', '+67862626', 'M', '1960-06-23', 'X27645', 1);
Insert into Patron (First_name,Last_name,Contact_number,Gender,DOB,NationalID,Points) VALUES ('Eden', 'Frenzy', '+67847013', 'F', '1988-11-19', 'X2330F5', 1);

Insert into Publisher (publisher_name,address,contact_number,country) VALUES ('Steel LTD', '36 Dove str Omudade Abuja', '+23463728546', 'Nigeria');
Insert into Publisher (publisher_name,address,contact_number,country) VALUES ('Right brothers', '1244 hollywood bolivard', '+1555-0100', 'USA');
Insert into Publisher (publisher_name,address,contact_number,country) VALUES ('Razz Clan LTD', '221B Baker Street London', '+44-555-0100', 'UK');
Insert into Publisher (publisher_name,address,contact_number,country) VALUES ('Toron Wellis Corp', '335A Blue berry lane', '+2345500100', 'Switzerland');
Insert into Publisher (publisher_name,address,contact_number,country) VALUES ('James Boache and Sons LTD', '23 road Festac Town, Lagos', '+234-55-0100', 'Nigeria');


Insert into Room (Capacity, Room_name) VALUES (20, 'Wakanda');
Insert into Room (Capacity, Room_name) VALUES (50, 'Orwell');
Insert into Room (Capacity, Room_name) VALUES (20, 'Tommen');
Insert into Room (Capacity, Room_name) VALUES (15, 'Charity Bay');
Insert into Room (Capacity, Room_name) VALUES (30, 'Dewy Hollows');

Insert into Supplier (Sup_name,Country,Address_location,PhoneNumber) VALUES ('Sky Walk', 'Ghana', '264 Weija Accra', '+233 837365464');
Insert into Supplier (Sup_name,Country,Address_location,PhoneNumber) VALUES ('Eleven-30', 'Ghana', '567 Dansoaman', '+233926798464');
Insert into Supplier (Sup_name,Country,Address_location,PhoneNumber) VALUES ('Skyway Express', 'Switzerland', 'AA 43 Dowry lane Zurich', '+8839267964');
Insert into Supplier (Sup_name,Country,Address_location,PhoneNumber) VALUES ('Literary Bazaar', 'Nigeria', 'Close 24 Satellite Town', '+234926798464');
Insert into Supplier (Sup_name,Country,Address_location,PhoneNumber) VALUES ('Camp Lazlo LTD', 'Norway', '567 Doberman street Oslo', '+5790027917');

Insert into Department(Dept_name) values ('Patron Services');
Insert into Department(Dept_name) values ('Digital Services');
Insert into Department(Dept_name) values ('Maintenance Services');
Insert into Department(Dept_name) values ('Security');
Insert into Department(Dept_name) values ('Technical Services');

Insert into Book VALUES ('0837340802', 1, 'The Great Gatsby', 10, '2006-10-14');
Insert into Book VALUES ('9780841560499', 1, 'Love before Lust', 20, '2003-02-01');
Insert into Book VALUES ('9789587565980', 3, 'Glass Castle', 13, '2012-05-08');
Insert into Book VALUES ('9782373947427', 5, 'The ABC murders', 40, '1993-10-10');
Insert into Book VALUES ('9783266136379', 4, 'The hounds of Baskerville', 121, '1881-03-11');


Insert into Book_Authors values (1,'9780841560499');
Insert into Book_Authors values (3,'9782373947427');
Insert into Book_Authors values (5,'9789587565980');
Insert into Book_Authors values (2,'9780841560499');
Insert into Book_Authors values (2,'9783266136379');

Insert into Employees (Emp_f_name,Emp_l_name,Gender,tel_number,DOB,email,address,Department_NO,Salary) values ('Hannibal','Lectar','NB','+233544102734', '2001-11-30', 'hanniballectar@gmail.com', '23 Jolly road Ceres valley', 2, 2000);
Insert into Employees (Emp_f_name,Emp_l_name,Gender,tel_number,DOB,email,address,Department_NO,Salary) values ('Jonathan','Bryce','M','+2334897289', '2002-02-21', 'jonathanbryce@gmail.com', '43 jump street caramel town', 4, 2200);
Insert into Employees (Emp_f_name,Emp_l_name,Gender,tel_number,DOB,email,address,Department_NO,Salary) values ('Lisa','Love','F','+233544102854', '2001-10-31', 'lisalove@gmail.com', '23 Jolly road Ceres valley', 2, 2000);
Insert into Employees (Emp_f_name,Emp_l_name,Gender,tel_number,DOB,email,address,Department_NO,Salary) values ('Freddy','Mercury','M','+23588927828', '2000-12-25', 'freddymercury@gmail.com', '412B Avenue Ornelias dispensory lane', 5, 1500);
Insert into Employees (Emp_f_name,Emp_l_name,Gender,tel_number,DOB,email,address,Department_NO,Salary) values ('Angela','Richardson','F','+23588462643', '1988-01-21', 'angelarichardson@gmail.com', 'Close 5 house 1 Satelite Town', 3, 3000);
Insert into Employees (Emp_f_name,Emp_l_name,Gender,tel_number,DOB,email,address,Department_NO,Salary) values ('Manuella','Mandy','F','+2379027714', '1988-01-21', 'manuellamandy@gmail.com', 'Close 5 house 1 Satelite Town', 1, 1700);


Insert into Department(managerID) values (2);
Insert into Department(managerID) values (5);
Insert into Department(managerID) values (6);
Insert into Department(managerID) values (3);
Insert into Department(managerID) values (1);



Insert into Electronic (SupplierID,Device_name,date_of_purchase,warrantee_exp_date,Model) values (2, 'ipad7', '2022-05-19', '2023-05-19', 'A2197');
Insert into Electronic (SupplierID,Device_name,date_of_purchase,warrantee_exp_date,Model) values (2, 'ipad9', '2022-09-20', '2024-09-20', 'MK2K3HN/A');
Insert into Electronic (SupplierID,Device_name,date_of_purchase,warrantee_exp_date,Model) values (3, 'HP laptop', '2020-09-20', '2022-11-19', 'VGN-FW550F');
Insert into Electronic (SupplierID,Device_name,date_of_purchase,warrantee_exp_date,Model) values (5, 'DELL laptop', '2021-03-01', '2022-03-01', 'MX6930');
Insert into Electronic (SupplierID,Device_name,date_of_purchase,warrantee_exp_date,Model) values (4, 'ASUS A6Va series', '2022-06-30', '2023-06-30', 'A6Q00VA');
Insert into Electronic (SupplierID,Device_name,date_of_purchase,warrantee_exp_date,Model) values (1, 'ipad mini 5', '2022-02-14', '2023-02-14', 'A1822');


  
Insert into Kids (PatronID, Caretaker_name, Caretaker_number) values (3, 'Greg Olson', '+23354410273');
Insert into Kids (PatronID, Caretaker_name, Caretaker_number) values (4, 'Amanda Seeker', '+23253410673'); 
 
Insert into Elderly (PatronID, email, next_of_kin, next_of_kin_tel_number) values (5, 'cairojam@yahoo.com', 'Amon', '+23490641873');
 
Insert into Adults (PatronID, email) values (1, 'manukele@gmail.com');
Insert into Adults (PatronID, email, Occupation) values (2, 'maiakele@gmail.com', 'Software engineer');
Insert into Adults (PatronID, email, Occupation) values (6, 'edenfrenzy@yahoo.com', 'Business consultant');


 
Insert into Instance_of_Use (PatronID, AssetID, Time_of_borrow, Time_of_return) values (4, 2, '2022-10-10 13:35:00', '2022-11-10 13:35:00');
Insert into Instance_of_Use (PatronID, AssetID, Time_of_borrow, Time_of_return) values (2, 5, '2022-04-12 13:00:00', '2022-04-23 10:21:00');
Insert into Instance_of_Use (PatronID, AssetID, Time_of_borrow, Time_of_return) values (5, 1, '2022-03-11 12:53:00', '2022-03-31 14:40:00');
Insert into Instance_of_Use (PatronID, AssetID, Time_of_borrow, Time_of_return) values (4, 2, '2021-12-25 16:45:00', '2022-02-22 09:50:00');
Insert into Instance_of_Use (PatronID, AssetID, Time_of_borrow, Time_of_return) values (6, 2, '2022-01-19 11:58:00', '2022-02-01 15:20:00');

Insert into Borrow(PatronID, ISBN, date_taken, date_returned, Star_rating) values (2, '9789587565980', '2022-03-11 12:53:00', '2022-11-10 13:35:00', 4);
Insert into Borrow(PatronID, ISBN, date_taken, date_returned, Star_rating) values (4, '9782373947427', '2022-05-30 14:30:00', '2022-06-15 11:00:00', 5);
Insert into Borrow(PatronID, ISBN, date_taken, date_returned, Star_rating) values (3, '0837340802', '2022-01-19 16:59:00', '2022-02-20 15:43:00', 5);
Insert into Borrow(PatronID, ISBN, date_taken, date_returned, Star_rating) values (4, '9789587565980', '2022-05-23 12:40:00', '2022-04-21 15:33:00', 5);
Insert into Borrow(PatronID, ISBN, date_taken, date_returned, Star_rating) values (1, '9782373947427', '2022-06-11 12:02:00', '2022-08-03 15:50:00', 1);
Insert into Borrow(PatronID, ISBN, date_taken, date_returned, Star_rating) values (5, '0837340802', '2022-02-22 12:40:00', '2022-03-20 15:50:00', 3);


Insert into Room_Booking(Booking_date, PatronID, RoomID, Start_time, End_time) values ('2022-01-19', 3, 2, '15:30:00', '17:00:00');
Insert into Room_Booking(Booking_date, PatronID, RoomID, Start_time, End_time) values ('2022-02-21', 4, 1, '12:00:00', '14:30:00');
Insert into Room_Booking(Booking_date, PatronID, RoomID, Start_time, End_time) values ('2022-05-24', 2, 2, '15:00:00', '16:30:00');
Insert into Room_Booking(Booking_date, PatronID, RoomID, Start_time, End_time) values ('2022-02-24', 1, 4, '11:00:00', '14:30:00');
Insert into Room_Booking(Booking_date, PatronID, RoomID, Start_time, End_time) values ('2022-01-19', 6, 5, '15:30:00', '17:00:00');
Insert into Room_Booking(Booking_date, PatronID, RoomID, Start_time, End_time) values ('2022-07-23', 5, 3, '10:45:00', '12:15:00');


Insert into Token (Reward, SupplierID) values ('iphone X', 3);
Insert into Token (Reward, SupplierID) values ('Bit by Dre Headset', 1);
Insert into Token (Reward, SupplierID) values ('ipad mini 5', 4);
Insert into Token (Reward, SupplierID) values ('Apple Airpods', 2);
Insert into Token (Reward, SupplierID) values ('Top 3 best sellers of the Year', 5);

Insert into Service (Date_of_service, EmployeeID, PatronID, Rating) values ('2022-05-24', 2, 2, 5);
Insert into Service (Date_of_service, EmployeeID, PatronID, Rating) values ('2022-01-19', 3, 5, 2);
Insert into Service (Date_of_service, EmployeeID, PatronID, Rating) values ('2022-02-21', 4, 1, 4);
Insert into Service (Date_of_service, EmployeeID, PatronID, Rating) values ('2022-02-24', 1, 2, 5);
Insert into Service (Date_of_service, EmployeeID, PatronID, Rating) values ('2022-01-19', 3, 2, 5);


Insert into Patron_Rewards (TokenID, PatronID, Time_of_issue) values (2, 4, '2022-11-21 15:45:00');
Insert into Patron_Rewards (TokenID, PatronID, Time_of_issue) values (1, 3, '2022-10-15 12:00:00');
Insert into Patron_Rewards (TokenID, PatronID, Time_of_issue) values (4, 5, '2022-11-17 13:35:00');
Insert into Patron_Rewards (TokenID, PatronID, Time_of_issue) values (4, 2, '2022-11-15 11:00:00');
Insert into Patron_Rewards (TokenID, PatronID, Time_of_issue) values (5, 4, '2022-11-15 10:35:00');



#The average star rating for a book's quality based on the amount of times the book has been borrowed

SELECT count(*) as Times_borrowed, Book.Book_name, AVG(Borrow.Star_rating) as Average_rating
FROM Borrow
Join Book
on Book.ISBN = Borrow.ISBN
group by Borrow.ISBN;


#Get names of all the patrons who have ever booked a room with the rooms they've booked and the dates their bookings were made (arranged in ascending order of earliest bookings to most recent)

SELECT Room_Booking.Booking_date, Room.Room_name, Patron.First_name, Patron.Last_name
FROM Room_Booking
RIGHT JOIN Patron
ON Room_Booking.PatronID = Patron.PatronID
RIGHT JOIN Room
ON Room_Booking.RoomID = Room.RoomID
ORDER BY Room_Booking.Booking_date;


#Display the names of the first four patrons who have won rewards, the rewards they've won, and the time those rewards were claimed
 
SELECT Token.Reward, Patron.First_name, Patron.Last_name, Patron_Rewards.Time_of_issue
FROM Patron_Rewards
INNER JOIN Patron
ON Patron_Rewards.PatronID = Patron.PatronID
INNER JOIN Token
ON Patron_Rewards.TokenID = Token.TokenID
ORDER BY Patron.PatronID
LIMIT 4;

#Get all the Books who's publishers are based in Switzerland, Nigeria, or USA

SELECT Book_name, publisher_name, address, country FROM Book
JOIN Publisher
ON Publisher.PublisherID = Book.PublisherID
WHERE Book_name LIKE 'The%' and Publisher.country IN ('Nigeria', 'Switzerland', 'USA');

#Get the devices past their warrantee expiration date

SELECT COUNT(AssetID) as Number_of_devices_past_warrantee, warrantee_exp_date, Device_name FROM Electronic WHERE warrantee_exp_date < CURRENT_DATE()
GROUP BY warrantee_exp_date;

#Get the list of all the Authors who the patrons rated over 3 stars

SELECT f_name, l_name, Gender, Country FROM Authors WHERE AuthorID IN 
													(SELECT AuthorID FROM Book_Authors WHERE ISBN IN  
																						(SELECT ISBN from Borrow WHERE Star_rating >= 3));

#Display the employee's new salary as a view based on ratings. The new salary is (the average rating of the employee divided by 100) + (Old salary).

SELECT AVG(Service.Rating)/10 + Employees.Salary as New_Salary, Employees.Emp_f_name, Employees.Emp_l_name, AVG(Service.Rating) as Overall_rating, Employees.EmployeeID
From Service 
Join Employees
ON Employees.EmployeeID = Service.EmployeeID 
Group by EmployeeID;

	