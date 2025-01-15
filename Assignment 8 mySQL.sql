CREATE database Country;
USE Country;
# SUBQUERIES
# Create a table named Country

CREATE TABLE Country (
    Id INT PRIMARY KEY,
    Country_name VARCHAR(100),
    Population INT,
    Area INT
);


# Create a table named Persons

CREATE TABLE Persons (
    Id INT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    Population INT,
    DOB DATE,
    Rating INT,
    Country_Id INT,
    Country_name VARCHAR(100),
    FOREIGN KEY (Country_Id) REFERENCES Country(Id)
);

# Insert 10 Rows into the Country Table

INSERT INTO Country (Id, Country_name, Population, Area) VALUES
(1, 'USA', 331002651, 9833517),
(2, 'Canada', 37742154, 9984670),
(3, 'Brazil', 212559417, 8515767),
(4, 'India', 1380004385, 3287263),
(5, 'China', 1393409038, 9596961),
(6, 'Germany', 83783942, 357022),
(7, 'France', 67391582, 643801),
(8, 'Australia', 25499884, 7692024),
(9, 'Russia', 145934462, 17098242),
(10, 'Mexico', 128933207, 1964375);

# Insert 10 Rows into the Persons Table

INSERT INTO Persons (Id, Fname, Lname,DOB,Population, Rating, Country_Id, Country_name) VALUES
(1, 'John', 'Doe','2001-03-04', 331002651, 5, 1, 'USA'),
(2, 'Jane', 'Smith','1985-09-20', 37742154, 4, 2, 'Canada'),
(3, 'Carlos', 'Mendez','2000-11-03', 212559417, 4, 3, 'Brazil'),
(4, 'Amit', 'Sharma', '1995-03-12', 1380004385, 5, 4, 'India'),
(5, 'Li', 'Wang','1988-07-25',1393409038, 3, 5, 'China'),
(6, 'Max', 'Müller','1992-04-10', 83783942, 4, 6, 'Germany'),
(7, 'Sophie', 'Dupont','1998-12-22', 67391582, 5, 7, 'France'),
(8, 'Jack', 'Johnson','1987-06-30', 25499884, 4, 8, 'Australia'),
(9, 'Nikolai', 'Petrov','1993-01-18', 145934462, 5, 9, 'Russia'),
(10, 'Maria', 'Garcia','2002-08-08', 128933207, 4, 10, 'Mexico');

select* from persons;
select* from country;

# Find the number of persons in each country

SELECT Country_name,COUNT(*) AS Num_Persons
FROM Persons
GROUP BY Country_name;

# Find the number of persons in each country sorted from high to low.

SELECT Country_name,COUNT(*) AS Num_Persons
FROM Persons
GROUP BY Country_name
ORDER BY Num_Persons;

# Find out an average rating for Persons in respective countries if the average is greater than 3.0

select avg(rating) from Persons;
SELECT Country_Id, AVG(Rating) AS Avg_Rating 
FROM Persons 
GROUP BY Country_Id 
HAVING AVG(Rating) > 3.0;

# Find the countries with the same rating as the USA. (Use Subqueries)

SELECT DISTINCT Country_name 
FROM Persons 
WHERE Rating = (SELECT Rating FROM Persons WHERE Country_Id = 1 LIMIT 1);

#  Select all countries whose population is greater than the average population of all nations. 

SELECT Country_name, Population 
FROM Country 
WHERE Population > (SELECT AVG(Population) FROM Country);

# VIEWS
#  create database product

CREATE DATABASE Product;
USE Product;

# create table customer

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    Email VARCHAR(100),
    Phone_no VARCHAR(15),
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    Zip_code VARCHAR(10),
    Country VARCHAR(50)
);
INSERT INTO Customer (Customer_Id,First_name, Last_name, Email, Phone_no, Address, City, State, Zip_code, Country) VALUES
(1,'John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St', 'Los Angeles', 'California', '90001', 'USA'),
(2,'Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Elm St', 'San Francisco', 'California', '94102', 'USA'),
(3,'Emily', 'Davis', 'emily.davis@example.com', '5678901234', '789 Oak St', 'New York', 'New York', '10001', 'USA'),
(4,'Michael', 'Brown', 'michael.brown@example.com', '6789012345', '321 Pine St', 'Chicago', 'Illinois', '60601', 'USA'),
(5,'Sarah', 'Wilson', 'sarah.wilson@example.com', '7890123456', '654 Maple St', 'Houston', 'Texas', '77001', 'USA'),
(6,'David', 'Johnson', 'david.johnson@example.com', '8901234567', '987 Cedar St', 'Phoenix', 'Arizona', '85001', 'USA'),
(7,'Emma', 'Taylor', 'emma.taylor@example.com', '9012345678', '543 Birch St', 'Philadelphia', 'Pennsylvania', '19101', 'USA'),
(8,'James', 'Anderson', 'james.anderson@example.com', '1238901234', '876 Walnut St', 'Seattle', 'Washington', '98101', 'USA'),
(9,'Olivia', 'Martin', 'olivia.martin@example.com', '2349012345', '234 Chestnut St', 'Miami', 'Florida', '33101', 'USA'),
(10,'Sophia', 'Clark', 'sophia.clark@example.com', '3456789012', '567 Spruce St', 'Dallas', 'Texas', '75201', 'USA');

SELECT * FROM Customer;

# Create a view named customer_info for the Customer table that displays Customer’s Full name and email address. Then perform the SELECT operation for the customer_info view.

CREATE VIEW customer_info AS
SELECT 
	CONCAT(First_name, ' ', Last_name) AS Full_name,
    Email
FROM Customer;

SELECT * FROM customer_info;

 # Create a view named US_Customers that displays customers located in the US

CREATE VIEW US_Customers AS
SELECT * FROM Customer
WHERE Country = 'USA';

#  Create another view named Customer_details with columns full name(Combine first_name and last_name), email, phone_no, and state

CREATE VIEW Customer_details AS
SELECT CONCAT(First_name, ' ', Last_name) AS Full_name, Email, Phone_no, State
FROM Customer;

SELECT * FROM Customer_details;

# Update phone numbers of customers who live in California for Customer_details view
UPDATE Customer
SET Phone_no = '9999999999'
WHERE State = 'California';
SELECT * FROM Customer;

# . Count the number of customers in each state and show only states with more than 5 customers

SELECT State, COUNT(*) AS Number_of_Customers
FROM Customer
GROUP BY State
HAVING COUNT(*) > 5;

# Write a query that will return the number of customers in each state, based on the "state" column in the "customer_details" view.

SELECT State, COUNT(*) AS Number_of_Customers
FROM Customer_details
GROUP BY State;

# Write a query that returns all the columns from the "customer_details" view, sorted by the "state" column in ascending order.

SELECT * FROM Customer_details
ORDER BY State ASC;




