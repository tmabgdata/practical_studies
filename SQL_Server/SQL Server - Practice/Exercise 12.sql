	/*
		CRUD
		CREATE / DROP DATABASE
		CREATE TABLE
		INSERT SELECT
		INSERT INTO
		UPDATE
		DELETE
		DROP TABLE
		ALTER TABLE
	*/

	-- CREATE DATABASE --
CREATE DATABASE TmaBigData
	-- CREATE TABLE --
USE TmaBigData

CREATE TABLE Products(
	ProductKey INT,
	ProductName VARCHAR(200),
	ExpirationDate DATETIME,
	ProductPrice FLOAT
)

SELECT * FROM Products

	-- INSERT DATA --
	-- First Option --
INSERT INTO Products(
	ProductKey,
	ProductName,
	ExpirationDate,
	ProductPrice
)
SELECT
	ProductKey,
	ProductName,
	AvailableForSaleDate,
	UnitPrice
FROM
	ContosoRetailDW.dbo.DimProduct

-- SELECT * FROM Products

	-- Second Option --
DROP TABLE Products

CREATE TABLE Products(
	ProductKey INT,
	ProductName VARCHAR(200),
	ExpirationDate DATETIME,
	ProductPrice FLOAT
)

SELECT * FROM Products

INSERT INTO Products(
	ProductKey,
	ProductName,
	ExpirationDate,
	ProductPrice
)
VALUES
	(1, 'Rice', '12/31/2023', 25.99),
	(2, 'Bean', '10/25/2023', 13.50)

SELECT * FROM Products

INSERT INTO Products(
	ExpirationDate,
	ProductKey,
	ProductPrice
)
VALUES
	('06/15/2023', 3, 10.99)

UPDATE Products
SET ProductName = 'Pasta'
WHERE ProductKey = 3

DELETE FROM Products WHERE ProductKey = 3

DROP TABLE Products

	-- CREATE TABLE EMPLOYEE AND INSERT DATA --
CREATE TABLE Employee(
	EmployeeKey INT,
	EmployeeName VARCHAR(200),
	Salary FLOAT,
	BirthDate DATETIME
)
INSERT INTO Employee(
	EmployeeKey,
	EmployeeName,
	Salary,
	BirthDate
)
VALUES
	(1, 'Alberto', 2500, '10/03/1985'),
	(2, 'Ângela', 3000, '05/15/1991'),
	(3, 'Maria', 1950, '07/21/1990'),
	(4, 'Jackson', 5250, '06/13/1998')

SELECT * FROM Employee

	-- ALTER TABLE --
ALTER TABLE Employee
ADD Role VARCHAR(100),
	Bonus FLOAT 

UPDATE Employee
SET Role = 'Analytics',
	Bonus = 0.15
WHERE EmployeeKey = 1

ALTER TABLE Employee
ALTER COLUMN Salary INT

ALTER TABLE Employee
DROP COLUMN Role, Bonus