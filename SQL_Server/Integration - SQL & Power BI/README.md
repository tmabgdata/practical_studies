# SQL & Power BI

## Sales report for fictional company *Adventure Works*

### Basic data analysis project, integration between SQL and Power BI

### Indicators: 
 
#### GENERAL:

- Total Revenue
- Sold Amount
- Total Categories by Product
- Number of Clients
- Total revenue and total profit per month
- Profit margin
- Quantity Sold per Month
- Profit by Country

#### CUSTOMERS:

- Sales by Country
- Customers by Country
- Sales by Genre
- Sales by Category

### Query performed to create view:

`
SET LANGUAGE us_english
GO
CREATE OR ALTER VIEW RESULTS_ADW AS
SELECT
	fis.SalesOrderNumber AS 'Order Number',
	fis.OrderDate AS 'Order Date',
	DATENAME(MONTH, fis.OrderDate) 'Order Month',
	dpc.EnglishProductCategoryName AS 'Category Name',
	fis.CustomerKey As 'Customer ID',
	CONCAT(dc.FirstName, ' ', dc.LastName) AS 'Name',
	REPLACE(REPLACE(dc.Gender, 'M', 'Malle'), 'F', 'Femalle') AS Gender,
	dg.EnglishCountryRegionName AS 'Region',
	fis.OrderQuantity AS 'Total sold',
	fis.SalesAmount AS 'Total Revenue',
	fis.TotalProductCost AS 'Total Product Price',
	(fis.SalesAmount - fis.TotalProductCost) AS 'Profit'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON	dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN 	DimProductCategory dpc ON	dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
INNER JOIN DimGeography dg ON dc.GeographyKey = dg.GeographyKey
GO
`

If you want to see the complete query, it's in the [SQL file](SQL_Server\Integration - SQL & Power BI\SQL Query - Adventure Works.sql).

The Dashboard can be found [here](https://app.powerbi.com/view?r=eyJrIjoiYjczZDRjYTMtODRlMy00MmNjLTgzYjItNTlkMWJkOGQ2NTEyIiwidCI6IjQ3ZjY2MGU3LTM3OGEtNDhlMy1iOTg3LTEyMDRhOGM2NzRkYiJ9)

The database used for analysis is available at [microsoft page](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms).

Here is the [link](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2014.bak) direct download of the sample used in the analysis and preparation of the report.

Tools used:

- SQL language with [SQL Server](https://www.microsoft.com/pt-br/sql-server/sql-server-2022)

- [Sql Server Management Studio](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16)

- [Microsoft Power BI](https://powerbi.microsoft.com/)
