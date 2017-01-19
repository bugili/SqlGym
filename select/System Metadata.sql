USE Demo
GO

--using OBJECT_ID metadata function
IF OBJECT_ID('iProductNotification', 'TR')  IS NOT NULL 
	DROP TRIGGER iProductNotification
GO

--using OBJECTPROPERTY with OBJECT_ID metadata function
IF OBJECTPROPERTY(OBJECT_ID('Employees'),'IsTable') = 1
	PRINT 'Yes, it''s a Table'
ELSE
	PRINT 'No, it''s not a Table'

--system objects on database
select * from sys.objects

select 
	*
from 
	sys.objects
where
	OBJECTPROPERTY(OBJECT_ID, 'SchemaID') = SCHEMA_ID('dbo')

--more system metadata views
select * from INFORMATION_SCHEMA.TABLES
select * from INFORMATION_SCHEMA.COLUMNS

--system stored procedures
exec sp_help 'Employees'

--Undocumented stored procedures
EXEC sp_MSforeachtable 'DBCC CHECKTABLE ([?])'
EXEC sp_MSforeachtable 'EXECUTE sp_spaceused [?]';



