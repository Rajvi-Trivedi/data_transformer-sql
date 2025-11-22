/***********************************************************
 * data_transformer_full_rajvi.sql
 * Modified sample data (IDs, names, emails, amounts, dates)
 * Same structure as original, only values changed.
 ***********************************************************/

CREATE DATABASE IF NOT EXISTS datatransformer_rajvi;
USE datatransformer_rajvi;

-- ---------------------------
-- 0) SAFELY DROP EXISTING TABLES
-- ---------------------------
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Assignments;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Employees;

SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------
-- 1) CREATE TABLES
-- ---------------------------
-- CUSTOMERS
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(150),
    RegistrationDate DATE
);

-- EMPLOYEES
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(12,2)
);

-- ORDERS
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(12,2),
    CONSTRAINT fk_orders_customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- ASSIGNMENTS (child table)
CREATE TABLE Assignments (
    AssignmentID INT PRIMARY KEY,
    EmployeeID INT,
    ProjectName VARCHAR(100),
    AssignedDate DATE,
    CONSTRAINT fk_assignments_employees FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- ---------------------------
-- 2) INSERT SAMPLE DATA (ALL MODIFIED)
-- ---------------------------
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, RegistrationDate) VALUES
(11, 'Aisha', 'Patel', 'aisha.patel11@example.com', '2023-02-10'),
(12, 'Rohit', 'Kumar', 'rohit.kumar12@example.com', '2022-12-01');

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, HireDate, Salary) VALUES
(21, 'Neha', 'Shah', 'Marketing', '2019-05-20', 62000.00),
(22, 'Aman', 'Singh', 'IT', '2020-09-12', 58000.00);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(111, 11, '2024-06-05', 220.75),
(112, 12, '2024-06-07', 1450.00),
(113, 11, '2024-07-15', 2500.00);

INSERT INTO Assignments (AssignmentID, EmployeeID, ProjectName, AssignedDate) VALUES
(31, 21, 'Website Redesign', '2024-06-20'),
(32, 22, 'Cloud Migration', '2024-06-25');

-- ---------------------------
-- 3) QUERIES (UNCHANGED LOGIC)
-- ---------------------------

/* 1) INNER JOIN */
SELECT O.OrderID, O.OrderDate, O.TotalAmount, 
       C.CustomerID, C.FirstName, C.LastName
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID;

/* 2) LEFT JOIN */
SELECT C.CustomerID, C.FirstName, C.LastName, 
       O.OrderID, O.TotalAmount
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID;

/* 3) RIGHT JOIN (using LEFT JOIN equivalent) */
SELECT O.OrderID, O.TotalAmount, 
       C.CustomerID, C.FirstName, C.LastName
FROM Orders O
LEFT JOIN Customers C ON O.CustomerID = C.CustomerID;

/* 4) FULL OUTER JOIN (MySQL workaround) */
SELECT C.CustomerID, C.FirstName, O.OrderID, O.TotalAmount
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
UNION
SELECT C.CustomerID, C.FirstName, O.OrderID, O.TotalAmount
FROM Customers C
RIGHT JOIN Orders O ON C.CustomerID = C.CustomerID;

/* 5) Subquery: Customers whose orders > AVG */
SELECT DISTINCT C.CustomerID, C.FirstName, C.LastName
FROM Customers C
WHERE C.CustomerID IN (
    SELECT O.CustomerID
    FROM Orders O
    WHERE O.TotalAmount > (SELECT AVG(TotalAmount) FROM Orders)
);

/* 6) Subquery: Employees with salary > avg salary */
SELECT E.EmployeeID, E.FirstName, E.LastName, E.Salary
FROM Employees E
WHERE E.Salary > (SELECT AVG(Salary) FROM Employees);

/* 7) Extract year + month */
SELECT OrderID, OrderDate, 
       YEAR(OrderDate) AS OrderYear, 
       MONTH(OrderDate) AS OrderMonth
FROM Orders;

/* 8) Days since order */
SELECT OrderID, OrderDate, 
       DATEDIFF(CURDATE(), OrderDate) AS DaysSinceOrder
FROM Orders;

/* 9) Formatted date */
SELECT OrderID, OrderDate, 
       DATE_FORMAT(OrderDate, '%d-%b-%Y') AS FormattedOrderDate
FROM Orders;

/* 10) Full name */
SELECT CustomerID, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers;

/* 11) Replace string */
SELECT CustomerID, REPLACE(FirstName, 'Aisha', 'Aishwarya') AS ReplacedFirstName
FROM Customers;

/* 12) UPPER + lower */
SELECT CustomerID, 
       UPPER(FirstName) AS First_UPPER, 
       LOWER(LastName) AS Last_lower
FROM Customers;

/* 13) TRIM email */
SELECT CustomerID, TRIM(Email) AS TrimmedEmail
FROM Customers;

/* 14) Running total */
SELECT OrderID, OrderDate, TotalAmount,
       SUM(TotalAmount) OVER (ORDER BY OrderDate, OrderID) AS RunningTotal
FROM Orders
ORDER BY OrderDate, OrderID;

/* 15) Ranking orders */
SELECT OrderID, TotalAmount,
       RANK() OVER (ORDER BY TotalAmount DESC) AS AmountRank
FROM Orders
ORDER BY AmountRank;

/* 16) Discount based on TotalAmount */
SELECT OrderID, TotalAmount,
       CASE WHEN TotalAmount > 1000 THEN '10%'
            WHEN TotalAmount > 500 THEN '5%'
            ELSE '0%' END AS DiscountRate,
       CASE WHEN TotalAmount > 1000 THEN ROUND(TotalAmount * 0.10,2)
            WHEN TotalAmount > 500 THEN ROUND(TotalAmount * 0.05,2)
            ELSE 0.00 END AS DiscountAmount
FROM Orders;

/* 17) Salary category */
SELECT EmployeeID, FirstName, LastName, Salary,
       CASE WHEN Salary > 60000 THEN 'High'
            WHEN Salary >= 40000 THEN 'Medium'
            ELSE 'Low' END AS SalaryCategory
FROM Employees;

/* Extra join: Assignments + Employees */
SELECT A.AssignmentID, A.ProjectName, A.AssignedDate, 
       E.EmployeeID, E.FirstName, E.LastName
FROM Assignments A
JOIN Employees E ON A.EmployeeID = E.EmployeeID;

/***********************************************************
 * End of modified script
 ***********************************************************/
