/*
Run this script on SQL Server 2008 or later. There may be flaws if running on earlier versions of SQL Server.
*/
CREATE SCHEMA [Person] AUTHORIZATION [dbo]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contains objects related to names and addresses of customers, vendors, and employees', 'SCHEMA', N'Person'
GO
