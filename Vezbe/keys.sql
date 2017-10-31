alter table employees
add
	constraint PK_EmployeeID primary key clustered (EmployeeID)

alter table dbo.sales
add
	constraint FK_EmployeeID foreign key (EmployeeID)
		references dbo.employees (employeeID)

alter table dbo.products
add
	constraint PK_ProductID primary key clustered (ProductID)

alter table dbo.sales
add	
	constraint FK_ProductID foreign key (ProductID)
		references dbo.products (ProductID)

select * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE