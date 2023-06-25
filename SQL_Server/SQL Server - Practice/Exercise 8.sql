	--	STRINGS AND DATES --

	-- LEN & DATALENGTH --

SELECT
	LEN('Thiago Alves    ') AS 'LEN',
	DATALENGTH('Thiago Alves    ') AS 'DATALENGTH'

	-- CONCAT --

SELECT
	FirstName AS 'Name',
	LastName AS 'Lname',
	CONCAT(FirstName, ' ', LastName) AS 'Full Name',
	EmailAddress AS 'Email'
FROM
	DimCustomer

	-- LEFT & RIGHT

SELECT
	ProductName AS 'Product',
	UnitPrice AS 'Price',
	LEFT('Product01010001', 7) AS 'Cod 1',
	RIGHT('Product01010001', 7) AS 'Cod 2'
FROM
	DimProduct

	-- REPLACE --

SELECT ('Excel is the best')
SELECT REPLACE('Excel is the best', 'Excel', 'SQL')
	
SELECT
	FirstName AS 'Name',
	LastName AS 'LName',
	Gender AS 'Gende Abbreviated',
	REPLACE(Gender, 'M', 'Malle') AS 'Full Gender' 
FROM
	DimCustomer

SELECT
	FirstName AS 'Name',
	LastName AS 'LName',
	Gender AS 'Gende Abbreviated',
	REPLACE(REPLACE(Gender, 'M', 'Malle'), 'F', 'Femalle') AS 'Full Gender' 
FROM
	DimCustomer

	-- TRANSLATE & STUFF --

SELECT TRANSLATE('10.241/444.124k23/1', './k', '---')
SELECT TRANSLATE('ABCD-490123', 'ABCD', 'WXYZ')

SELECT
	STUFF('MT98-Moto G', 1, 2, 'CELL'),
	STUFF('AP01-IPhone', 1, 2, 'CELL'),
	STUFf('SS61-Samsung Galaxy', 1, 2, 'CELL')

	-- UPPER & LOWER --

SELECT
	FirstName AS 'Name',
	UPPER(FirstName) AS 'UP NAME',
	LOWER(FirstName) AS 'lower name',
	EmailAddress AS 'Email'
FROM
	DimCustomer

	-- FORMAT --

-- Format Number 5123 --
-- GENERAL --
SELECT FORMAT(5123, 'G')
-- Number --
SELECT FORMAT(5123, 'N')
-- Currency --
SELECT FORMAT(5123, 'C')

	-- DATE FORMAT 06/04/2023 --
-- dd/MM/yyyy --
SELECT FORMAT(CAST('06/04/2023' AS DATETIME), 'dd/MM/yyyy')
SELECT FORMAT(CAST('06/04/2023' AS DATETIME), 'dd/MMM/yyyy')
SELECT FORMAT(CAST('06/04/2023' AS DATETIME), 'dd/MMMM/yyyy', 'pt-BR')
-- DAY --
SELECT FORMAT(CAST('06/04/2023' AS DATETIME), 'dd')
SELECT FORMAT(CAST('06/04/2023' AS DATETIME), 'ddd')
SELECT FORMAT(CAST('06/04/2023' AS DATETIME), 'dddd', 'pt-BR')
-- MONTH --
SELECT FORMAT(CAST('06/04/2023' AS DATETIME), 'MM')
SELECT FORMAT(CAST('06/04/2023' AS DATETIME), 'MMM')
SELECT FORMAT(CAST('06/04/2023' AS DATETIME), 'MMMM', 'pt-BR')
-- YEAR --
SELECT FORMAT(CAST('06/04/2023' AS DATETIME), 'yy')
SELECT FORMAT(CAST('06/04/2023' AS DATETIME), 'yyyy', 'pt-BR')

	-- PERSONALIZED FORMAT --
-- 1234567 --
SELECT FORMAT(1234567, '##-##-###')

	-- CHARINDEX & SUBSTRING --
-- Thiago Alves --
SELECT 'Thiago Alves' AS 'Name'
-- CHARINDEX  --
SELECT CHARINDEX('l', 'Thiago Alves') AS 'Char Position'
SELECT CHARINDEX('Alves', 'Thiago Alves')
-- EXTRACT SUBSTRING --
SELECT SUBSTRING('Thiago Alves', 8, 5) AS 'Last Name'
-- CHARINDEX + SUBSTRING --
SELECT CHARINDEX(' ', 'Matheus Menezes') AS 'Position'
SELECT SUBSTRING('Matheus Menezes', CHARINDEX(' ', 'Matheus Menezes') + 1, 100) AS 'Last Name'
-- ASSIGNING TO A VARIABLE --
DECLARE @varName VARCHAR(100)
SET @varName = 'Thiago Alves'

SELECT SUBSTRING(@varName, CHARINDEX(' ', @varName) + 1, 100) AS 'Last Name'

	-- TRIM | LTRIM | RTRIM --
-- TRIM --
-- (   ABC123   ) --
DECLARE @varCod VARCHAR(30)
SET @varCod = '   ABC123  '
SELECT
	TRIM(@varCod) AS 'TRIM',
	LTRIM(@varCod) AS 'LTRIM',
	RTRIM(@varCod) AS 'RTRIM'

SELECT
	DATALENGTH(TRIM(@varCod)) AS 'TRIM',
	DATALENGTH(LTRIM(@varCod)) AS 'LTRIM',
	DATALENGTH(RTRIM(@varCod)) AS 'RTRIM'

	-- DAY | MONTH | YEAR | DATEFROMPARTS
-- day, month and year --
DECLARE @varDate DATETIME
SET @varDate = '06/05/2023'
SELECT
	DAY(@varDate) AS 'Day',
	MONTH(@varDate) AS 'Month',
	YEAR(@varDate) AS 'Year'

-- Date From Parts --
DECLARE @varDay INT, @varMonth INT, @varYear INT
SET @varDay = 05
SET @varMonth = 06
SET @varYear = 2023

SELECT
	DATEFROMPARTS(@varYear, @varMonth, @varDay)

	-- GETDATE | SYSDATETIME | DATENAME & DATEPART

SELECT GETDATE()
SELECT SYSDATETIME()

-- DATENAME: Return Nvarchar --
-- DECLARE @varDate DATETIME
DECLARE @varDate2 DATETIME
SET @varDate2 = GETDATE()

SELECT
	DATENAME(DAY, @varDate2) AS 'Day',
	DATENAME(MONTH, @varDate2) AS 'Month',
	DATENAME(YEAR, @varDate2) AS 'Year',
	DATENAME(DAYOFYEAR, @varDate2) AS 'Day of Year'

-- DATEPART: Return Int --
SELECT
	DATEPART(DAY, @varDate2) AS 'Day',
	DATEPART(MONTH, @varDate2) AS 'Month',
	DATEPART(YEAR, @varDate2) AS 'Year',
	DATEPART(DAYOFYEAR, @varDate2) AS 'Day of Year'

SELECT
	SQL_VARIANT_PROPERTY(DATENAME(DAY, @varDate2), 'BaseType') AS 'DATENAME Data Type',
	SQL_VARIANT_PROPERTY(DATEPART(DAY, @varDate2), 'BaseType') AS 'DATEPART Data Type'

	-- DATEADD | DATEDIFF --

-- DATEADD --
DECLARE @varDate3 DATETIME, @varDate4 DATETIME, @varDate5 DATETIME
SET @varDate3 = '06/02/2023'
SET @varDate4 = '04/25/2023'
SET @varDate5 = '03/15/2023'

SELECT
	DATEADD(DAY, 30, @varDate3) AS 'Date + 30 days',
	DATEADD(QUARTER, 1, @varDate3) AS 'Date + 1 quarter',
	DATEADD(MONTH, 3, @varDate3) AS 'Date + 3 Months',
	DATEADD(YEAR, -2, @varDate3) AS 'Date - 2 Years'

-- DATEDIFF --
SELECT
	DATEDIFF(DAY, @varDate4, @varDate5) AS 'Diference Days',
	DATEDIFF(MONTH, @varDate4, @varDate5) AS 'Diference Months'


-- Product Names and Character qtt --

SELECT
	ProductName AS 'Product',
	LEN(ProductName) AS 'Qtt letters'
FROM
	DimProduct
ORDER BY
	LEN(ProductName)
DESC

-- AVG characters in Letters --

SELECT
	AVG(LEN(ProductName)) AS 'AVG Chars'
FROM
	DimProduct

-- Replacing Redundant Information --

SELECT
	ProductName,
	REPLACE(REPLACE(ProductName, BrandName, ' '), ColorName, ' ') AS 'Product Name'
FROM
	DimProduct

-- New Avarege Chars Qtt --
SELECT
	AVG(LEN(REPLACE(REPLACE(ProductName, BrandName, ' '), ColorName, ' '))) AS 'AVG Qtt Chars in Product Names'
FROM
	DimProduct

-- Replacing StyleName --
-- 0 -> A, 1 -> B, 2 -> C, 3 -> D, 4 -> E, 5 -> F, 6 -> G, 7 -> H, 8 -> I, 9 -> J --

SELECT
	ProductName,
	StyleName,
	TRANSLATE(StyleName, '0123456789', 'ABCDEFGHIJ')
FROM
	DimProduct

-- First Name, Last Name, Email. Creating Login and Password --

SELECT
	FirstName + ' ' + LastName AS 'Full Name',
	EmailAddress AS 'Email',
	LEFT(EmailAddress, CHARINDEX('@', EmailAddress) - 1) AS 'Login',
	UPPER(FirstName + DATENAME(DAYOFYEAR, BirthDate)) AS 'Password'
FROm
	DimEmployee

-- All customers who purchased in the year 2001 --

SELECT
	FirstName AS 'Name',
	EmailAddress AS 'Email',
	AddressLine1 AS 'Address 1',
	DateFirstPurchase AS 'Year'
FROM
	DimCustomer
WHERE
	YEAR(DateFirstPurchase) = 2001
ORDER BY
	DateFirstPurchase

-- First Name, Email Address, Hire Date, more Day, Month and Year of Hiring columns --
SELECT * FROM DimEmployee

SELECT
	FirstName AS 'Name',
	EmailAddress AS 'E-mail',
	HireDate AS 'Hire Date',
	DAY(HireDate) AS 'Hiring Day',
	DATENAME(MONTH, HireDate) AS 'Hiring Month',
	YEAR(HireDate) AS 'Hiring Year'
FROM
	DimEmployee
ORDER BY
	HireDate

-- Active days since opening --

SELECT
	StoreName AS 'Store',
	OpenDate AS 'Opening',
	DATEDIFF(DAY, OpenDate, GETDATE()) AS 'Active Days'
FROM
	DimStore
WHERE
	CloseDate IS NULL
ORDER BY
	DATEDIFF(DAY, OpenDate, GETDATE()) DESC