/*	Primary Key | Foreign Key
	Fact Table | Dimension Table
	JOINS
	INNER JOIN | LEFT JOIN | RIGHT JOIN | 
	FULL JOIN | CROSS JOIN | MULTI JOIN
	UNION | UNION ALL
*/

	-- INNER JOIN EXAMPLE --
/*
	SELECT
		TABLE_A.COLUMN1,
		TABLE_A.COLUMN2,
		TABLE_A.COLUMN3,
		TABLE_B.COLUMN4
	FROM
		TABLE_A
	INNER JOIN
		TABLE_B
	ON
		TABLE_A.FOREIGN_KEY = TABLE_B.PRIMARY_KEY
*/

	-- EXAMPLE: INNER JOIN, LEFT JOIN, RIGHT JOIN --
/*SELECT
	ProductKey, ProductName, ProductSubcategoryKey
FROM
	DimProduct
SELECT
	ProductSubcategoryKey, ProductSubcategoryName
FROM
	DimProductSubcategory*/

-- INNER JOIN --
SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductSubcategoryName
FROM
	DimProduct
INNER JOIN 
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
-- 2,517 rows --

-- LEFT JOIN --
SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductSubcategoryName
FROM
	DimProduct
LEFT JOIN 
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
-- 2,517 rows --

-- RIGHT JOIN --
SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductSubcategoryName
FROM
	DimProduct
RIGHT JOIN 
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
-- 2,529 rows --

	-- Subcategories Names and Products Names with INNER JOIN --
SELECT TOP(5) * FROM DimProduct
SELECT TOP(5) * FROM DimProductSubcategory
SELECT
	ProductKey,
	ProductName,
	ProductSubcategoryName
FROM
	DimProduct
INNER JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

	-- LEFT JOIN --
	-- Categories and Subcategories --
SELECT TOP(5) * FROM DimProductSubcategory
SELECT TOP(5) * FROM DimProductCategory

SELECT
	ProductCategoryName,
	ProductSubcategoryName
FROM
	DimProductCategory
LEFT JOIN
	DimProductSubcategory
ON
	DimProductCategory.ProductCategoryKey = DimProductSubcategory.ProductCategoryKey

	-- LEFT JOIN --
	-- Stores in Continents and Country --
SELECT TOP(5) * FROM DimStore
SELECT TOP(5) * FROM DimGeography

SELECT
	StoreKey,
	StoreName,
	EmployeeCount,
	ContinentName,
	RegionCountryName
FROM
	DimStore
LEFT JOIN
	DimGeography
ON
	DimStore.GeographyKey = DimGeography.GeographyKey
ORDER BY
	RegionCountryName

	-- Add Product Category Description to DimProduct --
SELECT TOP(2) * FROM DimProduct
SELECT TOP(2) * FROM DimProductCategory
SELECT TOP(2) * FROM DimProductSubcategory

SELECT
	ProductName,
	ProductCategoryDescription
FROM
	DimProduct
LEFT JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		LEFT JOIN
			DimProductCategory
		ON
			DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

	-- Strategic Planning for Accounts -- 
SELECT TOP(1) * FROM DimAccount
SELECT TOP(1) * FROM FactStrategyPlan

SELECT TOP(10000)
	StrategyPlanKey,
	Datekey,
	AccountName,
	Amount
FROM
	DimAccount
INNER JOIN
	FactStrategyPlan
ON
	DimAccount.AccountKey = FactStrategyPlan.AccountKey
ORDER BY
	Amount
DESC

	-- Strategic Scenario --
SELECT TOP(1) * FROM FactStrategyPlan
SELECT TOP(1) * FROM DimScenario

SELECT
	StrategyPlanKey,
	DateKey,
	ScenarioName,
	Amount
FROM
	DimScenario
LEFT JOIN
	FactStrategyPlan
ON
	DimScenario.ScenarioKey = FactStrategyPlan.ScenarioKey
ORDER BY
	Amount
DESC

	-- Subcategories without Products --
SELECT TOP(1) * FROM DimProduct
SELECT TOP(1) * FROM DimProductSubcategory

SELECT
	ProductKey,
	ProductName,
	ProductSubcategoryName
FROM
	DimProduct
FULL JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE
	ProductName IS NULL

	-- Brands Contoso, Fabrikam and Litware with Channel Names --
SELECT TOP(1) * FROM DimProduct
SELECT TOP(1) * FROM DimChannel

SELECT DISTINCT
	BrandName,
	ChannelName
FROM
	DimProduct CROSS JOIN DimChannel
WHERE
	BrandName IN ('Contoso', 'Fabrikam', 'Litware')

	-- Sales Online with Promotion --
SELECT TOP(1) * FROM FactOnlineSales
SELECT TOP(1) * FROM DimPromotion

SELECT
	OnlineSalesKey,
	DateKey,
	PromotionName,
	SalesAmount
FROM
	FactOnlineSales
INNER JOIN
	DimPromotion
ON
	FactOnlineSales.PromotionKey = DimPromotion.PromotionKey
WHERE
	PromotionName <> 'No Discount'
ORDER BY
	Datekey

	-- Sales Amount by Fact Sales --
SELECT TOP(1) * FROM FactSales
SELECT TOP(1) * FROM DimChannel
SELECT TOP(1) * FROM DimStore
SELECT TOP(1) * FROM DimProduct

SELECT
	SalesKey,
	ChannelName,
	StoreName,
	ProductName,
	SalesAmount
FROM
	FactSales
INNER JOIN
	DimChannel
ON
	FactSales.channelKey = DimChannel.ChannelKey
INNER JOIN
	DimStore
ON
	FactSales.StoreKey = DimStore.StoreKey
INNER JOIN
	DimProduct
ON
	FactSales.ProductKey = DimProduct.ProductKey
ORDER BY
	SalesAmount