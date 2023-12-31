/*
Run this script on SQL Server 2008 or later. There may be flaws if running on earlier versions of SQL Server.
*/
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[ufnGetAccountingStartDate] ()
RETURNS [datetime] 
AS 
BEGIN
    RETURN CONVERT(datetime, '20030701', 112);
END
GO
EXEC sp_addextendedproperty N'MS_Description', N'Scalar function used in the uSalesOrderHeader trigger to set the ending account date.', 'SCHEMA', N'dbo', 'FUNCTION', N'ufnGetAccountingStartDate'
GO
