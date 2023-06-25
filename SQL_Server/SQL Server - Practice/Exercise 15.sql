	/*
		WINDOW FUNCTIONS
		OVER
		PARTITION BY
	*/

	-- DATABASE WF (Window Functions) --

CREATE DATABASE WF
USE WF

CREATE TABLE Store (
	StoreKey INT,
	StoreName VARCHAR(100),
	Region VARCHAR(100),
	QtySold FLOAT
)

INSERT INTO Store (StoreKey, StoreName, Region, QtySold)
VALUES
	(1, 'Botafogo Praia&Mar', 'Sudeste', 1800),
	(2, 'Lojas Vitoria', 'Sudeste', 800),
	(3, 'Emporio Mineirinho', 'Sudeste', 2300),
	(4, 'Central Paulista', 'Sudeste', 1800),
	(5, 'Rio 90 Graus', 'Sudeste', 700),
	(6, 'Casa Flor & Anapolis', 'Sul', 2100),
	(7, 'Pampas & Co', 'Sul', 990),
	(8, 'Paraná Papéis', 'Sul', 2800),
	(9, 'Amazonas Prime', 'Norte', 4200),
	(10, 'Pará Bens', 'Norte', 3200),
	(11, 'Tintas Rio Branco', 'Norte', 1500),
	(12, 'Nordestemido Hall', 'Nordeste', 1910),
	(13, 'Cachoeirinha Loft', 'Nordeste', 2380)

SELECT * FROM Store

	-- Sum of total sold --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	SUM(QtySold) OVER () AS 'Total Sold'
FROM
	Store

	-- Partition by Region --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	SUM(QtySold) OVER (PARTITION BY Region) AS 'Total Sold'
FROM
	Store
ORDER BY StoreKey

	-- COUNT Table Rows --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	COUNT(*) OVER () AS 'Store Qty'
FROM
	Store
ORDER BY StoreKey

	-- Partition By Region --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	COUNT(*) OVER (PARTITION BY Region) AS 'Store Qty'
FROM
	Store
ORDER BY StoreKey

	-- AVG Solded --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	ROUND(AVG(QtySold) OVER (), 2) AS 'Avarege Qty Sold'
FROM
	Store
ORDER BY StoreKey

	-- Partition By Region --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	ROUND(AVG(QtySold) OVER (PARTITION BY Region), 2) AS 'Avarege Qty Sold by Region'
FROM
	Store
ORDER BY StoreKey

	-- Total MIN Solded per Stores --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	MIN(QtySold) OVER () AS 'MIN Sold'
FROM
	Store
ORDER BY StoreKey

	-- MIN Solded per Region --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	MIN(QtySold) OVER (PARTITION BY Region) AS 'MIN Sold by Region'
FROM
	Store
ORDER BY StoreKey

	-- Total Percent per Store --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	SUM(QtySold) OVER () AS 'Total Sold',
	FORMAT(QtySold/SUM(QtySold) OVER (), '0.00%') AS '% Total'
FROM
	Store

	-- Total Percent of each Store per Region --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	SUM(QtySold) OVER (PARTITION BY Region) AS 'Total Sold by Region',
	FORMAT(QtySold/SUM(QtySold) OVER (PARTITION BY Region), '0.00%') AS 'Total % by Region'
FROM
	Store
ORDER BY StoreKey

	-- ROW NUMBER --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	ROW_NUMBER() OVER(ORDER BY QtySold DESC) AS 'Row Number'
FROM
	Store

	-- RANK --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	ROW_NUMBER() OVER(ORDER BY QtySold DESC) AS 'Row Number',
	RANK() OVER(ORDER BY QtySold DESC) AS 'Rank'
FROM
	Store

	-- DENSE --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	ROW_NUMBER() OVER(ORDER BY QtySold DESC) AS 'Row Number',
	RANK() OVER(ORDER BY QtySold DESC) AS 'Rank',
	DENSE_RANK() OVER (ORDER BY QtySold DESC) AS 'Dense'
FROM
	Store

	-- NTILE --
SELECT
	StoreKey,
	StoreName,
	Region,
	QtySold,
	ROW_NUMBER() OVER(PARTITION BY Region ORDER BY QtySold DESC) AS 'Row Number',
	RANK() OVER(PARTITION BY Region ORDER BY QtySold DESC) AS 'Rank',
	DENSE_RANK() OVER (PARTITION BY Region ORDER BY QtySold DESC) AS 'Dense',
	NTILE(3) OVER (PARTITION BY Region ORDER BY QtySold DESC) AS 'Ntile'
FROM
	Store
ORDER BY StoreKey

	-- RANK + GROUP BY --
SELECT
	Region,
	SUM(QtySold) AS 'Total Sold',
	RANK() OVER(ORDER BY SUM(QtySold) DESC) AS 'Ranking'
FROM
	Store
GROUP BY Region
ORDER BY [Total Sold] DESC

DROP DATABASE WF