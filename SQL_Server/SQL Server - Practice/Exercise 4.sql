/*	GROUP BY
	HAVING
	GROUP BY + ORDER BY
	HAVING vs WHERE
	GROUP BY + WHERE
*/

-- GROUP BY
SELECT
	BrandName AS 'Brand Name',
	COUNT(*) AS 'Total'
FROM
	DimProduct
GROUP BY
	BrandName

SELECT
	StoreType AS 'Store Type',
	SUM(EmployeeCount) AS 'Number of Employees'
FROM
	DimStore
GROUP BY
	StoreType

SELECT
	BrandName AS 'Brand Name',
	ROUND(AVG(UnitCost), 2) AS 'AVG Cost'
FROM
	DimProduct
GROUP BY
	BrandName

SELECT
	ClassName AS 'Class Name',
	MAX(UnitPrice) AS 'Max Price'
FROM
	DimProduct
GROUP BY
	ClassName

-- ORDER BY
SELECT
	StoreType AS 'Store Type',
	SUM(EmployeeCount) AS 'Number of Employees'
FROM
	DimStore
GROUP BY
	StoreType
ORDER BY
	[Number of Employees]
DESC

SELECT
	ColorName AS 'Color Product',
	COUNT(*) AS 'Total Product'
FROM
	DimProduct
WHERE
	BrandName = 'Contoso'
GROUP BY
	ColorName
ORDER BY
	[Total Product]
DESC

-- HAVING
SELECT
	BrandName AS 'Brand',
	COUNT(BrandName) AS 'Total Products'
FROM
	DimProduct
GROUP BY
	BrandName
HAVING
	COUNT(BrandName) >= 200
ORDER BY
	COUNT(BrandName)
DESC

SELECT
	BrandName AS 'Brand',
	COUNT(BrandName) AS 'Total Products'
FROM
	DimProduct
WHERE
	ClassName = 'Economy'
GROUP BY
	BrandName
HAVING
	COUNT(BrandName) >= 200
ORDER BY
	COUNT(BrandName)

-- Exercises --
	-- FACTSALES --
	
	-- Quantity Sale by ChannelKey --
	SELECT TOP(100) * FROM FactSales

SELECT
	channelKey AS 'Channel Key',
	COUNT(SalesQuantity) AS 'Qnt Sale'
FROM
	FactSales
GROUP BY
	channelKey
ORDER BY
	channelKey

	-- Total Sale by ChannelKey --
SELECT
	channelKey AS 'Channel Key',
	SUM(SalesQuantity) AS 'Total Sale'
FROM
	FactSales
GROUP BY
	channelKey
ORDER BY
	channelKey

	-- Total Sale and Returned by StoreKey --
SELECT
	StoreKey AS 'Store Number',
	SUM(SalesQuantity) AS 'Total Sale',
	SUM(ReturnQuantity) AS 'Total Returned'
FROM
	FactSales
GROUP BY
	StoreKey
ORDER BY
	SUM(SalesQuantity)
DESC

	-- Total Sale by Channel Key in 2007 --
SELECT
	channelKey AS 'Channel Sale',
	SUM(SalesAmount) AS 'Total Amount'
FROM
	FactSales
WHERE
	DateKey
BETWEEN
	'20070101' AND '20071231'
GROUP BY
	channelKey

	-- Sales Amount by Products (5M) + --
SELECT
	ProductKey AS 'Product ID',
	SUM(SalesAmount) AS 'Total Amount'
FROM
	FactSales
GROUP BY
	ProductKey
HAVING
	SUM(SalesAmount) >= 5000000
ORDER BY
	SUM(SalesAmount)
DESC
	
	-- Top 10 Sales Amount 5M + --
SELECT TOP(10)
	ProductKey AS 'Product ID',
	SUM(SalesAmount) AS 'Total Amount'
FROM
	FactSales
GROUP BY
	ProductKey
ORDER BY
	SUM(SalesAmount)
DESC

	-- FACTONLINESALES --
SELECT TOP(10) * FROM FactOnlineSales

	-- Sales per Customers --
SELECT
	CustomerKey AS 'Customer ID',
	SUM(SalesQuantity) AS 'Qnt Sale'
FROM
	FactOnlineSales
GROUP BY
	CustomerKey
ORDER BY
	SUM(SalesQuantity)
DESC

SELECT TOP(3)
	ProductKey AS 'Product ID',
	SUM(SalesQuantity) AS 'Qnt Sale'
FROM
	FactOnlineSales
WHERE
	CustomerKey = 19037
GROUP BY
	ProductKey
ORDER BY
	SUM(SalesQuantity)
DESC

	-- DIMPRODUCT --
SELECT TOP(10) * FROM DimProduct

	-- Products per Brand --
SELECT
	BrandName AS 'Brand',
	COUNT(ProductKey) AS 'Product ID'
FROM
	DimProduct
GROUP BY
	BrandName
ORDER BY
	COUNT(ProductKey)
DESC

	-- AVG Price per Class Name --
SELECT
	ClassName AS 'Class Name',
	ROUND(AVG(UnitPrice),2) AS 'AVG Price'
FROM
	DimProduct
GROUP BY
	ClassName
ORDER BY
	ROUND(AVG(UnitPrice),2)
DESC

	-- Weights per Products Colors (pounds to kg) --
SELECT
	ColorName AS 'Color Product',
	ROUND(SUM(Weight)/2.20462262, 2) AS 'Weight in KG'
FROM
	DimProduct
GROUP BY
	ColorName
ORDER BY
	ROUND(SUM(Weight)/2.20462262, 2)
DESC

	-- Stock Type Weights in Contoso --
SELECT DISTINCT
	StockTypeName AS 'Stock Type',
	ROUND(SUM(Weight)/2.20462262, 2) AS 'Weight'
FROM
	DimProduct
WHERE
	BrandName = 'Contoso'
GROUP BY
	StockTypeName
ORDER BY
	ROUND(SUM(Weight)/2.20462262, 2)
DESC

	-- Colors per Products --
SELECT
	BrandName AS 'Brand',
	COUNT(DISTINCT ColorName) AS 'Color Product'
FROM
	DimProduct
GROUP BY
	BrandName
ORDER BY
	COUNT(DISTINCT ColorName)
DESC

	-- DIMCUSTOMER --
SELECT TOP(10) * FROM DimCustomer

	-- AVG Salary and Qtd Customer per Gender --
SELECT
	Gender,
	ROUND(AVG(YearlyIncome), 2) AS 'AVG Salary',
	COUNT(CustomerKey) AS 'Qtd Clients'
FROM
	DimCustomer
WHERE
	Gender IS NOT NULL
GROUP BY
	Gender
ORDER BY
	ROUND(AVG(YearlyIncome), 2)
DESC

	-- Yearly Income by Education level --
SELECT
	COUNT(CustomerKey) AS 'Total Clients',
	ROUND(AVG(YearlyIncome), 2) AS 'AVG Salary',
	Education
FROM
	DimCustomer
WHERE
	Education IS NOT NULL
GROUP BY
	Education
ORDER BY
	ROUND(AVG(YearlyIncome), 2)
DESC

	-- DIMEMPLOYEE --
SELECT TOP(10) * FROM DimEmployee

	-- Total Actives Employee by Department --
SELECT
	COUNT(EmployeeKey) AS 'Total Employee',
	DepartmentName AS 'Departments'
FROM
	DimEmployee
WHERE
	Status = 'Current'
GROUP BY
	DepartmentName
ORDER BY
	COUNT(EmployeeKey)

	-- Vacations Hours from Womens Employees Beetween 1999 and 2000 --
SELECT
	Title,
	SUM(VacationHours) AS 'Total Vacation Hours'
FROM
	DimEmployee
WHERE
	Gender = 'F'
AND
	DepartmentName
IN
	('Production', 'Marketing', 'Engineering', 'Finance')
AND
	HireDate
BETWEEN
	'1991-01-01' AND  '2000-12-31'
GROUP BY
	Title