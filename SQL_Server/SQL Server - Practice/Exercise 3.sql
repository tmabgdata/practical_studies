SELECT TOP(100)
	*
FROM
	FactSales

-- SUM 
SELECT
	SUM(SalesQuantity) 'Total Sale',
	SUM(ReturnQuantity) 'Total Returned'
FROM
	FactSales

-- COUNT
SELECT
	COUNT(ProductKey) AS 'Total Products'
FROM
	DimProduct
-- COUNT 2
SELECT
	COUNT(Size) AS 'Total Products with Size Information'
FROM
	DimProduct
-- COUNT 3
SELECT
	COUNT(DISTINCT BrandName)
FROM
	DimProduct

-- MAX & MIN
SELECT
	MAX(UnitCost) AS 'Max Cost',
	MIN(UnitCost) AS 'Min Cost'
FROM
	DimProduct

-- AVG
SELECT
	AVG(YearlyIncome) AS 'Avarege Yearly Employee Income'
FROM
	DimCustomer

-- Exercises --

	-- Total Sale and Returned by Store Channel --
SELECT TOP(100)
	*
FROM
	FactSales

SELECT DISTINCT
	channelKey
FROM
	FactSales

SELECT 
	*
FROM
	DimChannel

SELECT
	SUM(SalesQuantity) AS 'Total Sale',
	SUM(ReturnQuantity) AS 'Total Returned'
FROM
	FactSales
JOIN
	DimChannel
ON
	FactSales.channelKey = DimChannel.ChannelKey

	-- Customers Avarege Income in Occupation Professional --
SELECT * FROM DimCustomer
SELECT
	ROUND(AVG(YearlyIncome), 2) AS 'AVG Yearly Income'
FROM
	DimCustomer
WHERE
	Occupation = 'Professional'

	-- Store with more Employees --
SELECT TOP(1)
	StoreName AS 'Store Name',
	EmployeeCount AS 'Number of Employees'
FROM
	DimStore
ORDER BY
	EmployeeCount
DESC

	-- Store with less Employees --
SELECT TOP(1)
	StoreName AS 'Store Name',
	EmployeeCount AS 'Number of Employees'
FROM
	DimStore
WHERE
	EmployeeCount IS NOT NULL
ORDER BY
	EmployeeCount
ASC

	-- Total Male and Female Employees --
SELECT * FROM DimEmployee

SELECT
	COUNT(Gender) AS 'Male Employee'
FROM
	DimEmployee
WHERE
	Gender = 'M'

SELECT
	COUNT(Gender) AS 'Female Employee'
FROM
	DimEmployee
WHERE
	Gender = 'F'

	-- First Male and Female Employees --
SELECT TOP(1)
	FirstName AS 'Name',
	HireDate,
	EmailAddress
FROM
	DimEmployee
WHERE
	Gender = 'M'
ORDER BY
	HireDate

SELECT TOP(1)
	FirstName AS 'Name',
	HireDate,
	EmailAddress
FROM
	DimEmployee
WHERE
	Gender = 'F'
ORDER BY
	HireDate

	-- Products Analyses --
SELECT
	COUNT(DISTINCT ColorID) AS 'Colors',
	COUNT(DISTINCT BrandName) AS 'Brands',
	COUNT(DISTINCT ClassID) AS 'Classes'
FROM
	DimProduct