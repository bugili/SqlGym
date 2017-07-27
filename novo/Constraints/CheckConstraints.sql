use SqlGym
go

USE [SqlGym]
GO

/****** Object:  Table [dbo].[Employees]    Script Date: 7/26/2017 7:35:16 PM ******/
if exists ( select * from dbo.sysobjects where id = OBJECT_ID(N'[dbo].[Employees]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[Employees]
GO

/****** Object:  Table [dbo].[Employees]    Script Date: 7/26/2017 7:35:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] NOT NULL IDENTITY(1,1),  --- auto-incremented from 1 by 1
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](75) NOT NULL,
	[Title] [nvarchar](100) NULL DEFAULT ('New Hire'),
	[HireDate] [datetime] NOT NULL CONSTRAINT DF_HireDate DEFAULT (GETDATE()) CHECK (DATEDIFF(d, getdate(), HireDate) <=0), --- constraint [ime] default [vrednost] ; check --- da datum nije u buducnosti 
	[VacationHours] [smallint] NULL DEFAULT (0), --- sql server sam da ime
	[Salary] [decimal](19, 4) NOT NULL
) ON [PRIMARY]
GO



USE [SqlGym]
GO

/****** Object:  Table [dbo].[Products]    Script Date: 7/26/2017 7:40:25 PM ******/
if exists (select * from dbo.sysobjects where id = OBJECT_ID(N'[dbo].[Products]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[Products]
GO

/****** Object:  Table [dbo].[Products]    Script Date: 7/26/2017 7:40:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Products](
	[ProductID] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Price] [decimal](19, 4) NOT NULL CONSTRAINT CH_Price CHECK (Price > 0),
	[DiscontinuedFlag] bit NOT NULL CONSTRAINT DF_DiscontinuedFlag DEFAULT (0)
) ON [PRIMARY]
GO


USE [SqlGym]
GO

/****** Object:  Table [dbo].[Sales]    Script Date: 7/26/2017 7:42:04 PM ******/
if exists (select * from dbo.sysobjects where id = OBJECT_ID(N'[dbo].[Sales]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[Sales]
GO

/****** Object:  Table [dbo].[Sales]    Script Date: 7/26/2017 7:42:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Sales](
	[Sales] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[ProductID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[SaleDate] [datetime] NOT NULL CONSTRAINT DF_SaleDate DEFAULT (GETDATE()),
	CONSTRAINT CHK_QuantitySaleDate CHECK (Quantity >0 and DATEDIFF(d, getdate(), SaleDate) >= 0) --- Table Level Constraint
) ON [PRIMARY]
GO


--select 
--	*
--	--,OBJECTPROPERTY(id, 'IsUserTable') as IsUserTable 
--from 
--	dbo.sysobjects
--where OBJECTPROPERTY(id, 'IsUserTable')  = 1


--print object_id('dbo.sales') 
