if OBJECT_ID('dbo.customers','u') is not NULL
    drop TABLE dbo.customers;
create TABLE dbo.customers 
(
    custid int not NULL
    ,companyName VARCHAR(25) not NULL
    ,phone VARCHAR(25) not NULL
    ,address VARCHAR(25) not NULL
    ,CONSTRAINT pk_customers PRIMARY KEY(custid)
);
go

INSERT INTO dbo.Customers(custid, companyname, phone, address)
VALUES
(1, 'cust 1', '(111) 111-1111', 'address 1'),
(2, 'cust 2', '(222) 222-2222', 'address 2'),
(3, 'cust 3', '(333) 333-3333', 'address 3'),
(4, 'cust 4', '(444) 444-4444', 'address 4'),
(5, 'cust 5', '(555) 555-5555', 'address 5');
IF OBJECT_ID('dbo.CustomersStage', 'U') IS NOT NULL DROP TABLE dbo.
CustomersStage;
GO
CREATE TABLE dbo.CustomersStage
(
custid INT NOT NULL,
companyname VARCHAR(25) NOT NULL,
phone VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL,
CONSTRAINT PK_CustomersStage PRIMARY KEY(custid)
);
INSERT INTO dbo.CustomersStage(custid, companyname, phone, address)
VALUES
(2, 'AAAAA', '(222) 222-2222', 'address 2'),
(3, 'cust 3', '(333) 333-3333', 'address 3'),
(5, 'BBBBB', 'CCCCC', 'DDDDD'),
(6, 'cust 6 (new)', '(666) 666-6666', 'address 6'),
(7, 'cust 7 (new)', '(777) 777-7777', 'address 7');

SELECT * FROM dbo.customers;
select * FROM dbo.CustomersStage;



MERGE INTO dbo.customers as tgt 
USING dbo.CustomersStage as src 
    on tgt.custid = src.custid
WHEN matched then 
    update SET
        tgt.companyname = src.companyname
        ,tgt.phone = src.phone
        ,tgt.address = src.address
WHEN NOT matched then   
    INSERT (custid, companyname, phone, address) 
    VALUES (src.custid, src.companyname, src.phone, src.address);

MERGE dbo.customers as tgt 
USING dbo.CustomersStage as src 
    on tgt.custid = src.custid
WHEN matched and
    (
        tgt.companyname <> src.companyname 
            or
        tgt.phone <> src.phone
            or
        tgt.address <> src.address
    ) THEN
    update SET
        tgt.companyname = src.companyname
        ,tgt.phone = src.phone
        ,tgt.address = src.address
when not matched then 
    INSERT (custid, companyname, phone, address) 
    VALUES (src.custid, src.companyname, src.phone, src.address);

update od
    set discount += 0.05
from dbo.orderdetails as od 
    join dbo.orders as o 
        on od.orderid = o.orderid
where o.custid = 1;

with c 
AS
(
    select custid, od.orderid
        ,productid, discount, discount + 0.05 as newdiscount
    from dbo.orderdetails as od 
        join dbo.orders O
            on o.orderid = od.orderid 
    where custid = 1
)
update c
    set discount = newdiscount;


if object_id('dbo.t1','u') is not null 
    drop table dbo.t1;
create TABLE dbo.t1
(
    col1 int 
    ,col2 int 
);
INSERT into dbo.t1(col1) values(10),(20),(30);

select * from dbo.t1

select row_number() 
    over(order by col1) as RowNumber ,col1
from dbo.t1;

with C as 
(
    select col1, col2, ROW_NUMBER()
        over(order by col1) as rownum
    from dbo.t1
)
update c 
    set col2 = rownum;

select * 
from dbo.t1;


IF OBJECT_ID('dbo.OrderDetails', 'U') IS NOT NULL DROP TABLE dbo.OrderDetails;
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
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
CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);
GO

insert into dbo.orders select * from sales.orders;

delete top(50) from dbo.Orders;

update top(50) dbo.orders 
    set freight += 10.00;
    