-- ############################################################################################################

--										SQL AND EXCEL INTEGRATION PROJECT

-- ############################################################################################################

--											DATABASE ADVENTURE WORKS
				
-- https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2014.bak --

--												INDICATORS

-- GENERAL:

-- Total Revenue
-- Sold Amount
-- Total Categories by Product
-- Number of Clients
-- Total revenue and total profit per month
-- Profit margin
-- Quantity Sold per Month
-- Profit by Country

-- CUSTOMERS:

-- Sales by Country
-- Customers by Country
-- Sales by Genre
-- Sales by Category

-- TABLES:

	-- SELECT * FROM FactInternetSales
	-- SELECT * FROM DimProductCategory
	-- SELECT * FROM DimCustomer
	-- SELECT * FROM DimGeography

-- COLUMNS:

	-- SalesOrderNumber - FactInternetSales
	-- OrderDate - FactInternetSales
	-- EnglishProductCategoryName - DimProductCategory ***
	-- CustomerKey - DimCustomer
	-- FirstName + LastName - DimCustomer
	-- Gender - DimCustomer
	-- EnglishCountryRegionName - DimGeography
	-- OrderQuantity - FactInternetSales
	-- SalesAmount - FactInternetSales
	-- TotalProductCost - FactInternetSales
	-- SalesAmount - TotalProductCost (profit) - FactInternetSales

-- CREATE VIEW:

SET LANGUAGE us_english
GO
CREATE OR ALTER VIEW RESULTS_ADW AS
SELECT
	fis.SalesOrderNumber AS 'Order Number',
	fis.OrderDate AS 'Order Date',
	DATENAME(MONTH, fis.OrderDate) 'Order Month',
	dpc.EnglishProductCategoryName AS 'Category Name',
	fis.CustomerKey As 'Customer ID',
	CONCAT(dc.FirstName, ' ', dc.LastName) AS 'Name',
	REPLACE(REPLACE(dc.Gender, 'M', 'Malle'), 'F', 'Femalle') AS Gender,
	dg.EnglishCountryRegionName AS 'Region',
	fis.OrderQuantity AS 'Total sold',
	fis.SalesAmount AS 'Total Revenue',
	fis.TotalProductCost AS 'Total Product Price',
	(fis.SalesAmount - fis.TotalProductCost) AS 'Profit'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON	dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN 	DimProductCategory dpc ON	dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
INNER JOIN DimGeography dg ON dc.GeographyKey = dg.GeographyKey
GO

SELECT * FROM RESULTS_ADW