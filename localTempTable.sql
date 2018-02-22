select *
into c#
from 
    (
        values
    
        (CAST('20171211'as [datetime]),12,1)
        ,(CAST('20171211' as datetime),15,1)
        ,(CAST('20171211' as datetime),122,1)
        ,(CAST('20171111' as datetime),9,1)
        ,(CAST('20171111' as datetime),112,1)
    ) as o(datum, kolicina, custid)


select 
    custid
    ,sum(kolicina) over(partition by custid, month(datum)) as mesecno
    ,month(datum) as mesec
from c#

select 
    custid
    ,month(datum) as mesec
    ,sum(kolicina)
from c#
group by custid, month(datum)

use tsql2012; 
select 
    custid 
    ,ordermonth
    ,sum(qty) 
from sales.CustOrders
group by custid, ordermonth
order by custid;


create TABLE #MyOrderTotalByYear
(
    orderyear int not NULL
    ,qty int not null 
);

insert into #MyOrderTotalByYear
    select 
        YEAR(o.orderdate) as orderyear
        ,sum(od.qty) as qty 
    from sales.orders as o
        join sales.OrderDetails as od 
            on o.orderid = od.orderid
    group by year(orderdate);

select 
    cur.orderyear, 
    cur.qty, 
    last.qty as prevQty
    ,iif(cur.qty > last.qty, 'Raste','Pada') as Trend
from #MyOrderTotalByYear as cur
    left OUTER join #MyOrderTotalByYear as last 
        on cur.orderyear = last.orderyear + 1 
order by orderyear