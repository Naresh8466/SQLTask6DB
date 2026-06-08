--Create a New Database
CREATE DATABASE SQLTask6DB;
GO

USE SQLTask6DB;
GO

/*Create Tables
Customers Table */

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);

--Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

/*Insert Sample Data
Customers*/

INSERT INTO Customers VALUES
(1,'Ravi','Hyderabad'),
(2,'Sita','Mumbai'),
(3,'John','Delhi'),
(4,'Priya','Chennai'),
(5,'Kiran','Bangalore');

--Orders

INSERT INTO Orders VALUES
(101,1,5000),
(102,2,7000),
(103,1,3000),
(104,3,9000),
(105,5,4000);

--Show Data

SELECT * FROM Customers;
SELECT * FROM Orders;

    --Task Queries

--1. Subquery in WHERE Clause

--Find customers who have placed orders.

SELECT CustomerName
FROM Customers
WHERE CustomerID IN
(
    SELECT CustomerID
    FROM Orders
);

--2. Subquery with EXISTS

SELECT CustomerName
FROM Customers C
WHERE EXISTS
(
    SELECT *
    FROM Orders O
    WHERE O.CustomerID = C.CustomerID
);

--3. Scalar Subquery

--Find customers whose order amount is greater than average order amount.

SELECT CustomerID, OrderAmount
FROM Orders
WHERE OrderAmount >
(
    SELECT AVG(OrderAmount)
    FROM Orders
);

--4. Correlated Subquery

--Find customers whose order amount is greater than their own average.

SELECT *
FROM Orders O1
WHERE OrderAmount >
(
    SELECT AVG(OrderAmount)
    FROM Orders O2
    WHERE O1.CustomerID = O2.CustomerID
);

--5. Subquery in SELECT Clause

SELECT
CustomerName,
(
    SELECT COUNT(*)
    FROM Orders O
    WHERE O.CustomerID = C.CustomerID
) AS TotalOrders
FROM Customers C;

--6. Subquery in FROM Clause (Derived Table)

SELECT *
FROM
(
    SELECT CustomerID,
           SUM(OrderAmount) AS TotalAmount
    FROM Orders
    GROUP BY CustomerID
) AS OrderSummary;