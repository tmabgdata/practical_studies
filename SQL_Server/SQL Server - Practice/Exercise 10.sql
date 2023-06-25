	-- CASE/IIF EXERCISES --

	-- DimProduct --

	-- Economy -> 5%
	-- Regular -> 7%
	-- Deluxe -> 9%

SELECT
	ProductKey AS 'Product ID',
	ProductName AS 'Product',
	ClassName AS 'Class',
	UnitPrice AS 'Price',
	CASE
		WHEN ClassName = 'Economy' THEN ROUND((1 - 0.05) * UnitPrice, 2)
		WHEN ClassName = 'Regular' THEN ROUND((1 - 0.07) * UnitPrice, 2)
		ELSE ROUND((1 - 0.09) * UnitPrice, 2) 
	END AS '% Discount'
FROM
	DimProduct
ORDER BY
	ClassName

	-- Applying Variables in % Discounts on Class Unit Prices--

DECLARE @varDiscountEconomy FLOAT, 
		@varDiscountRegular FLOAT, 
		@varDiscountDeluxe FLOAT
SET @varDiscountEconomy = (1 - 0.05)
SET	@varDiscountRegular = (1 - 0.07) 
SET	@varDiscountDeluxe = (1 - 0.09)

SELECT
	ProductKey AS 'Product ID',
	ProductName AS 'Product',
	ClassName AS 'Class',
	UnitPrice AS 'Price',
	IIF(
		ClassName = 'Economy',
		ROUND(@varDiscountEconomy * UnitPrice, 2),
			IIF(
				ClassName = 'Regular',
				ROUND(@VarDiscountRegular * UnitPrice, 2),
				ROUND(@VarDiscountDeluxe * UnitPrice, 2)
				)
			) AS '% Discount'
FROM
	DimProduct
ORDER BY
	ClassName

	-- Total Product Per Brad --

SELECT
	BrandName AS 'Brand',
	COUNT(ProductKey) AS 'Qtt Product',
	IIF(
		COUNT(ProductKey) > 500,
		'Category A',
			IIF(
				COUNT(ProductKey) >= 100,
				'Category B',
				'Category C'
				)
		) AS 'Category'
FROM
	DimProduct
GROUP BY
	BrandName
ORDER BY
	COUNT(ProductKey) DESC

	-- Category's Store per Employee Count --

SELECT
	StoreName AS 'Store',
	EmployeeCount AS 'Qtt Employee',
	CASE
		WHEN EmployeeCount > 50 THEN 'Over 50 employees'
		WHEN EmployeeCount > 40 THEN 'Between 40 and 50 employees'
		WHEN EmployeeCount > 30 THEN 'Between 30 and 40 employees'
		WHEN EmployeeCount > 20 THEN 'Between 20 and 30 employees'
		WHEN EmployeeCount >= 10 THEN 'Between 10 and 20 employees'
		ELSE 'Below 10 employees'
	END 'Class Store'
FROM DimStore
ORDER BY EmployeeCount

	-- 100 models of each subcategory from Seattle to Sunnyside --

SELECT 
	ProductSubcategoryName AS 'Subcategory Name',
	ROUND(AVG(Weight) * 100, 2) AS 'Total Weight',
	CASE
		WHEN ROUND(AVG(Weight) * 100, 2) >= 1000 THEN 'Rota 2'
		ELSE 'Rota 1'
	END AS 'Rota'
FROM
	DimProduct
INNER JOIN
	DimProductSubcategory
ON
	DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
GROUP BY
	ProductSubcategoryName
ORDER BY
	ROUND(AVG(Weight) * 100, 2)

	-- Awards! --

SELECT
	FirstName AS 'Name',
	Gender,
	TotalChildren,
	EmailAddress,
	CASE
		WHEN Gender = 'F' AND TotalChildren >= 1 THEN 'Mother of the Year'
		WHEN Gender = 'M' AND TotalChildren >= 1 THEN 'Father of the Year'
		ELSE 'Prize Truck'
	END 'Awards'
FROM
	DimCustomer
WHERE 
	FirstName IS NOT NULL
ORDER BY
	Awards

	-- More Time Active Store --

SELECT
	StoreName,
	OpenDate,
	CloseDate,
	CASE
		WHEN CloseDate IS NULL THEN DATEDIFF(DAY, OpenDate, GETDATE())
		ELSE DATEDIFF(DAY, OpenDate, CloseDate)
	END AS 'Active Days'
FROM
	DimStore
	