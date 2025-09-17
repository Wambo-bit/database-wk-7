-- USE DATABASE
USE salesdb;

-- QUESTION 1: Achieving 1NF
-- Drop if exists
DROP TABLE IF EXISTS ProductDetail;
DROP TABLE IF EXISTS ProductDetail_1NF;

-- Original unnormalized table
CREATE TABLE ProductDetail (
OrderID INT,
CustomerName VARCHAR(50),
Products VARCHAR(100)
);

-- Insert sample data
INSERT INTO ProductDetail (OrderID, CustomerName, Products) 
VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Normalized table (1NF)
CREATE TABLE ProductDetail_1NF (
OrderID INT,
CustomerName VARCHAR(50),
Product VARCHAR(50)
);

-- Insert normalized data
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) 
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Check 1NF result
SELECT * FROM ProductDetail_1NF;

-- QUESTION 2: Achieving 2NF
-- Drop if exists
DROP TABLE IF EXISTS Customers_Assignment;
DROP TABLE IF EXISTS OrderProducts_Assignment;

-- Step 1: Customers table
CREATE TABLE Customers_Assignment (
OrderID INT PRIMARY KEY,
CustomerName VARCHAR(50)
);

INSERT INTO Customers_Assignment (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

CREATE TABLE OrderProducts_Assignment (
OrderID INT,
Product VARCHAR(50),
Quantity INT,
PRIMARY KEY (OrderID, Product),
FOREIGN KEY (OrderID) REFERENCES Customers_Assignment(OrderID)
);

INSERT INTO OrderProducts_Assignment (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Check results
SELECT * FROM Customers_Assignment;
SELECT * FROM OrderProducts_Assignment;
