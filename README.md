# Data Transformer – SQL Project

## Project Overview

Data Transformer is a structured SQL project designed to demonstrate intermediate to advanced querying techniques using a corporate-style relational database.

The system simulates core business operations including customer management, employee records, order processing, and project assignments.

The project highlights practical use of joins, subqueries, window functions, string manipulation, and analytical logic using MySQL.

---

## Project Objective

* Design and manage a structured relational database
* Apply advanced SQL querying techniques
* Perform business-oriented data transformation and reporting
* Demonstrate analytical SQL capabilities in a corporate use case

---

## Database Information

**Database Name:** `datatransformer_rajvi`

---

## Database Modules & Tables

### 1. Customer Information Management

**Table: Customers**

* CustomerID (PK)
* FirstName
* LastName
* Email
* RegistrationDate

---

### 2. Employee Data & Salary Records

**Table: Employees**

* EmployeeID (PK)
* FirstName
* LastName
* Department
* HireDate
* Salary

---

### 3. Order Processing System

**Table: Orders**

* OrderID (PK)
* CustomerID (FK)
* OrderDate
* TotalAmount

---

### 4. Employee Project Assignments

**Table: Assignments**

* AssignmentID (PK)
* EmployeeID (FK)
* ProjectName
* AssignedDate

---

## SQL Concepts Demonstrated

### Joins

* INNER JOIN – Customer order mapping
* LEFT JOIN – Customers without orders
* RIGHT JOIN – Employees without assignments
* FULL OUTER JOIN (simulated using UNION)

---

### Subqueries

* Customers with above-average order value
* Employees earning above department average
* Orders exceeding calculated benchmarks

---

### String Functions

* CONCAT (Full name creation)
* UPPER / LOWER (Standardization)
* TRIM (Data cleaning)
* REPLACE (Email formatting adjustments)

---

### Date Functions

* DATEDIFF (Service duration calculation)
* DATE_FORMAT (Formatted reporting)
* Time-based filtering of orders

---

### Window Functions

* Running total of order amounts
* RANK() for salary comparison
* Department-wise salary ranking

---

### CASE Expressions

* Salary categorization (High / Medium / Low)
* Order value classification
* Employee tenure grouping

---

## Business Insights Generated

* High-value customers identification
* Salary distribution across departments
* Revenue tracking through running totals
* Employee performance and tenure analysis

---

## How to Run

1. Open MySQL Workbench
2. Create the database:

```sql
CREATE DATABASE IF NOT EXISTS datatransformer_rajvi;
```

3. Select database:

```sql
USE datatransformer_rajvi;
```

4. Execute the full SQL script

---

## Skills Demonstrated

* Relational Database Management
* Business Data Transformation
* Analytical Query Writing
* Window Functions & Ranking
* Data Cleaning & Formatting
* Structured Reporting with SQL

---

## Author

Rajvi Trivedi
Data Analyst | Business Analyst

---

