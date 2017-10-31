use SqlGym

create table Employees 
(
	EmployeeID int not null IDENTITY(1,1) 
	,FirstName nvarchar(20) not null
	,MiddleName nvarchar(20) null
	,LastName nvarchar(30) not null
	,Title nvarchar(50) null DEFAULT ('New Hire')
	,HireDate datetime not null CONSTRAINT DF_HireDate DEFAULT (getdate()) CHECK (datediff(d, getdate(), HireDate) <= 0)
	,VacationHours smallint null Default (0)
	,Salary decimal(19,4) not null 
)

go

create table Products
(
	ProductID int not null identity(1,1)
	,Name nvarchar(30) not null
	,Price decimal(19,4) not null CONSTRAINT CH_Price check (Price > 0)
	,DiscontinuedFlag bit not null DEFAULT (0)
)
go

create table Sales
(
	Sales uniqueidentifier not null DEFAULT newid()
	,ProductID int not null
	,EmployeeID int not null
	,SaleDate datetime not NULL CONSTRAINT DF_SaleDate DEFAULT (getdate()) check (datediff(d, getdate(), SaleDate) >= 0) 
	,Quantity smallint not null constraint CH_Quantity check (Quantity > 0)
)