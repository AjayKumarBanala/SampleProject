/*
Run this script on SQL Server 2008 or later. There may be flaws if running on earlier versions of SQL Server.
*/
CREATE SCHEMA [Purchasing] AUTHORIZATION [dbo]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contains objects related to vendors and purchase orders.', 'SCHEMA', N'Purchasing'
GO
