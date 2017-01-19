USE DEMO
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE Id = OBJECT_ID(N'[dbo].[Employees]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[Employees]

GO

CREATE TABLE Employees
(
	EmployeeID int NOT NULL IDENTITY (1,1)
	,FirstName nvarchar(50) NOT NULL
	,MiddleName nvarchar(50) NULL
	,LastName nvarchar(50) NOT NULL
	,Title nvarchar(100) NULL DEFAULT ('New Hire')
	,HireDate datetime NOT NULL CONSTRAINT DF_HireDate DEFAULT (GETDATE()) CHECK (DATEDIFF(d, GETDATE(), HireDate) <= 0)
	,VacationHours int NOT NULL DEFAULT (0)
	,Salary decimal(19,4) NOT NULL
)
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE Id = OBJECT_ID(N'[dbo].[Products]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[Products]
GO

CREATE TABLE Products
(
	ProductID int NOT NULL IDENTITY(1,1)
	,Name nvarchar(255) NOT NULL
	,Price decimal(19,4) NOT NULL CONSTRAINT CHK_Price CHECK (Price > 0)
	,DiscontinuedFlag bit NOT NULL CONSTRAINT DF_DiscontinuedFlag DEFAULT (0)
)
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE Id = OBJECT_ID(N'[dbo].[Sales]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[Sales]
GO

CREATE TABLE Sales
(
	SaleID uniqueidentifier NOT NULL DEFAULT NEWID()
	,ProductID int NOT NULL
	,EmployeeID int NOT NULL
	,Quantity smallint NOT NULL
	,SaleDate datetime NULL CONSTRAINT DF_SaleDate DEFAULT (GETDATE())
	,CONSTRAINT CHK_QuantitySaleDate CHECK (Quantity > 0 AND DATEDIFF(d, GETDATE(), SaleDate) <= 0)
)
GO

