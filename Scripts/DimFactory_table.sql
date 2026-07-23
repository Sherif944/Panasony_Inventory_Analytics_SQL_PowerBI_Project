### 🏭 Geospatial & Plant Segmentation Modeling (DimFactory Dimension)

To facilitate granular spatial analysis and cross-regional comparisons, a dedicated Factory Dimension table (`dbo.DimFactory`) was designed. This dimension isolates key plant characteristics—such as location hierarchies (City, Country, Region) and operational categories (`PlantType` like Assembly or Cell Manufacturing)—enabling dynamic slice-and-dice operations within the reporting layer.

#### T-SQL Factory Dimension DDL & Seed Script:

CREATE TABLE dbo.DimFactory
(
    FactoryKey INT IDENTITY(1,1) PRIMARY KEY,
    FactoryCode NVARCHAR(20) NOT NULL,
    FactoryName NVARCHAR(150) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    Country NVARCHAR(100) NOT NULL,
    Region NVARCHAR(100) NOT NULL,
    PlantType NVARCHAR(100) NOT NULL
);
GO


INSERT INTO dbo.DimFactory (FactoryCode, FactoryName, City, Country, Region, PlantType)
VALUES
(N'PLT-OSK-01',N'Osaka Assembly Plant',N'Osaka',N'Japan',N'APAC',N'Assembly'),
(N'PLT-PUN-01',N'Pune Appliances Plant',N'Pune',N'India',N'APAC',N'Assembly'),
(N'PLT-BLR-01',N'Bengaluru Electronics Plant',N'Bengaluru',N'India',N'APAC',N'Assembly'),
(N'PLT-NV-01',N'Nevada Battery Plant',N'Reno',N'USA',N'North America',N'Cell Manufacturing'),
(N'PLT-DE-01',N'Munich Industrial Devices Plant',N'Munich',N'Germany',N'Europe',N'Components'),
(N'PLT-TKY-01',N'Tokyo ProAV Plant',N'Tokyo',N'Japan',N'APAC',N'Assembly');


select * from dbo.DimFactory
