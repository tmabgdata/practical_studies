/*	ORDER BY
	WHERE
	WHERE LIKE
	WHERE OR/AND
	WHERE IN
	WHERE (NOT) BETWEEN
	WHERE IS (NOT) NULL*/

-- STORE WITH MORE EMPLOYEES
SELECT TOP(100)
	*
FROM
	DimStore
ORDER BY
	EmployeeCount
DESC

-- SELECTING 10 FIRSTS ROWS FROM DimProduct ORDER BY UnitCost
SELECT 
	*
FROM
	DimProduct

SELECT
	ProductName AS 'Product Name',
	UnitCost AS 'Unit Cost'
FROM
	DimProduct

SELECT TOP(10)
	ProductName AS 'Product Name',
	UnitCost AS 'Unit Cost',
	Weight
FROM
	DimProduct
ORDER BY
	UnitCost
DESC,
	Weight DESC

-- More Expansive
SELECT TOP(1)
	UnitPrice
FROM
	DimProduct
ORDER BY
	UnitPrice
DESC

-- Unit Price more than $1k

SELECT
	ProductName AS 'Product',
	UnitPrice AS 'Price'
FROM
	DimProduct

SELECT
	ProductName AS 'Product',
	UnitPrice AS 'Price'
FROM
	DimProduct
WHERE
	UnitPrice >= 1000
ORDER BY
	Price DESC

-- Products from Brand Contoso
SELECT
	*
FROM
	DimProduct
WHERE
	BrandName = 'Contoso'

-- Products with black color
SELECT
	*
FROM
	DimProduct
WHERE
	ColorName = 'Black'

-- How many clients were born after 12/31/1970
SELECT
	*
FROM
	DimCustomer
WHERE
	BirthDate >= '1970-12-31'
ORDER BY
	BirthDate DESC

-- Brand: Contoso, color: Silver
SELECT
	ProductName AS 'Product',
	BrandName AS 'Brand',
	ColorName 'Color'
FROM
	DimProduct
WHERE
	BrandName = 'Contoso'
AND
	ColorName = 'Silver'

-- Color: Blue or Silver
SELECT
	*
FROM
	DimProduct
WHERE
	ColorName = 'Blue'
OR
	ColorName= 'Silver'

-- Products Not Blue
SELECT
	*
FROM
	DimProduct
WHERE NOT
	ColorName = 'Blue'

-- Brand: Contoso OR Wide World Importers
SELECT
	*
FROM
	DimProduct
WHERE
	BrandName = 'Contoso'
OR
	BrandName = 'Wide World Importers'

-- Employees not in Marketing Department
SELECT
	*
FROM
	DimEmployee
WHERE NOT
	DepartmentName = 'Marketing'

-- Women in Finance Department
SELECT
	*
FROM
	DimEmployee
WHERE
	Gender = 'F' AND DepartmentName = 'Finance'
-- Products with Brand: Contoso, Color: Red and Unit Price >= 100$
SELECT
	*
FROM
	DimProduct
WHERE
	BrandName = 'Contoso'
AND
	ColorName = 'Red'
AND
	UnitPrice >= 100
ORDER BY
	UnitPrice DESC

-- Products with Brand: Litware, Fabrikam or Color: Black
SELECT
	*
FROM
	DimProduct
WHERE
	BrandName = 'Litware'
OR
	BrandName = 'Fabrikam'
OR
	ColorName = 'Black'

-- Territory = Europe but not in Italy
SELECT
	*
FROM
	DimSalesTerritory
WHERE
	SalesTerritoryGroup = 'Europe'
AND NOT
	SalesTerritoryCountry = 'Italy'

-- Product with brand Fabrikam, color red or black
SELECT
	*
FROM
	DimProduct
WHERE
	(ColorName = 'Red' OR ColorName = 'Black')
AND
	BrandName = 'Fabrikam'

-- Clause IN
SELECT
	*
FROM
	DimProduct
WHERE
	ColorName
IN
	('Silver', 'Black', 'Red', 'Blue', 'White')

SELECT
	*
FROM
	DimEmployee
WHERE
	DepartmentName
IN
	('Marketing', 'Engineering', 'Production')

-- LIKE %
SELECT
	*
FROM
	DimProduct
WHERE
	ProductDescription
LIKE
	'%MP3 Player%'

SELECT
	*
FROM
	DimProduct
WHERE
	ProductDescription
LIKE
	'TYPE%'

SELECT
	*
FROM
	DimProduct
WHERE
	ProductDescription
LIKE
	'%TYPE%'

SELECT
	*
FROM
	DimProduct
WHERE
	ProductDescription
LIKE
	'%WMA'

-- BETWEEN
SELECT
	*
FROM
	DimProduct
WHERE
	UnitPrice
BETWEEN
	50 AND 100

SELECT
	*
FROM
	DimProduct
WHERE
	UnitPrice
NOT BETWEEN
	50 AND 100

-- Employees hired at year 2000
SELECT
	*
FROM
	DimEmployee
WHERE
	HireDate
BETWEEN
	'2000-01-01' AND '2000-12-31'

-- IS NULL | IS NOT NULL
-- Persons
SELECT
	*
FROM 
	DimCustomer
WHERE
	CompanyName IS NULL

-- Company
SELECT
	*
FROM 
	DimCustomer
WHERE
	CompanyName IS NOT NULL

-- Exercises--

-- Top 100 sales by sales amount
SELECT TOP(100)
	ProductName AS 'Product Name',
	SalesQuantity AS 'Sales Quantity',
	SalesAmount AS 'Sales Amount'
FROM 
	DimProduct
INNER JOIN
	FactSales
ON
	FactSales.ProductKey = DimProduct.ProductKey
ORDER BY
	[Sales Amount] DESC

-- Top 10 products by unit price
SELECT * FROM DimProduct
SELECT TOP(10) 
	ProductName AS 'Product',
	UnitPrice AS 'Price',
	Weight,
	AvailableForSaleDate AS 'For Sale Date'
FROM
	DimProduct
ORDER BY 
	[Price] DESC, [Weight] DESC, [For Sale Date] ASC

-- Products in Category A = +100KG
SELECT * FROM DimProduct
SELECT
	ProductName AS 'Product',
	Weight
FROM
	DimProduct
WHERE
	(Weight/2.2046) >= 100 -- Pounds to Kg
ORDER BY
	Weight DESC

-- Contoso Stores Still Open
SELECT * FROM DimStore
SELECT
	StoreName AS 'Name',
	OpenDate AS 'Opening',
	EmployeeCount AS 'Employee Qnt'
FROM
	DimStore
WHERE
	StoreType = 'Store' AND Status = 'ON'
ORDER BY
	[Employee Qnt]

-- Home Theate ID's from Brand Litware mande on 2009-03-15
SELECT * FROM DimProduct
SELECT
	ProductKey AS 'ID',
	ProductName AS 'Product',
	BrandName AS 'Brand',
	AvailableForSaleDate AS 'Sale Date'
FROM
	DimProduct
WHERE
	ProductName LIKE '%Home Theater%'
AND
	BrandName = 'Litware'
AND
	AvailableForSaleDate = '2009-03-15'

-- Contoso Store's Closed
SELECT * FROM DimStore
	-- Filtered by status: --
SELECT
	StoreName AS 'Name',
	Status,
	StoreType AS 'Type',
	CloseReason AS 'Reason'
FROM
	DimStore
WHERE
	Status = 'Off'

	-- Filtered by Close Date: --
SELECT
	StoreName AS 'Name',
	Status,
	StoreType AS 'Type',
	CloseDate AS 'Close',
	CloseReason AS 'Reason'
FROM
	DimStore
WHERE
	CloseDate IS NOT NULL

-- Coffee's Bottle from Store
-- A: 1-20 Employees = 1 Coffee's Bottle
-- B: 21-50 Employees = 2 Coffee's Bottle
-- C: 50+ Employees = 3 Coffee's Bottle
SELECT * FROM DimStore
	-- A - 1 Coffee's Bottle --
SELECT
	StoreKey AS 'ID',
	StoreName AS 'Name',
	EmployeeCount AS 'Employee Qnt',
	SellingAreaSize AS 'Area'
FROM
	DimStore
WHERE
	StoreType = 'Store'
AND
	EmployeeCount BETWEEN 1 AND 20
ORDER BY
	EmployeeCount

	-- B -- 2 Coffee's Bottle --
SELECT
	StoreKey AS 'ID',
	StoreName AS 'Name',
	EmployeeCount AS 'Employee Qnt',
	SellingAreaSize AS 'Area'
FROM
	DimStore
WHERE
	StoreType = 'Store'
AND
	EmployeeCount BETWEEN 21 AND 50
ORDER BY
	EmployeeCount

	-- C -- 3 Coffee's Bottle --
SELECT
	StoreKey AS 'ID',
	StoreName AS 'Name',
	EmployeeCount AS 'Employee Qnt',
	SellingAreaSize AS 'Area'
FROM
	DimStore
WHERE
	StoreType = 'Store'
AND
	EmployeeCount > 50
ORDER BY
	EmployeeCount

-- Discount in LCD's TVs Products
SELECT * FROM DimProduct
SELECT
	ProductKey AS 'ID',
	ProductName AS 'Product',
	ProductDescription AS 'Description',
	UnitPrice AS 'Price'
FROM
	DimProduct
WHERE
	ProductName LIKE '%LCD%'
AND
	ProductDescription LIKE '%TV%'

-- Products were Brand Contoso, Litware and Fabrikam. And colors green, orange, black and pink
SELECT
	ProductName AS 'Product',
	BrandName AS 'Brand',
	ColorName AS 'Color'
FROM
	DimProduct
WHERE 
	BrandName IN ('Contoso', 'Litware', 'Fabrikam')
AND
	ColorName IN ('Green', 'Orange', 'Black', 'Pink')
ORDER BY
	ColorName

-- Contoso Silver's products with price between 10$ and 30$
SELECT
	ProductName AS 'Product',
	BrandName AS 'Brand',
	ColorName AS 'Color',
	UnitPrice AS 'Price'
FROM
	DimProduct
WHERE
	(BrandName = 'Contoso' AND ColorName = 'Silver')
AND
	UnitPrice
BETWEEN
	10 AND 30
ORDER BY
	UnitPrice DESC