SELECT 
    IDENT_CURRENT('dbo.t1') as [IDENT_CURRENT]
    ,@@IDENTITY as [@@IDENT_CURRENT]
    ,SCOPE_IDENTITY() as [SCOPE_IDENTITY]


CREATE SEQUENCE dbo.SeqOrderIDs as INT
    minvalue 1
    cycle;

alter SEQUENCE dbo.SeqOrderIDs
    no cycle;

SELECT next value for dbo.SeqOrderIDs

if object_id('dbo.t1','u') is not NULL
    drop TABLE dbo.t1
create TABLE dbo.t1
(
    keycol INT not NULL
        CONSTRAINT pk_t1 PRIMARY KEY
    ,datacol VARCHAR(10) not NULL
);

DECLARE @newOrderId as INT = next value for dbo.SeqOrderIDs
insert into dbo.t1(keycol,datacol) VALUES(@newOrderId,'a');

select * from dbo.t1;
go

insert into dbo.t1 
    values(next value for dbo.SeqOrderIDs, 'b');

update dbo.t1
    set keycol = next value for dbo.SeqOrderIDs;

declare @first as sql_variant

exec sys.sp_sequence_get_range
    @sequence_name = N'dbo.SeqOrderIDs'
    ,@range_size = 1000
    ,@range_first_value = @first OUTPUT; 

SELECT @first;
