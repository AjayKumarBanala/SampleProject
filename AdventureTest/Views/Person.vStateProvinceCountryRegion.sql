/*
Run this script on SQL Server 2008 or later. There may be flaws if running on earlier versions of SQL Server.
*/
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [Person].[vStateProvinceCountryRegion] 
WITH SCHEMABINDING 
AS 
SELECT 
    sp.[StateProvinceID] 
    ,sp.[StateProvinceCode] 
    ,sp.[IsOnlyStateProvinceFlag] 
    ,sp.[Name] AS [StateProvinceName] 
    ,sp.[TerritoryID] 
    ,cr.[CountryRegionCode] 
    ,cr.[Name] AS [CountryRegionName]
FROM [Person].[StateProvince] sp 
    INNER JOIN [Person].[CountryRegion] cr 
    ON sp.[CountryRegionCode] = cr.[CountryRegionCode];
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET ANSI_WARNINGS ON
GO
SET ANSI_PADDING ON
GO
SET NUMERIC_ROUNDABORT OFF
GO
CREATE UNIQUE CLUSTERED INDEX [IX_vStateProvinceCountryRegion] ON [Person].[vStateProvinceCountryRegion]([StateProvinceID], [CountryRegionCode]) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Joins StateProvince table with CountryRegion table.', 'SCHEMA', N'Person', 'VIEW', N'vStateProvinceCountryRegion'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index on the view vStateProvinceCountryRegion.', 'SCHEMA', N'Person', 'VIEW', N'vStateProvinceCountryRegion', 'INDEX', N'IX_vStateProvinceCountryRegion'
GO
