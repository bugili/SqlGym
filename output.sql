
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
CREATE TABLE dbo.T1
(
keycol INT NOT NULL IDENTITY(1, 1) CONSTRAINT PK_T1 PRIMARY KEY,
datacol NVARCHAR(40) NOT NULL
);

INSERT into dbo.t1(datacol)
    OUTPUT inserted.keycol, inserted.datacol
        select lastname
        from hr.Employees
        WHERE country = N'USA';

declare @newRows TABLE(keycol int, datacol NVARCHAR(40));
INSERT into dbo.t1(datacol)
    OUTPUT inserted.keycol, inserted.datacol
    into @newRows
        select lastname
        from hr.Employees
        where country = N'UK';
select * from @newRows;


----------------------------------------------------
-- delete with output
----------------------------------------------------
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
INSERT INTO dbo.Orders SELECT * FROM Sales.Orders;

delete from dbo.orders 
    OUTPUT
        deleted.orderid
        ,deleted.orderdate
        ,deleted.empid
        ,deleted.custid
where orderdate < '20080101';

---------------------------------------------
--Update with output
---------------------------------------------
IF OBJECT_ID('dbo.OrderDetails', 'U') IS NOT NULL DROP TABLE dbo.OrderDetails;
CREATE TABLE dbo.OrderDetails
(
orderid INT NOT NULL,
productid INT NOT NULL,
unitprice MONEY NOT NULL
CONSTRAINT DFT_OrderDetails_unitprice DEFAULT(0),
qty SMALLINT NOT NULL
CONSTRAINT DFT_OrderDetails_qty DEFAULT(1),
discount NUMERIC(4, 3) NOT NULL
CONSTRAINT DFT_OrderDetails_discount DEFAULT(0),
CONSTRAINT PK_OrderDetails PRIMARY KEY(orderid, productid),
CONSTRAINT CHK_discount CHECK (discount BETWEEN 0 AND 1),
CONSTRAINT CHK_qty CHECK (qty > 0),
CONSTRAINT CHK_unitprice CHECK (unitprice >= 0)
);
GO
INSERT INTO dbo.OrderDetails SELECT * FROM Sales.OrderDetails;

update dbo.OrderDetails
    set discount += 0.05
OUTPUT
    inserted.productid
    ,deleted.discount as oldDiscount
    ,inserted.discount as newDiscount
WHERE productid = 51;        

-------------------------------------------------
--merge with OUTPUT--
-------------------------------------------------
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;
GO
CREATE TABLE dbo.Customers
(
custid INT NOT NULL,
companyname VARCHAR(25) NOT NULL,
phone VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL,
CONSTRAINT PK_Customers PRIMARY KEY(custid)
);
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

MERGE into dbo.Customers as tgt 
using dbo.CustomersStage as src 
    on tgt.custid = src.custid
WHEN matched THEN 
    update SET
        tgt.companyname = src.companyname
        ,tgt.phone = src.phone
        ,tgt.address = src.address 
when not matched then 
    insert (custid, companyname, phone, address) 
    VALUES (src.custid, src.companyname, src.phone, src.address)
OUTPUT $action as theaction, inserted.custid,
    deleted.companyname as oldcompanyname
    ,inserted.companyname as newcompanyname
    ,deleted.phone as oldphone
    ,inserted.phone as newphone
    ,deleted.address as oldaddress
    ,inserted.address as newaddress;

----------------------------------------------------
--composable dml
----------------------------------------------------
IF OBJECT_ID('dbo.ProductsAudit', 'U') IS NOT NULL DROP TABLE dbo.ProductsAudit;
IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL DROP TABLE dbo.Products;
CREATE TABLE dbo.Products
(
productid INT NOT NULL,
productname NVARCHAR(40) NOT NULL,
supplierid INT NOT NULL,
categoryid INT NOT NULL,
unitprice MONEY NOT NULL
CONSTRAINT DFT_Products_unitprice DEFAULT(0),
discontinued BIT NOT NULL
CONSTRAINT DFT_Products_discontinued DEFAULT(0),
CONSTRAINT PK_Products PRIMARY KEY(productid),
CONSTRAINT CHK_Products_unitprice CHECK(unitprice >= 0)
);
INSERT INTO dbo.Products SELECT * FROM Production.Products;
CREATE TABLE dbo.ProductsAudit
(
LSN INT NOT NULL IDENTITY PRIMARY KEY,
TS DATETIME NOT NULL DEFAULT(CURRENT_TIMESTAMP),
productid INT NOT NULL,
colname SYSNAME NOT NULL,
oldval SQL_VARIANT NOT NULL,
newval SQL_VARIANT NOT NULL
);

insert into dbo.ProductsAudit(productid, colname,oldval, newval)
    SELECT productid, N'unitprice', oldVal, newVal
    from 
    (
        update dbo.Products
            set unitprice *= 1.15
        OUTPUT
            inserted.productid
            ,deleted.unitprice as oldVal
            ,inserted.unitprice as newVal
    ) as d 
WHERE oldval < 20.0 and newval >= 20.0;

select schema_name(schema_id) as schemaName, name
from sys.tables;