use SqlGym
go

alter table Employees
	add
		ActiveFlag bit NOT NULL
		,ModifiedDate datetime not null

alter table Products 
	alter column Price money --- ako nema 'not null' onda je 'null'

exec sp_rename 'Sales','SaleOrders' --- renaming table