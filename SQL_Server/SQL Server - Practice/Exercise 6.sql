	-- GROUP BY + INNER JOIN --

	-- FACT SALES --

	-- Total Sold per Year --
SELECT TOP(1) * FROM FactSales
SELECT TOP(1) * FROM DimDate

SELECT
	CalendarYear AS 'Year',
	SUM(SalesQuantity) AS 'Total Sold'
FROM
	FactSales
INNER JOIN
	DimDate
ON
	FactSales.DateKey = DimDate.Datekey
GROUP BY
	CalendarYear

	-- Total Sold per Year in January month --
SELECT
	CalendarYear AS 'Year',
	SUM(SalesQuantity) AS 'Total Sold'
FROM
	FactSales
INNER JOIN
	DimDate
ON
	FactSales.DateKey = DimDate.Datekey
WHERE
	CalendarMonthLabel = 'January'
GROUP BY
	CalendarYear

	-- Total sales per year greater than or equal to 1200000 --
SELECT
	CalendarYear AS 'Year',
	SUM(SalesQuantity) AS 'Total Sold'
FROM
	FactSales
INNER JOIN
	DimDate
ON
	FactSales.DateKey = DimDate.Datekey
WHERE
	CalendarMonthLabel = 'March'
GROUP BY
	CalendarYear
HAVING
	SUM(SalesQuantity) >= 1200000
ORDER BY
	SUM(SalesQuantity)

	-- Sales Quantity and Channel Name (Sales Quantity in ASC order) --
SELECT TOP(1) * FROM FactSales
SELECT TOP(1) * FROM DimChannel

SELECT SUM(SalesQuantity) FROM FactSales -- 53M --
SELECT DISTINCT ChannelName FROM DimChannel
	
	-- JOIN Tables --
SELECT
	ChannelName AS 'Channel',
	SUM(SalesQuantity) AS 'Total Sold'
FROM
	DimChannel
INNER JOIN
	FactSales
ON
	DimChannel.ChannelKey = FactSales.channelKey
GROUP BY
	ChannelName
ORDER BY
	SUM(SalesQuantity)
DESC

	-- Total Sold, Total Returned and Stores Name --
SELECT TOP(1) * FROM DimStore
SELECT TOP(1) * FROM FactSales

SELECT
	StoreName AS 'Store Name',
	SUM(SalesQuantity) AS 'Qnt Sold',
	SUM(ReturnQuantity) AS 'Qnt Returned'
FROM
	DimStore
INNER JOIN
	FactSales
ON
	DimStore.StoreKey = FactSales.StoreKey
GROUP BY
	StoreName
ORDER BY
	SUM(SalesQuantity)
DESC

	-- Total Value Sold per Month and Year --
SELECT TOP(1) * FROM FactSales
SELECT TOP(1) * FROM DimDate

SELECT
	CalendarYear AS 'Year',
	CalendarMonthLabel AS 'Month',
	SUM(SalesAmount) AS 'Sales Amount'
FROM
	DimDate
INNER JOIN
	FactSales
ON
	DimDate.Datekey = FactSales.DateKey
GROUP BY
	CalendarYear, CalendarMonthLabel, CalendarMonth
ORDER BY
	CalendarMonth

	-- Total Sold per Product --
SELECT TOP(1) * FROM FactSales
SELECT TOP(1) * FROM DimProduct

SELECT
	ProductName AS 'Product',
	SUM(SalesAmount) AS 'Total Value Sold'
FROM
	DimProduct
INNER JOIN
	FactSales
ON
	DimProduct.ProductKey = FactSales.ProductKey
GROUP BY
	ProductName
ORDER BY
	SUM(SalesAmount)
DESC

	-- Sales Quantity per Product Color --
SELECT
	ColorName AS 'Color',
	SUM(SalesQuantity) AS 'Qt Sold'
FROM
	DimProduct
INNER JOIN
	FactSales
ON
	DimProduct.ProductKey = FactSales.ProductKey
GROUP BY
	ColorName
ORDER BY
	COUNT(SalesQuantity)
DESC

	-- Colors sold more than 3M --
SELECT DISTINCT
	ColorName AS 'Color',
	SUM(SalesQuantity) AS 'Total Sold'
FROM
	DimProduct
INNER JOIN
	FactSales
ON
	DimProduct.ProductKey = FactSales.ProductKey
GROUP BY
	ColorName
HAVING
	SUM(SalesQuantity) >= 3000000
ORDER BY
	SUM(SalesQuantity)
DESC

	-- Qtt sold per Product Categories --
SELECT TOP(1) * FROM FactSales
SELECT TOP(1) * FROM DimProduct
SELECT TOP(1) * FROM DimProductSubcategory
SELECT TOP(1) * FROM DimProductCategory

SELECT
	ProductCategoryName AS 'Product Category',
	SUM(SalesQuantity) AS 'Qtt Sold'
FROM
	FactSales
INNER JOIN
	DimProduct
ON
	FactSales.ProductKey = DimProduct.ProductKey
INNER JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey 
INNER JOIN
	DimProductCategory
ON
	DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
GROUP BY
	ProductCategoryName
ORDER BY
	SUM(SalesQuantity)
DESC


	-- FACTSALESONLINE --

	-- Customer with the most online purchases --
SELECT TOP(1) * FROM FactOnlineSales
SELECT TOP(1) * FROM DimCustomer

SELECT TOP(1)
	DimCustomer.CustomerKey AS 'ID',
	FirstName,
	MiddleName,
	LastName,
	SUM(SalesQuantity) AS 'Qtt. Purchases'
FROM
	FactOnlineSales
INNER JOIN
	DimCustomer
ON
	FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE
	CustomerType <> 'Company'
GROUP BY
	DimCustomer.CustomerKey, FirstName, MiddleName, LastName
ORDER BY
	SUM(SalesQuantity)
DESC

	-- Top 10 product purchases by Customer with the most online purchases --
SELECT TOP(1) * FROM DimProduct
SELECT TOP(1) * FROM FactOnlineSales
SELECT TOP(1) * FROM DimCustomer

SELECT TOP(10)
	ProductName AS 'Product',
	SUM(SalesQuantity) As 'Qtt Sold'
FROM
	DimProduct
INNER JOIN
	FactOnlineSales
ON
	DimProduct.ProductKey = FactOnlineSales.ProductKey
WHERE
	CustomerKey = 7665
GROUP BY
	ProductName
ORDER BY
	SUM(SalesQuantity)
DESC

	-- Product Purchase per Gender --
SELECT TOP(1) * FROM DimProduct
SELECT TOP(1) * FROM DimCustomer
SELECT TOP(1) * FROM FactOnlineSales

SELECT
	Gender,
	SUM(SalesQuantity) AS 'Qtt Sold'
FROM
	DimCustomer
INNER JOIN
	FactOnlineSales
ON
	DimCustomer.CustomerKey = FactOnlineSales.CustomerKey
WHERE
	Gender IS NOT NULL
GROUP BY
	Gender

	-- FACTEXCHANGERATE --
	
	-- Currency Description per Average	Exchance Rate Between 10 and 100 --
SELECT TOP(1) * FROM FactExchangeRate
SELECT TOP(1) * FROM DimCurrency

SELECT
	ROUND(AVG(AverageRate), 2) 'AVG',
	CurrencyDescription
FROM
	FactExchangeRate
INNER JOIN
	DimCurrency
ON
	FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
GROUP BY
	CurrencyDescription
HAVING
	ROUND(AVG(AverageRate), 2) BETWEEN 10 AND 100
ORDER BY	
	ROUND(AVG(AverageRate), 2) DESC
	
	
	-- FACTSTRATEGYPLAN --

	-- Total Value Strategic Plan for Actual and Budget --
SELECT TOP(1) * FROM FactStrategyPlan
SELECT TOP(1) * FROM DimScenario

SELECT
	ROUND(SUM(Amount), 2) AS 'Amount',
	ScenarioDescription AS 'Scenario'
FROM
	FactStrategyPlan
INNER JOIN
	DimScenario
ON
	FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
WHERE
	ScenarioDescription IN ('Actual', 'Budget')
GROUP BY
	ScenarioDescription
ORDER BY
	ROUND(SUM(Amount), 2)
DESC

	-- Strategic Planing per Year --
SELECT TOP(1) * FROM FactStrategyPlan
SELECT TOP(1) * FROM DimDate

SELECT
	CalendarYear,
	ROUND(SUM(Amount), 2) AS 'Amount'
FROM
	DimDate
INNER JOIN
	FactStrategyPlan
ON
	DimDate.Datekey = FactStrategyPlan.Datekey
GROUP BY
	CalendarYear
ORDER BY
	ROUND(SUM(Amount), 2) DESC

	-- DIMPRODUCT | DIMPRODUCTSUBCATEGORY --

	-- Contoso products qnt with Silver's Colors per Subcategory Names --
SELECT TOP(1) * FROM DimProduct
SELECT TOP(1) * FROM DimProductSubcategory

SELECT
	ProductSubcategoryName AS 'Subcategory',
	COUNT(*) AS 'Qtt Products'
FROM
	DimProduct
INNER JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE
	BrandName = 'Contoso' AND ColorName = 'Silver'
GROUP BY
	ProductSubcategoryName
ORDER BY
	[Qtt Products] DESC

	-- Quantity Products per Brand and Subcategories --
SELECT TOP(1) * FROM DimProduct
SELECT TOP(1) * FROM DimProductSubcategory

SELECT
	BrandName AS 'Brand',
	ProductSubcategoryName AS 'Subcategory',
	COUNT(*) As 'Qtt Products'
FROM
	DimProduct
INNER JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
GROUP BY
	BrandName, ProductSubcategoryName
ORDER BY
	BrandName