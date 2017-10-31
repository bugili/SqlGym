if object_id('dbo.orders','u') is not null 
	drop table dbo.orders
create table dbo.orders 
(
	orderid int not null constraint pk_orders primary key
)
go

insert into dbo.orders(orderid)
	select orderid
	from sales.orders
	where orderid % 2 = 0
go

select n 
from dbo.Nums
where n between 
	(
		select min(o.orderid) 
		from dbo.orders o
	)
	and
	(
		select max(o.orderid)
		from dbo.orders o
	)
	and n not in 
	(
		select o.orderid
		from dbo.orders as o
	)
go

drop table dbo.orders