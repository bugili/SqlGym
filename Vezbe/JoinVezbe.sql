-- 1-1 - cross join
select e.empid,e.lastname,e.firstname,n.n
from hr.Employees e
	cross join
		dbo.Nums n
where n.n <= 5
order by e.empid

-- 1-2
select e.empid,dateadd(day, n.n-1, '20090612') as dt
from nums as n
	cross join 
		hr.Employees as e
where n <= DATEDIFF(day, '20090612','20090616') + 1
order by e.empid

-- 2

select c.custid, count(distinct(o.orderid)) as numorders, sum(od.qty) as totalqty
from sales.Customers as c
	join sales.Orders as o 
		on c.custid = o.custid
	join sales.OrderDetails as od 
		on o.orderid = od.orderid
where c.country like 'usa'
group by c.custid
order by c.custid


-- 3 & 4

select c.custid, c.companyname, o.orderid, o.orderdate
from sales.Customers as c
	left join sales.Orders as o
		on c.custid = o.custid
--where o.orderid is null

-- 5 
select *
from sales.Customers as c
	join sales.orders as o
		on c.custid = o.custid
where o.orderdate = '20070212'

-- 6

select c.custid,companyname, iif(orderid is not null, 'Yes','No') as HasOrderOn20070212
from sales.Customers as c
	left join sales.orders as o
		on c.custid = o.custid and o.orderdate = '20070212'
	
