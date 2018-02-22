create TABLE dbo.orders
(
    orderid int not NULL
        CONSTRAINT pk_orders PRIMARY KEY
    ,orderdate DATE not NULL
        CONSTRAINT dft_orders_orderdate DEFAULT(sysdatetime())
    ,empid  int not NULL

    ,cutsid VARCHAR(10) not NULL
);

--exec sp_rename 'dbo.orders.cutsid','custid'

INSERT into dbo.orders(orderid, orderdate, empid, custid )
VALUES(10002, '20090212', 4, 'A');

SELECT *
FROM
    (
        values
            (10003, '20090213', 4, 'B')
            ,(10004, '20090213', 4, 'B')
            ,(10005, '20090213', 4, 'B')
    ) as o(orderid, orderdate, empid, custid);

    CREATE PROC sales.usp_getorders
        @country as NVARCHAR(40)
    AS

    SELECT orderid, orderdate, empid, custid
    from sales.Orders
    where shipcountry = @country;
    go

EXEC sales.usp_getorders 'France';

INSERT into dbo.orders(orderid, orderdate, empid, custid)
    EXEC sales.usp_getorders @country = 'France';

if (OBJECT_ID('dbo.orders2','u') is not NULL)
    DROP TABLE dbo.orders2;

SELECT orderid, orderdate, empid, custid
into dbo.Orders2
from sales.Orders;
GO


select *
from dbo.orders
WHERE orders.orderdate >= '20070101' and orderdate < '20071212';

BULK INSERT dbo.orders
from 'c:\temp\orders.txt'
    WITH
        (
            datafiletype = 'char'
            ,fieldterminator = ','
            ,rowterminator = '\n'
        );

        if OBJECT_ID('dbo.T1','u') is not NULL
            DROP TABLE dbo.T1;
        CREATE TABLE dbo.T1
        (
            keycol      INT         not NULL    IDENTITY(1,1)
                CONSTRAINT pk_t1 PRIMARY KEY
            ,datacol    VARCHAR(10) not NULL
                CONSTRAINT chk_t1_datacol CHECK(datacol like '[A-Zaa-z]%')
        );
        GO

INSERT into dbo.t1(datacol)
    VALUES
    ('aaaaa')
    ,('bbbbb')
    ,('ccccc');

select $identity
from dbo.T1

DECLARE @new_key as INT;
INSERT into dbo.t1(datacol)
VALUES ('aaaaa')
SET @new_key = SCOPE_IDENTITY()
SELECT @new_key as newKey;
GO

select
    SCOPE_IDENTITY() as [SCOPE_IDENTITY]
    ,@@identity as [@@identity]
    ,IDENT_CURRENT('dbo.T1') as [IDENT_CURRENT]

INSERT into dbo.T1(datacol)
    VALUES('12345');

INSERT into dbo.t1(datacol) VALUES('EEEEE')

SELECT *
from dbo.T1;

set identity_insert dbo.t1 on;
insert into dbo.t1(keycol,datacol) VALUES(5,'fffff');
set identity_insert dbo.t1 OFF;

-- update dbo.T1
-- set datacol = 'dddd'
-- where keycol = 4;

insert into dbo.t1(datacol) VALUES('ggggg')