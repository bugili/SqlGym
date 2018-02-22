use TSQL2012
go

begin TRAN;

    --declare a variable
    DECLARE @neworderid as INT;

    -- insert a new order into the Sales.Orders table
    INSERT into sales.Orders
        (custid, empid, orderdate, requireddate, shippeddate
        ,shipperid, freight, shipname, shipaddress, shipcity
        ,shippostalcode, shipcountry)
        VALUES
        (
            85, 5, '20090212','20090301','20090216'
            ,3, 32.38, N'Ship to 85-B', N'6789 rue de l''Abbaye', N'Reims'
            ,N'10345', N'France'
        );

    -- save the new ID in a variable
    SET @neworderid = SCOPE_IDENTITY();

    -- return the new order ID
    select @neworderid as neworderid

    -- insert order lines for the new order into sales.orderDetails
    INSERT into sales.OrderDetails
            (orderid, productid, unitprice, qty, discount)
        VALUES
            (@neworderid, 11, 14.00, 12, 0.000)
            ,(@neworderid, 42, 9.80, 10, 0.000)
            ,(@neworderid, 72, 34.80, 5, 0.000);
    
    -- commit the transaction
    COMMIT TRAN;


begin TRAN;

    UPDATe production.products 
        set unitprice += 1.00
    where productid = 2;

commit