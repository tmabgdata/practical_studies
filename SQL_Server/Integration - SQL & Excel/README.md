#SQL & Excel

## Sales report for fictional company *Adventure Works*

### Basic data analysis project, integration between SQL and Excel

The indicators chosen to carry out the analysis were:

- Total sales by category
- Total collected per month
- Total Costs and Revenue by Country
- Total sales by genre

### Query performed directly by connecting to excel:

`
SELECT
	fis.SalesOrderNumber AS 'Order Number',
	fis.OrderDate AS 'Order Date',
	DATENAME(MONTH, fis.OrderDate) 'Order Month',
	dpc.EnglishProductCategoryName AS 'Product Category',
	CONCAT(dc.FirstName, ' ',  dc.LastName) AS 'Name',
	dc.Gender AS 'Gender',
	dst.SalesTerritoryCountry AS 'Country',
	fis.OrderQuantity AS 'Sold Amount',
	fis.TotalProductCost AS 'Sale Cost',
	fis.SalesAmount AS 'Sale Income'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON	dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN 	DimProductCategory dpc ON	dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
INNER JOIN DimSalesTerritory dst ON fis.SalesTerritoryKey = dst.SalesTerritoryKey
WHERE YEAR(OrderDate) = 2013
`

If you want to see the complete query, it's in the [SQL file](SQL_Server\Integration - SQL & Excel\SQL Query - Adventure Works.sql).

The Report in Excel/Google Sheets can be found [here]([https://1drv.ms/x/s!Ajfq7krIHzZQggpdl4LUcSoHQmbc?e=Cg6zeR](https://docs.google.com/spreadsheets/d/1y425_wPkWLIksE0rzt5Np8cR8AgQ3AMLsGEccrMN-ZQ/edit?usp=sharing))

The database used for analysis is available at [microsoft page](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms).

Here is the [link](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2014.bak) direct download of the sample used in the analysis and preparation of the report.

Tools used:

- SQL language with [SQL Server](https://www.microsoft.com/pt-br/sql-server/sql-server-2022)

- [Sql Server Management Studio](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16)

- [Microsoft Excel](https://www.microsoft.com/en-us/microsoft-365/excel)
