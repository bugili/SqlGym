if OBJECT_ID('dbo.customers','u') is not NULL
    drop TABLE dbo.customers;

CREATE TABLE dbo.Customers
(
custid INT NOT NULL,
companyname NVARCHAR(40) NOT NULL,
contactname NVARCHAR(30) NOT NULL,
contacttitle NVARCHAR(30) NOT NULL,
address NVARCHAR(60) NOT NULL,
city NVARCHAR(15) NOT NULL,
region NVARCHAR(15) NULL,
postalcode NVARCHAR(10) NULL,
country NVARCHAR(15) NOT NULL,
phone NVARCHAR(24) NOT NULL,
fax NVARCHAR(24) NULL,
CONSTRAINT PK_Customers PRIMARY KEY(custid)
);

if OBJECT_ID('dbo.orders','u') is not NULL
    drop TABLE dbo.orders;
CREATE TABLE dbo.Orders
(
orderid INT NOT NULL,
custid INT NULL,
empid INT NOT NULL,
orderdate DATETIME NOT NULL,
requireddate DATETIME NOT NULL,
shippeddate DATETIME NULL,
shipperid INT NOT NULL,
freight MONEY NOT NULL
CONSTRAINT DFT_Orders_freight DEFAULT(0),
shipname NVARCHAR(40) NOT NULL,
shipaddress NVARCHAR(60) NOT NULL,
shipcity NVARCHAR(15) NOT NULL,
shipregion NVARCHAR(15) NULL,
shippostalcode NVARCHAR(10) NULL,
shipcountry NVARCHAR(15) NOT NULL,
CONSTRAINT PK_Orders PRIMARY KEY(orderid),
CONSTRAINT FK_Orders_Customers FOREIGN KEY(custid)
REFERENCES dbo.Customers(custid)
);
GO
INSERT INTO dbo.Customers SELECT * FROM Sales.Customers;
INSERT INTO dbo.Orders SELECT * FROM Sales.Orders;

DELETE from dbo.Orders
where orderdate < '20070101';

TRUNCATE TABLE dbo.t1;

-- BEGIN TRANSACTION
-- TRUNCATE table dbo.orders
-- ROLLBACK

SELECT top(5) * from dbo.Orders

delete from o 
from dbo.Orders as o 
    join dbo.Customers as c
        on o.custid = c.custid
WHERE c.country = N'USA';

SELECT TOP 20
    qs.sql_handle,
    qs.execution_count,
    qs.total_worker_time AS Total_CPU,
    total_CPU_inSeconds = --Converted from microseconds
        qs.total_worker_time/1000000,
    average_CPU_inSeconds = --Converted from microseconds
        (qs.total_worker_time/1000000) / qs.execution_count,
    qs.total_elapsed_time,
    total_elapsed_time_inSeconds = --Converted from microseconds
        qs.total_elapsed_time/1000000,
    st.text,
    qp.query_plan
FROM
    sys.dm_exec_query_stats AS qs
CROSS APPLY 
    sys.dm_exec_sql_text(qs.sql_handle) AS st
CROSS APPLY
    sys.dm_exec_query_plan (qs.plan_handle) AS qp
ORDER BY 
    qs.total_worker_time DESC

select *
from master.sys.sysprocesses
order by cpu desc

select * 
from sys.dm_exec_connections

select *
from dbo.Orders
    cross APPLY dbo.Customers