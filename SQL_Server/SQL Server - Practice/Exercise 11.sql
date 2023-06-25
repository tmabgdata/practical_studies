/*	VIEW
	CREATE VIEW
	ALTER VIEW
	DROP VIEW
*/
	
	-- Customers, Email and Birth Date --
CREATE VIEW VW_Customers AS
	SELECT
		FirstName AS 'Name',
		EmailAddress AS 'Email',
		BirthDate AS 'Born'
	FROM
		DimCustomer
GO

SELECT * FROM VW_Customers 
GO

	-- Product Key, Product Name, Product Subcategory Key, Brand Name, Unit Price --
CREATE VIEW VW_Products AS
	SELECT
		ProductKey AS 'ID Product',
		ProductName AS 'Product',
		ProductSubcategoryKey AS 'ID Subcategory',
		BrandName AS 'Brand',
		UnitPrice AS 'Price'
	FROM
		DimProduct
GO

SELECT * FROM VW_Products
GO
	
	-- USING TWO OR MORE DATABASES --
/*	USE ContosoRetailDW
SELECT * FROM VW_Customers
GO	*/

	-- ALTER VIEW [VW_Customers] --
ALTER VIEW VW_Customers AS
	SELECT
		FirstName AS 'Name',
		EmailAddress AS 'Email',
		BirthDate AS 'Born',
		Gender
	FROM
		DimCustomer
	WHERE
		Gender = 'F' -- only Femalle Customers
GO

SELECT * FROM VW_Customers
GO

	-- TO EXCLUDE VIEWS USE DROP COMMAND --
GO
DROP VIEW VW_Products
DROP ViEW VW_Customers
GO

	-- vwProducts --
CREATE VIEW vwProducts AS
SELECT
	ProductName AS 'Product',
	ColorName AS 'Color',
	UnitPrice AS 'Unit Price',
	UnitCost AS 'UnitCost'
FROM
	DimProduct
GO
-- SELECT * FROM vwProducts

	-- vwEmployees --
CREATE VIEW vwEmployees AS
SELECT
	FirstName AS 'Name',
	BirthDate AS 'Born in',
	DepartmentName AS 'Department'
FROM
	DimEmployee
GO
-- SELECT * FROM vwEmployees

	-- vwStores --
CREATE VIEW vwStores AS
SELECT
	StoreKey AS 'Store ID',
	StoreName AS 'Store Name',
	OpenDate AS 'Open Date'
FROM
	DimStore
GO
-- SELECT * FROM vwStores

	-- vwCustomers --
CREATE VIEW vwCustomers AS
SELECT
	CONCAT(FirstName, ' ', LastName) AS 'Complete Name',
	IIF(
		Gender = 'M',
		'Malle',
		'Femalle') AS 'Gender',
	EmailAddress AS 'Email',
	FORMAT(YearlyIncome, 'C') AS 'Income'
FROM
	DimCustomer
WHERE
	EmailAddress IS NOT NULL
GO
-- SELECT * FROM vwCustomers

	-- Active Stores --
CREATE VIEW vwActiveStores AS
SELECT * FROM DimStore WHERE Status = 'On'
GO
-- SELECT * FROM vwActiveStores

	-- Marketing Employees --
CREATE VIEW MktEmployees AS
SELECT
	FirstName AS 'Name',
	EmailAddress AS 'Email',
	DepartmentName AS 'Department'
FROM
	DimEmployee
WHERE
	DepartmentName = 'Marketing'
GO

	-- Silver-colored Contoso and Litware branded products --
CREATE VIEW vwContosoLitwareSilver AS
SELECT
	*
FROM
	DimProduct
WHERE
	BrandName IN ('Contoso', 'Litware') AND ColorName = 'Silver'
GO
	
	-- Total products sold --
CREATE VIEW vwProductSold AS
SELECT
	ProductName AS 'Product',
	SUM(SalesQuantity) AS 'Qty Sold'
FROM
	DimProduct
INNER JOIN
	FactSales
ON
	DimProduct.ProductKey = FactSales.ProductKey
GROUP BY
	ProductName
GO

	-- Changing vwProducts adding brand name --
ALTER VIEW vwProducts AS
SELECT
	ProductName AS 'Product',
	BrandName AS 'Brand',
	ColorName AS 'Color',
	UnitPrice AS 'Unit Price',
	UnitCost AS 'UnitCost'
FROM
	DimProduct
GO
	
	-- Changing vwEmployees view by filtering only for female employees --

ALTER VIEW vwEmployees AS
SELECT
	FirstName AS 'Name',
	BirthDate AS 'Born in',
	Gender AS 'Gender',
	DepartmentName AS 'Department'
FROM
	DimEmployee
WHERE Gender = 'F'
GO
	
	-- Changing vwStores view by filtering only Stores with Status = ON --
ALTER VIEW vwStores AS
SELECT
	StoreKey AS 'Store ID',
	StoreName AS 'Store Name',
	Status,
	OpenDate AS 'Open Date'
FROM
	DimStore
WHERE
	Status = 'On'
GO

	-- Total products per brand --
CREATE VIEW vwProductsBrand AS
SELECT
	BrandName AS 'Brand',
	COUNT(ProductKey) AS 'Products'
FROM
	DimProduct
GROUP BY
	BrandName
GO
	-- Adding Total Weight --
ALTER VIEW vwProductsBrand AS
SELECT
	BrandName AS 'Brand',
	COUNT(ProductKey) AS 'Products',
	SUM(Weight) AS 'Total Weight'
FROM
	DimProduct
GROUP BY
	BrandName
GO

	-- DROP VIEWS --
GO
DROP VIEW vwProducts
DROP VIEW vwCustomers
DROP VIEW vwEmployees
DROP VIEW vwStores
DROP VIEW vwActiveStores
DROP VIEW vwProductSold
DROP VIEW vwProductsBrand
DROP VIEW vwContosoLitwareSilver
GO