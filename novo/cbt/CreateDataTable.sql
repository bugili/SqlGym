use SqlGym
go

create table Employees
(
	EmployeeID int NOT NULL
	,FirstName nvarchar(50) NOT NULL -- nvarchar UNICODE ; varchar NONUNICODE
	,MiddleName nvarchar(50) NULL
	,LastName nvarchar(75) NOT NULL
	,Title nvarchar(100) NULL
	,HireDate datetime NOT NULL
	,VacationHours smallint NULL
	,Salary decimal(19,4) NOT NULL
)

go

create table Products
(
	ProductID int not null
	,Name nvarchar(255) not null
	,Price decimal(19,4) not null
)
go

create table Sales
(
	Sales uniqueidentifier NOT NULL --- uniqueIdentifier --- guid
	,ProductID int not null
	,EmployeeID int not null
	,Quantity smallint NOT NULL
)

go