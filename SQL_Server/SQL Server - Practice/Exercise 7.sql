	-- ENVIRONMENT VARIABLES --

DECLARE @value1 FLOAT = 10, @value2 FLOAT = 5, @value3 FLOAT = 34, @value4 FLOAT = 7
DECLARE @sum FLOAT, @subtraction FLOAT, @multiplication FLOAT, @division FLOAT

	-- SQL VARIANT PROPERTY --

SELECT 10 AS 'Number'
SELECT 49.50 AS 'Decimal'
SELECT 'Matheus' AS 'Varchar'
SELECT '06/05/2023' AS 'Date'

SELECT SQL_VARIANT_PROPERTY(10, 'BaseType') AS 'Int'
SELECT SQL_VARIANT_PROPERTY(49.50, 'BaseType') AS 'Numeric'
SELECT SQL_VARIANT_PROPERTY('Matheus', 'BaseType') AS 'Varchar'
SELECT SQL_VARIANT_PROPERTY('06/05/2023', 'BaseType') AS 'Varchar'

	-- CAST --

SELECT SQL_VARIANT_PROPERTY(21.45, 'BaseType')

SELECT CAST(21.45 AS INT)
SELECT CAST(21.45 AS FLOAT)
SELECT CAST(19.5 AS FLOAT)
SELECT CAST('13.56' AS FLOAT)
SELECT CAST('06/05/2023' AS DATETIME)

SELECT 'The Price of Fries is: $' + CAST(5.25 AS VARCHAR(10))

SELECT CAST('06/05/2023' AS DATETIME) + 1

	-- FORMAT --
-- Numerics --
SELECT FORMAT(1000, 'N') AS 'Numeric'
SELECT FORMAT(1000, 'G') AS 'General'

-- Personalized --
SELECT FORMAT(123456789, '###-###-###')

-- Date --
SELECT FORMAT(CAST('06/05/2023' AS DATETIME), 'dd/MM/yyyy')
SELECT FORMAT(CAST('06/05/2023' AS DATETIME), 'dd/MMM/yyyy')
SELECT FORMAT(CAST('06/05/2023' AS DATETIME), 'dd/MMMM/yyyy')
SELECT FORMAT(CAST('06/05/2023' AS DATETIME), 'ddd/MM/yyyy')
SELECT FORMAT(CAST('06/05/2023' AS DATETIME), 'dddd/MM/yyyy')
SELECT FORMAT(CAST('06/05/2023' AS DATETIME), 'dd/MM/yy')
SELECT FORMAT(CAST('06/05/2023' AS DATETIME), 'ddd')
SELECT FORMAT(CAST('06/05/2023' AS DATETIME), 'dddd')

-- The expiry date of the product is --
SELECT 'The expiry date of the product is ' + FORMAT(CAST('08/22/2023' AS DATETIME), 'dd/MMM/yyyy')

	-- ROUND | FLOOR | CEILING --

-- ROUND --
SELECT ROUND(16.59644225, 2)
SELECT ROUND(16.59644225, 2, 1)
SELECT ROUND(16.59644225, 3, 1)

-- FLOOR --
SELECT FLOOR(16.59644225)

-- CEILING --
SELECT CEILING(16.59644225)

	-- DECLARE & SET --
-- Variable's Structure --
/*
	DECLARE @var TYPE
	SET @var = VALUE
	SELECT @var
*/

DECLARE @age INT
SET @age = 31
SELECT @age AS 'Age'

DECLARE @name VARCHAR(30)
SET @name = 'Emanuelle'
SELECT @name

DECLARE @date DATETIME
SET @date = '06/05/2023'
SELECT @date

	-- DECLARE OPTIONS --
-- Option 1 --
DECLARE @var1 INT
DECLARE @text VARCHAR(30)
DECLARE @date1 DATETIME

SET @var1 = 10
SET @text = 'A random text'
SET @date1 = '09/05/2023'

SELECT @var1, @text, @date1

-- Option 2 --
DECLARE @var2 INT,
		@text2 VARCHAR(30),
		@date2 DATETIME

SET @var2 = 20
SET @text2 = 'A second random text'
SET @date2 = '10/25/2023'

SELECT @var2, @text2, @date2

-- Option 3 --
DECLARE @var3 INT = 30,
		@text3 VARCHAR(30) = 'A third random text',
		@date3 DATETIME = '04/06/2023'

SELECT @var3, @text3, @date3

-- Example --
DECLARE @qtt INT = 100
DECLARE @price FLOAT = 75.95
DECLARE @income FLOAT = @qtt * @price
SELECT CONCAT(@income, ' $') AS 'Income'

	-- Variables in Query --

	/*	price = 100
		discount = 10% = 10/100 = 0.10
		discount_value = 100 * 0.10 = 10
		price_with_discount = 100 - 100 * 0.10 = 90
		price_with_discount = 100 * (1 - 0.10) = 90
		price_with_discount = 100 * (1 - discount) = 90
	*/

	-- without variable --
SELECT
	ProductKey AS 'ID',
	ProductName AS 'Product',
	CONCAT(CEILING(UnitPrice * (1 - 0.10)), '.00 $') AS 'Price with discount'
FROM
	DimProduct

	-- with variable --
DECLARE @varDiscount FLOAT
SET @varDiscount = 0.10

SELECT
	ProductKey AS 'ID',
	ProductName AS 'Product',
	UnitPrice * (1 - @varDiscount) AS 'Price with discount'
FROM
	DimProduct
	
	-- VARIABLES in SELECT --
-- Total Employees --
DECLARE @varTotalEmployees INT
SET @varTotalEmployees = (SELECT COUNT(*) FROM DimEmployee)
SELECT @varTotalEmployees

-- Total Stores with Status OFF --

DECLARE @varClosedStores INT
SET @varClosedStores = (SELECT COUNT(*) FROM DimStore WHERE Status = 'OFF')
SELECT @varClosedStores

	-- PRINT --
SET NOCOUNT ON 
DECLARE @varOnStores INT, 
		@varOffStores INT
SET @varOnStores = (SELECT COUNT(*) FROM DimStore WHERE Status = 'ON')
SET @varOffStores = (SELECT COUNT(*) FROM DimStore WHERE Status = 'OFF')

SELECT @varOnStores AS 'Open Stores', @varOffStores AS 'Closed Stores'

PRINT 'Total of Stores Open is ' + CAST(@varOnStores AS VARCHAR(30))
PRINT 'Total of Stores Closed is ' + CAST(@varOffStores AS VARCHAR(30))

	-- Product with more Sales in a Sold --
DECLARE @varBestSelliingProduct INT, @varTotalBestSellers INT

SELECT TOP(1)
	@varBestSelliingProduct = ProductKey,
	@varTotalBestSellers = SalesQuantity
FROM
	FactSales
ORDER BY
	SalesQuantity
DESC

PRINT @varBestSelliingProduct
PRINT @varTotalBestSellers

SELECT
	ProductKey,
	ProductName
FROM
	DimProduct
WHERE
	ProductKey = @varBestSelliingProduct

	-- List of Names --
DECLARE @varListNames VARCHAR(50)
SET @varListNames = ''
SELECT
	@varListNames = @varListNames + FirstName + ', ' + CHAR(10)
FROM
	DimEmployee
WHERE
	DepartmentName = 'Marketing' AND Gender = 'F'
PRINT
	LEFT(@varListNames, DATALENGTH(@varListNames) - 3)

	-- GLOBAL VARIABLES SELECT @@ --

	-- Store Closed in 2008 --

DECLARE @varListStore VARCHAR(50)
SET @varListStore = ' '

SELECT
	@varListStore = @varListStore + StoreName + ', '
FROM
	DimStore
WHERE FORMAT(CloseDate, 'yyyy') = 2008

PRINT 'The Stores Closed in 2008 were' + @varListStore

--

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

DECLARE @varSubcategoryKey INT
DECLARE @varSubcategoryName VARCHAR(30)

SET @varSubcategoryName = 'Fans'
SET @varSubcategoryKey = (SELECT ProductSubcategoryKey FROM DimProductSubcategory WHERE ProductSubcategoryName = @varSubcategoryName)

SELECT
	*
FROM
	DimProduct
WHERE
	ProductSubcategoryKey = @varSubcategoryKey