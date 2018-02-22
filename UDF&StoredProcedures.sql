declare @sql varchar(100);
set @sql = 'print ''This message was printed by a dynamic SQL batch.'';';

exec (@sql);


------------------------------------------------
---sp_executesql
------------------------------------------------

declare @sql1 as NVARCHAR(100);

set @sql1 = 
N'Select orderid, custid, empid, orderdate
from sales.orders
where orderid = @orderid;';

exec sp_executesql
    @stmt = @sql1
    ,@params = N'@orderid as int'
    ,@orderid = 10248;

----------------------------------------------  
---UTF----------------------------------------
----------------------------------------------

if OBJECT_ID('dbo.getage') is not null drop FUNCTION dbo.getage;
GO

CREATE FUNCTION dbo.GetAge
(
    @birthdate AS DATE,
    @eventdate AS DATE
)
RETURNS INT
AS
BEGIN
    RETURN
        DATEDIFF(year, @birthdate, @eventdate)
        - 
        CASE WHEN 100 * MONTH(@eventdate) + DAY(@eventdate)
                < 100 * MONTH(@birthdate) + DAY(@birthdate)
            THEN 1 ELSE 0
        END;
END;
GO

SELECT
    empid, firstname, lastname, birthdate
    ,dbo.GetAge(birthdate, SYSDATETIME()) as age 
from hr.Employees

declare @rodjendan DATETIME = '20150101' 
DECLARE @danas DATETIME = SYSDATETIME();

select 
    DATEDIFF(year, @rodjendan, @danas) - 
    case when 100 * MONTH(@danas) + DAY(@danas) < 100 * MONTH(@rodjendan) +  day(@rodjendan) 
        then 1
        else 0
    end

--------------------------------------------------------------------
---stored procedures
--------------------------------------------------------------------

if OBJECT_ID('sales.getCustomerOrders','p') is not NULL
    drop proc sales.GetCustomerOrders;
go 

create PROC sales.GetCustomerOrderss
    @custid as INT
    ,@fromdate as DATETIME = '19000101'
    ,@todate as DATETIME = '99991231'
    ,@numrows as int OUTPUT
AS
set NOCOUNT ON;

select orderid, custid, empid, orderdate
from sales.orders 
where custid = @custid
    and orderdate >= @fromdate 
    and orderdate < @todate;

set @numrows = @@ROWCOUNT;
go 

declare @rc int;

exec sales.GetCustomerOrderss
    @custid = 2
    ,@fromdate = '20070101'
    ,@todate = '20080101'
    ,@numrows = @rc output;

SELECT @rc as numrows;