set NOCOUNT on;

declare @result TABLE
(
    custid int
    ,ordermonth DATETIME
    ,qty INT
    ,runqty INT
    ,PRIMARY key(custid, ordermonth)
)

DECLARE
    @custid as int
    ,@prvcustid as INT
    ,@ordermonth as DATETIME
    ,@qty as INT
    ,@runqty as INT;

DECLARE c CURSOR FAST_FORWARD /* read only, forward only */ FOR
    SELECT custid, ordermonth, qty
    from sales.CustOrders
    ORDER by custid, ordermonth;

OPEN c;

FETCH NEXT FROM c INTO @custid, @ordermonth, @qty;

select @prvcustid = @custid, @runqty = 0;

while @@FETCH_STATUS = 0 
BEGIN
    if @custid <> @prvcustid
        select @prvcustid = @custid, @runqty = 0;

    SET @runqty = @runqty + @qty;

    INSERT INTO @result VALUES(@custid, @ordermonth, @qty, @runqty);

    FETCH NEXT FROM c INTO @custid, @ordermonth, @qty;
END

CLOSE c;

deallocate c; 

SELECT top(5)
    custid
    ,CONVERT(varchar(7), ordermonth, 121) as ordermonth
    ,qty
    ,runqty
from @result
ORDER by custid, ordermonth;

select top(5)
    custid
    ,ordermonth
    ,qty
    ,SUM(qty) 
        OVER(partition by custid order by ordermonth rows unbounded preceding) as runqty         
from sales.CustOrders
