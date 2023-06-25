-- #################################################################################

--							SQL AND EXCEL INTEGRATION PROJECT

-- #################################################################################

--										DATABASE 

--									ADVENTURE WORKS
				
-- https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2014.bak --

-- Indicators:

-- Total internet sales by category
-- Total internet revenue per order month
-- Total Internet Revenue and Cost by Country
-- Total Internet Sales by Gender

-- Year of order, 2013

-- Tables:

--						SELECT * FROM FactInternetSales
--						SELECT * FROM DimProductCategory
--						SELECT * FROM DimSalesTerritory
--						SELECT * FROM DimCustomer

-- Defining columns of the SALES_INTERNET view

-- Columns:

-- SalesOrderNumber - FactInternetSales
-- OrderDate - FactInternetSales
-- EnglishProductCategoryName - DimProductCategory
-- FirstName + LastName - DimCustomer
-- Gender - DimCustomer
-- SalesTerritoryCountry - DimSalesTerritory
-- OrderQuantity - FactInternetSales
-- TotalProductCost - FactInternetSales
-- SalesAmount - FactInternetSales

-- Creating View

SET LANGUAGE us_english
GO
CREATE OR ALTER VIEW INTERNET_SALES AS 
SELECT
	fis.SalesOrderNumber AS 'Order Number',
	fis.OrderDate AS 'Order Date',
	DATENAME(MONTH, fis.OrderDate) 'Order Month',
	dpc.EnglishProductCategoryName AS 'Product Category',
	CONCAT(dc.FirstName, ' ',  dc.LastName) AS 'Name',
	dc.Gender,
	dst.SalesTerritoryCountry AS 'Country',
	fis.OrderQuantity AS 'Sold Amount',
	fis.TotalProductCost AS 'Sale Cost',
	fis.SalesAmount AS 'Sale Income'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON	dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN 	DimProductCategory dpc ON	dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
INNER JOIN DimSalesTerritory dst ON fis.SalesTerritoryKey = dst.SalesTerritoryKey
WHERE YEAR(OrderDate) = 2013
GO

--		SELECT * FROM DimProductCategory
--		SELECT * FROM DimProductSubcategory
--		SELECT * FROM DimProduct

-- IN EXCEL 
SELECT
	fis.SalesOrderNumber AS 'Order Number',
	fis.OrderDate AS 'Order Date',
	DATENAME(MONTH, fis.OrderDate) 'Order Month',
	dpc.EnglishProductCategoryName AS 'Product Category',
	CONCAT(dc.FirstName, ' ',  dc.LastName) AS 'Name',
	dc.Gender AS 'Gender',
	dst.SalesTerritoryCountry AS 'Country',
	fis.OrderQuantity AS 'Sold Amount',
	fis.TotalProductCost AS 'Sale Cost',
	fis.SalesAmount AS 'Sale Income'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON	dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN 	DimProductCategory dpc ON	dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
INNER JOIN DimSalesTerritory dst ON fis.SalesTerritoryKey = dst.SalesTerritoryKey
WHERE YEAR(OrderDate) = 2013

-- ALTER DATA BASE & UPDATE EXCEL

BEGIN TRANSACTION T1

	UPDATE FactInternetSales
	SET OrderQuantity = 20
	WHERE ProductKey = 361		-- Bikes Category

COMMIT TRANSACTION T1

SELECT * FROM FactInternetSales