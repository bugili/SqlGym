begin TRY
    print 10/0;
    print 'No error';
end TRY
begin CATCH
    print 'error'
end CATCH;

if object_id('dbo.employees','u') is not null drop table dbo.employees;
create TABLE dbo.employees
(
    empid           int             not NULL
    ,empname        varchar(25)     not NULL
    ,mgrid          INT             NULL
    ,CONSTRAINT pk_employees PRIMARY KEY(empid)
    ,constraint chk_employees_id check(empid > 0)
    ,CONSTRAINT fk_employees_employees FOREIGN KEY(mgrid) REFERENCES dbo.employees(empid)
);

BEGIN TRY
    insert into dbo.employees(empid, empname, mgrid)
        VALUES(1,'Emp1', null);
    -- also try with empid = 0, 'a', null
END TRY
BEGIN CATCH
    if ERROR_NUMBER() = 2627
    BEGIN
        PRINT 'Handling pk violation';
    END
    ELSE if ERROR_NUMBER() = 547
    BEGIN
        print 'Handling check/fk constraint violation';
    END
    ELSE IF ERROR_NUMBER() = 515
    BEGIN
        print 'Handling null violation'
    END
    else IF ERROR_NUMBER() = 245
    BEGIN
        print 'Handling conversion error'
    END
    ELSE
        BEGIN
            PRINT 'Re-throwing error';
            THROW; -- sql server 2012 only
        END

        PRINT ' Error Number : ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
        PRINT ' Error Message : ' + ERROR_MESSAGE();
        PRINT ' Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));
        PRINT ' Error State : ' + CAST(ERROR_STATE() AS VARCHAR(10));
        PRINT ' Error Line : ' + CAST(ERROR_LINE() AS VARCHAR(10));
        PRINT ' Error Proc : ' + COALESCE(ERROR_PROCEDURE(), 'Not within proc');
end CATCH;