select name,SCHEMA_NAME(schema_id) as [SCHEMA]
from sys.tables;

DECLARE @json as NVARCHAR(max), @name as VARCHAR(20);

select 
    @json = JSON
    ,@name = username 
from dbo.[User]; 

select @json as json, @name as name;
go

