USE Demo
GO

--Using EXEC
DECLARE @sql nvarchar(MAX)
		,@topCount int

SET @topCount = 5

--can't do SELECT TOP @topCOunt FROM Sales so...

SET @sql = 'SELECT TOP ' + CAST(@topCount AS nvarchar(8)) + ' * FROM Sales'

EXEC (@sql)

--Using sp_ExecuteSQL
USE master
GO
DECLARE UserDatabases CURSOR FOR
	SELECT name FROM sys.databases WHERE database_id > 4 and Name NOT LIKE 'computers'
OPEN UserDatabases

DECLARE @dbname nvarchar(128)
DECLARE @sql nvarchar(max)

FETCH NEXT FROM UserDatabases INTO @dbname
WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @sql = 'USE ' + @dbname + ';' + CHAR(13) + 'DBCC_SHRINKDATABASE (' + @dbname + ') NOTRUNCATE' 
		EXEC sp_ExecuteSQL @sql

		FETCH NEXT FROM UserDatabases INTO @dbName
	END

CLOSE UserDatabases
DEALLOCATE UserDatabases


USE AdventureWorks2012
GO

