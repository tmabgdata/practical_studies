	-- SUBQUERY AND CTE: Common Table Expression --

	-- Products with a unit price greater than the average unit price --
SELECT
	*
FROM
	DimProduct
WHERE
	UnitCost >= (SELECT AVG(UnitCost) FROM DimProduct)

	-- All products where the subcategory is 'Televisions' --
SELECT * FROM DimProduct
WHERE ProductSubcategoryKey = 
	(SELECT ProductSubcategoryKey FROM DimProductSubcategory
		WHERE ProductSubcategoryName = 'Televisions')

	-- All sales from stores that have 100 or more employees --
SELECT * FROM FactSales
WHERE StoreKey IN (
	SELECT StoreKey
	FROM DimStore
	WHERE EmployeeCount >= 100
	)

	-- ANY, SOME, ALL --

CREATE DATABASE TmaBigData
USE TmaBigData
CREATE TABLE Employees(
	EmployeeKey INT,
	EmployeeName VARCHAR(200),
	EmployeeAge INT,
	Gender VARCHAR(50)
)

INSERT INTO Employees(
	EmployeeKey,
	EmployeeName,
	EmployeeAge,
	Gender
)
VALUES
	(1, 'Julia', 20, 'F'),
	(2, 'Daniel', 21, 'M'),
	(3, 'Amanda', 22, 'F'),
	(4, 'Pedro', 23, 'M'),
	(5, 'André', 24, 'M'),
	(6, 'Luiza', 25, 'F')

SELECT * FROM Employees
WHERE EmployeeAge IN (21, 23, 24)

SELECT * FROM Employees
WHERE EmployeeAge IN (SELECT EmployeeAge FROM Employees WHERE Gender = 'M')

SELECT * FROM Employees
WHERE EmployeeAge = ANY (SELECT EmployeeAge FROM Employees WHERE Gender = 'M')

SELECT * FROM Employees
WHERE EmployeeAge > ANY (SELECT EmployeeAge FROM Employees WHERE Gender = 'M')

SELECT * FROM Employees
WHERE EmployeeAge < ANY (SELECT EmployeeAge FROM Employees WHERE Gender = 'M')

SELECT * FROM Employees
WHERE EmployeeAge <= ANY (SELECT EmployeeAge FROM Employees WHERE Gender = 'M')

SELECT * FROM Employees
WHERE EmployeeAge >= ANY (SELECT EmployeeAge FROM Employees WHERE Gender = 'M')

SELECT * FROM Employees
WHERE EmployeeAge >= SOME (SELECT EmployeeAge FROM Employees WHERE Gender = 'M') -- SOME = ANY

SELECT * FROM Employees
WHERE EmployeeAge >= ALL (SELECT EmployeeAge FROM Employees WHERE Gender = 'M')
	
	----------------------------------------------------------------------------
	
USE ContosoRetailDW

	-- EXISTS --

	-- All sales from date 01/01/2007 --
SELECT
	ProductKey,
	ProductName
FROM
	DimProduct
WHERE EXISTS(
	SELECT ProductKey
	FROM FactSales
	WHERE DateKey = '01/01/2007'
	AND FactSales.ProductKey = DimProduct.ProductKey )

	-- Quantity Sold per Product --
SELECT
	ProductKey,
	ProductName,
	(SELECT(COUNT(ProductKey)) FROM FactSales
		WHERE FactSales.ProductKey = DimProduct.ProductKey) AS 'Qty Sold'
FROM
	DimProduct

	-- Count of Products per Name Brand (Contoso) in Statement FROM --
SELECT
	COUNT(*)
FROM
	(SELECT * FROM DimProduct WHERE BrandName = 'Contoso') AS SubqueryInFrom

	
	
	-- NESTED SUBQUERY --

	-- Yearly Income per Customer type Person --
SELECT *
FROM DimCustomer
WHERE CustomerType = 'Person'
ORDER BY YearlyIncome DESC

	-- TOP 3 Highest Yearly Income --
SELECT DISTINCT TOP(3)
	YearlyIncome
FROM DimCustomer
WHERE CustomerType = 'Person'
ORDER BY YearlyIncome DESC
	
	-- Filtering The Second more highest --
SELECT
	CustomerKey,
	FirstName,
	LastName,
	YearlyIncome
FROM
	DimCustomer
WHERE
	YearlyIncome = 160000

	-- Applying nested queries --

-- 1 - Highest Salary
-- 2 - Only Second highest salary
-- 3 - Clients with the second highest salary

	-- All Customers with Second More Highest Yearly Income --
SELECT -- Third Select
	CustomerKey,
	FirstName,
	LastName,
	YearlyIncome
FROM
	DimCustomer
WHERE
	YearlyIncome = (
		SELECT -- Second Select
			MAX(YearlyIncome)
		FROM DimCustomer
		WHERE YearlyIncome < (
				SELECT -- First select
					MAX(YearlyIncome)
				FROM DimCustomer
				WHERE CustomerType = 'Person'
							)
					)

		----------------------------------------------------------------------------

	-- CTE : Common Table Experssion (Temp Table) --
	-- ProductKey, ProductName, BrandName, ColorName and UnitPrice --
GO
WITH cte AS (
	SELECT
		ProductKey,
		ProductName,
		BrandName,
		ColorName,
		UnitPrice
	FROM
		DimProduct
	WHERE
		BrandName = 'Contoso')

SELECT COUNT(*) FROM cte
GO
	
	-- Total Products Per Brand. Avarege Products per Brand --

WITH cte1 AS (
	SELECT
		BrandName,
		COUNT(*) AS 'Total'
	FROM
		DimProduct
	GROUP BY
		BrandName)

SELECT AVG(Total) FROM cte1
GO

	-- Multiple CTE's --
	-- First: products_contoso, Tables from DimProducts: ProductKey, ProductName, BrandName
	-- Second: top100_sales, from Table FactSales

WITH products_contoso AS (
	SELECT
		ProductKey,
		ProductName,
		BrandName
	FROM
		DimProduct
	WHERE BrandName = 'Contoso'),
	top100_sales AS (
	SELECT TOP(100)
		SalesKey,
		ProductKey,
		DateKey,
		SalesQuantity
	FROM
		FactSales
	ORDER BY
		DateKey DESC)

SELECT * FROM top100_sales
INNER JOIN products_contoso
ON top100_sales.ProductKey = products_contoso.ProductKey

	----------------------------------------------------------------------------
	
	-- PRACTICES --

	-- All Sales from Contoso Orlando Store --
SELECT * FROM FactSales
WHERE StoreKey = (
	SELECT StoreKey FROM DimStore
	WHERE StoreName = 'Contoso Orlando Store')

	-- Products more expansive than product with id = 1893 --
SELECT
	ProductKey,
	ProductName,
	UnitPrice,
	(	SELECT UnitPrice
		FROM DimProduct
		WHERE ProductKey = 1893
	) AS 'UnitPrice (ID 1893)'
FROM DimProduct
WHERE UnitPrice > (
		SELECT UnitPrice
		FROM DimProduct
		WHERE ProductKey = 1893
	)

	-- Bonus for employees who work in the same department as Miguel Severino --
SELECT *
FROM DimEmployee
WHERE DepartmentName = (
			SELECT DepartmentName
			FROM DimEmployee
			WHERE FirstName = 'Miguel'
			AND LastName = 'Severino')

	-- Yearly Income Highest than the Avarege --
SELECT
	CustomerKey,
	FirstName,
	LastName,
	EmailAddress,
	YearlyIncome
FROM DimCustomer
WHERE YearlyIncome > (
			SELECT
				AVG(YearlyIncome)
			FROM DimCustomer
			WHERE CustomerType = 'Person'
					)
AND CustomerType = 'Person'

	-- Customers who Sale in Asian Holiday Promotion --
SELECT *
FROM DimCustomer
WHERE CustomerKey IN (
				SELECT
					CustomerKey
				FROM FactOnlineSales
				WHERE PromotionKey IN (
							SELECT PromotionKey FROM DimPromotion
							WHERE PromotionName = 'Asian Holiday Promotion')
					)

	-- Over 3000 units purchased will receive a discount --
SELECT
	CustomerKey,
	CompanyName
FROM DimCustomer
WHERE CustomerKey IN (
			SELECT
				CustomerKey
			FROM FactOnlineSales
			GROUP BY CustomerKey, ProductKey
			HAVING COUNT(*) >= 3000
					 )
	-- 
SELECT
	ProductKey,
	ProductName,
	BrandName,
	UnitPrice,
	ROUND((SELECT AVG(UnitPrice) FROM DimProduct), 2) AS 'Unit Price (AVG)'
FROM
	DimProduct

	-- Qty MAX, MIN and AVG Per Brand --
SELECT
	MAX(Qty) AS 'Max',
	MIN(Qty) AS 'Min',
	AVG(Qty) AS 'Avg'
FROM (
	SELECT
		BrandName,
		COUNT(*) AS 'Qty'
	FROM DimProduct
	GROUP BY BrandName
	) AS Temp_table

	-- CTE Products per brand --
WITH CTE_ProductsPerBrand AS (
	SELECT
		BrandName,
		COUNT(*) AS 'Qty'
	FROM
		DimProduct
	GROUP BY
		BrandName
)
SELECT MAX(Qty) AS 'Max Qty' FROM CTE_ProductsPerBrand
GO

WITH CTE_ProductsAdventureWorks AS (
	SELECT
		ProductKey,
		ProductName,
		ProductSubcategoryKey,
		BrandName,
		UnitPrice
	FROM DimProduct
	WHERE BrandName = 'Adventure Works'
),
CTE_CategoryTelevisionsAndMonitors AS (
	SELECT
		ProductSubcategoryKey,
		ProductSubcategoryName
	FROM DimProductSubcategory
	WHERE ProductSubcategoryName IN ('Televisions', 'Monitors')
)

SELECT
	PAW.*,
	CTM.ProductSubcategoryName
FROM CTE_ProductsAdventureWorks AS PAW
LEFT JOIN CTE_CategoryTelevisionsAndMonitors AS CTM
	ON PAW.ProductSubcategoryKey = CTM.ProductSubcategoryKey
GO
