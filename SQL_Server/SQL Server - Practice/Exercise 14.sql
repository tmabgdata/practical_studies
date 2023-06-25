	/*
		LOOPS
		WHILE
		BREAK
		CONTINUE
	*/

	-- WHILE --
DECLARE @varCount INT
SET @varCount = 1
GO

WHILE @varCount <= 10
BEGIN
	PRINT 'The Value of Count is: ' + CONVERT(VARCHAR, @varCount) 
	SET @varCount = @varCount + 1
END
GO
	
	-- BREAK | += --
DECLARE @varCount2 INT
SET @varCount2 = 1

WHILE @varCount2 <=100
BEGIN
	PRINT 'The Value of Count is: ' + CONVERT(VARCHAR, @varCount2)
	IF @varCount2 = 15
	BREAK
	SET @varCount2 += 1
END

	-- CONTINUE --
DECLARE @varCount3 INT
SET @varCount3 = 0

WHILE @varCount3 < 10
BEGIN
	SET @varCount3 += 1
	IF @varCount3 = 3 OR @varCount3 = 6
	CONTINUE
	PRINT 'The Value of Count is: ' + CONVERT(VARCHAR, @varCount3)
END
GO

	-- EXERCISES --

DECLARE @initialValue INT
DECLARE @finalValue INT
SET @initialValue = 1
SET @finalValue = 100

WHILE  @initialValue <= @finalValue 
BEGIN
	PRINT 'The Initial Value is: ' + CONVERT(VARCHAR, @initialValue)
	SET @initialValue += 1
END

	-- Number of employees hired each year (1996 - 2003) --

DECLARE @firstYear INT = 1996
DECLARE @lastYear INT = 2003

WHILE @firstYear <= @lastYear
BEGIN
	DECLARE @qtyEmployees INT = (SELECT COUNT(*) FROM DimEmployee
								 WHERE YEAR(HireDate) = @firstYear)

	PRINT CONCAT(@qtyEmployees, ' Hired in ', @firstYear)

	SET @firstYear += 1

END

	-- Creating Calendar Table 2023 to 2024 --

CREATE TABLE Calendar (
	Date DATE
)

DECLARE @startDate DATE = '01/01/2023'
DECLARE @finalDate DATE = '12/31/2024'

WHILE @startDate < @finalDate
BEGIN
	INSERT INTO Calendar (Date) VALUES (@startDate)
	SET @startDate = DATEADD(DAY, 1, @startDate)
END

SELECT * FROM Calendar
DROP TABLE Calendar