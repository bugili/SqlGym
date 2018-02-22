declare @MyOrderTotalsByYear TABLE
(
    orderyear int not NULL
    ,qty int not NULL
);

insert into @MyOrderTotalsByYear
    select
        year(o.orderdate) as orderyear
        ,sum(od.qty) as qty  
    from sales.Orders as o 
        join sales.OrderDetails as od 
            on o.orderid = od.orderid 
    group by year(orderdate)

SELECT 
    orderyear
    ,qty as curyearqty
    ,lag(qty) over(order by orderyear) as prvyearqty
from @MyOrderTotalsByYear