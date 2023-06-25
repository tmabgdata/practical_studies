-- SQL Practice with Microsof Contoso Database: 
	https://www.microsoft.com/en-us/download/details.aspx?id=18279

-- First Exercises:

--	This is a comment, using ' -- ' to comment.
/*	
	This is a greate comment,
	with more than a line.
	Using /* */
*/

-- Selecting the top 10 male customers who are married and have children
SELECT TOP (10)
	FirstName,
	LastName,
	EmailAddress,
	TotalChildren
FROM
	DimCustomer
WHERE
	MaritalStatus
=	'M'
AND
	Gender
= 'M'
AND
	TotalChildren
<> 0

-- Selecting percenting
-- Selecting 10% of female customer who are single and have children
SELECT TOP (10) PERCENT
	FirstName,
	LastName,
	EmailAddress,
	TotalChildren
FROM
	DimCustomer
WHERE
	MaritalStatus
=	'S'
AND
	Gender
= 'F'
AND
	TotalChildren
<> 0


-- SELECT DISTINCT
SELECT ColorName FROM DimProduct
SELECT DISTINCT ColorName FROM DimProduct

SELECT
	*
FROM
	DimEmployee

SELECT
	DISTINCT DepartmentName
FROM
	DimEmployee

-- Command AS: Rename columns (aliasing)
-- Selecting three columns from DimProduct: ProductName, BrandName and ColorName
SELECT
	ProductName,
	BrandName,
	ColorName
FROM
	DimProduct
-- ALIASING
SELECT
	ProductName AS 'Product Name',
	BrandName AS 'Brand',
	ColorName AS 'Color'
FROM
	DimProduct

-- Are there more or less than 2,517 products in the database?
SELECT
	*
FROM
	DimProduct
-- There are exactly 2,517 products in the database.

/* Until last month, the company had a total of 19,500 customers in the control base.
Check whether this number has increased or decreased.*/
SELECT
	*
FROM
	DimCustomer
-- A total of 18,869 registered customers were found in the database.

-- Offer special discounts to customers on their birthdays.
SELECT
	CustomerKey AS 'ID',
	FirstName AS 'Name',
	EmailAddress AS 'Email',
	BirthDate AS 'Birth Date'
FROM
	DimCustomer

-- 100 first customers in history with a shopping voucher of $ 10,000
SELECT TOP(100)
	FirstName AS 'Name',
	EmailAddress AS 'Email',
	BirthDate AS 'Birth Date'
FROM
	DimCustomer

-- 20% first customers in history with a shopping voucher of $ 2,000
SELECT TOP(20) PERCENT
	FirstName AS 'Name',
	EmailAddress AS 'Email',
	BirthDate AS 'Birth Date'
FROM
	DimCustomer

-- Suppliers
SELECT 
	DISTINCT Manufacturer AS 'Supplier'
FROM 
	DimProduct

-- A product with no Sale?
SELECT DISTINCT
	ProductKey
FROM
	DimProduct
-- 2517 Products
SELECT DISTINCT 
	ProductKey
FROM 
	FactSales
-- 2516 Products
-- One product has no sale