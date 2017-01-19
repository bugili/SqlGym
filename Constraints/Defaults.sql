USE Demo

CREATE TABLE Employees
(
	EmployeeID int NOT NULL IDENTITY (1,1)
	,FirstName nvarchar(50) NOT NULL
	,MiddleName nvarchar(50) NULL
	,LastName nvarchar(50) NOT NULL
	,Title nvarchar(100) NULL DEFAULT ('New Hire')
	,HireDate datetime NOT NULL CONSTRAINT DF_HireDate DEFAULT (GETDATE())
	,VacationHours int NOT NULL DEFAULT (0)
	,Salary decimal(19,4) NOT NULL
)
GO

CREATE TABLE Products
(
	ProductID int NOT NULL IDENTITY(1,1)
	,Name nvarchar(255) NOT NULL
	,Price decimal(19,4) NOT NULL
	,DiscontinuedFlag bit NOT NULL CONSTRAINT DF_DiscontinuedFlag DEFAULT (0)
)
GO

CREATE TABLE Sales
(
	SaleID uniqueidentifier NOT NULL DEFAULT NEWID()
	,ProductID int NOT NULL
	,EmployeeID int NOT NULL
	,Quantity smallint NOT NULL
	,SaleDate datetime NULL CONSTRAINT DF_SaleDate DEFAULT (GETDATE())
)
GO

