/*	CASE WHEN/ELSE
	NESTED CASE
	CASE/AND
	CASE/OR
	ADDENDUM CASE
	IIF - ISNULL
*/

	-- CASE: Conditional Function --
	/*	CASE
			WHEN logic_test THEN 'result 1'
			ELSE 'result 2'
		END
	*/
-- First Example --
DECLARE @varScore FLOAT
SET @varScore = 4.5

SELECT
	CASE	
		WHEN @varScore >= 4 THEN 'Good Score'
		ELSE 'Bad Score'
	END AS 'Score Note'

-- Second Example --
DECLARE @varDueDate DATETIME, @varCurrentDate DATETIME
SET @varDueDate = '06/03/2023'
SET @varCurrentDate = GETDATE()

SELECT
	CASE
		WHEN @varCurrentDate > @varDueDate THEN 'Expired Product'
		ELSE 'Unexpired Product'
	END AS 'Product Validity'

-- Third Example --
SELECT
	CustomerKey AS 'Customer ID',
	FirstName AS 'Name',
	Gender AS 'Gender short',
	CASE
		WHEN Gender = 'M' THEN 'Malle'
		WHEN Gender = 'F' THEN 'Femalle'
		ELSE 'COMPANY'
	END AS 'Gender'
FROM
	DimCustomer

-- Product from brand Contoso and your color is Red to apply 10% discount --
SELECT
	ProductName AS 'Product',
	BrandName AS 'Brand',
	ColorName AS 'Color',
	UnitPrice AS 'Price',
	CASE
		WHEN BrandName = 'Contoso' AND ColorName = 'Red' THEN 0.1
		ELSE 0
	END AS 'Price of Discount'
FROM
	DimProduct

-- 5% discount on Brands Litware and Fabrikam --
SELECT
	ProductName AS 'Product',
	BrandName AS 'Brand',
	ColorName AS 'Color',
	UnitPrice AS 'Price',
	CASE
		WHEN BrandName = 'Litware' OR BrandName = 'Fabrikam' THEN 0.05
		ELSE 0
	END AS 'Price of Discount'
FROM
	DimProduct

	-- NESTED CASE -- 
	-- DimEmployee --
SELECT TOP(10) * FROM DimEmployee

-- 4 Offices (Title):
-- Sales Group Manager
-- Sales Region Manager
-- Sales State Manager
-- Sales Store Manager

-- Salaried (SalariedFlag?)
-- SalariedFlag = 0: Not Salaried
-- SalariedFlag = 1: Salaried

-- Bonus Calculation
-- Sales Group Manager: Salaried, 30%; Not Salaried, 20%
-- Sales Region Manager: 15%
-- Sales State Manager: 7%
-- Sales Store Manager: 2%

SELECT
	FirstName AS 'Name',
	Title AS 'Office',
	SalariedFlag,
	CASE
		WHEN Title = 'Sales Group Manager' THEN
			CASE
				WHEN SalariedFlag = 1 THEN 0.3
				ELSE 0.2
			END
		WHEN Title = 'Sales Region Manager' THEN 0.15
		WHEN Title = 'Sales State Manager' THEN 0.7
	ELSE 0.02
	END 'Bonus Calculation'
FROM
	DimEmployee

	-- ADDENDUM CASE --
SELECT
	ProductKey AS 'Product ID',
	ProductName AS 'Product',
	ProductCategoryName AS 'Category',
	ProductSubcategoryName AS 'Subcategory',
	UnitPrice,
	CASE WHEN ProductCategoryName = 'TV and Video'
		THEN 0.10 ELSE 0 END
	+ CASE WHEN ProductSubcategoryName = 'Televisions'
		THEN 0.05 ELSE 0 END AS 'Discount' 
FROM
	DimProduct
INNER JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
INNER JOIN
	DimProductCategory
ON
	DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

	-- IIF --
DECLARE @varClassification INT
SET @varClassification = 9

SELECT
	IIF(
		@varClassification >= 5,
		'Risco Alto',
		'Risco Baixo')
	
	-- IFF on DimCustomer --

SELECT
	CustomerKey AS 'Customer ID',
	CustomerType AS 'Type',
	IIF(
		CustomerType = 'Person',
		FirstName,
		CompanyName) AS 'Customer'
FROM
	DimCustomer

	-- John: High, Mary: Mid, Luiz: Low --
SELECT
	ProductKey AS 'Product ID',
	ProductName AS 'Product',
	StockTypeName AS 'Type',
	IIF(
		StockTypeName = 'High',
		'Jonh',
		IIF(
			StockTypeName = 'Mid',
			'Mary',
			'Luiz')
		) AS 'Manager'
FROM
	DimProduct

	-- ISNULL --
SELECT
	GeographyKey AS 'Geo ID',
	ContinentName AS 'Continent Name',
	ISNULL(CityName, 'Unknown Location') AS 'City Name'
FROM
	DimGeography