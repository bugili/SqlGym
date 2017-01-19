USE Demo

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE Id = OBJECT_ID(N'[dbo].[Products]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].Employees
GO

CREATE TABLE Employees
(
	EmployeeID int NOT NULL IDENTITY (1,1) PRIMARY KEY
	,FirstName nvarchar(50) NOT NULL
	,MiddleName nvarchar(50) NULL
	,LastName nvarchar(50) NOT NULL
	,Title nvarchar(100) NULL DEFAULT ('New Hire')
	,HireDate datetime NOT NULL CONSTRAINT DF_HireDate DEFAULT (GETDATE())
	,VacationHours int NOT NULL DEFAULT (0)
	,Salary decimal(19,4) NOT NULL
	,CONSTRAINT U_Employee UNIQUE NONCLUSTERED (FirstName, LastName, HireDate)
	
)
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE Id = OBJECT_ID(N'[dbo].[Sales]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[Products]
GO

CREATE TABLE Products
(
	ProductID int NOT NULL IDENTITY(1,1)
	,Name nvarchar(255) NOT NULL UNIQUE NONCLUSTERED
	,Price decimal(19,4) NOT NULL
	,DiscontinuedFlag bit NOT NULL CONSTRAINT DF_DiscontinuedFlag DEFAULT (0)
	,CONSTRAINT PK_ProductID PRIMARY KEY CLUSTERED (ProductID ASC)
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
	,CONSTRAINT PK_SaleID PRIMARY KEY CLUSTERED (ProductID ASC)
		WITH (IGNORE_DUP_KEY = OFF)
)
GO

