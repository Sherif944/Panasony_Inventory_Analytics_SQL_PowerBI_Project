### 🗜️ Consolidated Analytical Layer (vw_POWERBI_FactInventorySummary View)

To optimize report rendering and simplify data ingestion within Power BI, a unified database view (`dbo.vw_POWERBI_FactInventorySummary`) was engineered. This relational consumption layer executes the necessary SQL `JOIN` logical links across the centralized `FactInventory` ledger and the surrounding dimension tables (`DimDate`, `DimFactory`, and `DimProduct`). By flattening the core relational Star Schema at the database level, it establishes an optimized semantic interface that eliminates redundant client-side relationship overhead, ensures high query folding efficiency, and provides clean consolidated attributes directly to the visualization canvas.

#### T-SQL Unified Reporting View Implementation Script:

DROP VIEW IF EXISTS [dbo].[vw_POWERBI_FactInventorySummary]
GO
CREATE VIEW [dbo].[vw_POWERBI_FactInventorySummary] AS
SELECT
	d.YearNumber,
	d.QuarterNumber,
	d.MonthNumber,
	d.MonthName,
	CAST(CONCAT(d.YEARNUMBER, '0' +CAST(d.MONTHNUMBER AS VARCHAR(2))) AS INT) YearMonthKey,
	f.[FactoryCode],
    f.[FactoryName],
    f.[City],
    f.[Country],
    f.[Region],
    f.[PlantType],
    p.[SKU],
    p.[ProductName],
    p.[ModelNumber],
    p.[UOM],
    p.[BusinessUnitCode],
    p.[BusinessUnitName],
    p.[SegmentCode],
    p.[SegmentName],
    p.[SubsegmentCode],
    p.[SubsegmentName],
    p.[ProductCategoryCode],
    p.[ProductCategoryName],
	SUM(fi.[OnHandQty]) AS [OnHandQty],
    SUM(fi.[AvailableQty]) AS [AvailableQty],
    SUM(fi.[ReservedQty]) AS [ReservedQty],
    SUM(fi.[InTransitQty]) AS [InTransitQty],
    SUM(fi.[InventoryValue]) AS [InventoryValue]
FROM [FactInventory] fi
LEFT JOIN dimdate d -- Here we joined the dimension date table with the fact inventory table
ON fi.DateKey = d.DateKey
LEFT JOIN DimFactory f
ON fi.FactoryKey = f.FactoryKey -- Here we joined the dimension factory table with the fact inventory table
LEFT JOIN DimProduct p
ON fi.ProductKey = p.ProductKey -- Here we joined the dimension product table with the fact inventory table
GROUP BY 
    d.YearNumber,
	d.QuarterNumber,
	d.MonthNumber,
	d.MonthName,
	CAST(CONCAT(d.YEARNUMBER, '0' +CAST(d.MONTHNUMBER AS VARCHAR(2))) AS INT),
	f.[FactoryCode],
    f.[FactoryName],
    f.[City],
    f.[Country],
    f.[Region],
    f.[PlantType],
    p.[SKU],
    p.[ProductName],
    p.[ModelNumber],
    p.[UOM],
    p.[BusinessUnitCode],
    p.[BusinessUnitName],
    p.[SegmentCode],
    p.[SegmentName],
    p.[SubsegmentCode],
    p.[SubsegmentName],
    p.[ProductCategoryCode],
    p.[ProductCategoryName]
    
GO


