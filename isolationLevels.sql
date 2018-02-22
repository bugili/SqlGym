use TSQL2012;
go

set TRANSACTION ISOLATION LEVEL serializable;
set TRANSACTION ISOLATION LEVEL read committed;

BEGIN TRAN;

    SELECT productid, unitprice
    from Production.Products
    where categoryid = 1;

COMMIT TRAN;

UPDATE Production.Products
    set unitprice = 19.00
where productid = 2;

select @@SPID

select *
from sys.dm_exec_sessions as sess
    cross APPLY 
        (
            select * 
            from sys.dm_exec_connections as conn
            where conn.session_id = sess.session_id 
        ) as sve
where sess.open_transaction_count > 0