/*
Run this script on SQL Server 2008 or later. There may be flaws if running on earlier versions of SQL Server.
*/
CREATE TABLE [Sales].[SalesReason] (
	[SalesReasonID]		[int]		 IDENTITY(1, 1) NOT NULL,
	[Name]				[dbo].[Name] NOT NULL,
	[ReasonType]		[dbo].[Name] NOT NULL,
	[ModifiedDate]		[datetime]	 NOT NULL CONSTRAINT [DF_SalesReason_ModifiedDate] DEFAULT (getdate()),
	CONSTRAINT [PK_SalesReason_SalesReasonID] PRIMARY KEY CLUSTERED ([SalesReasonID])
) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Lookup table of customer purchase reasons.', 'SCHEMA', N'Sales', 'TABLE', N'SalesReason'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Sales', 'TABLE', N'SalesReason', 'CONSTRAINT', N'DF_SalesReason_ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'Sales', 'TABLE', N'SalesReason', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Sales reason description.', 'SCHEMA', N'Sales', 'TABLE', N'SalesReason', 'COLUMN', N'Name'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Sales', 'TABLE', N'SalesReason', 'CONSTRAINT', N'PK_SalesReason_SalesReasonID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Sales', 'TABLE', N'SalesReason', 'INDEX', N'PK_SalesReason_SalesReasonID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Category the sales reason belongs to.', 'SCHEMA', N'Sales', 'TABLE', N'SalesReason', 'COLUMN', N'ReasonType'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key for SalesReason records.', 'SCHEMA', N'Sales', 'TABLE', N'SalesReason', 'COLUMN', N'SalesReasonID'
GO
