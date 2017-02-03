USE Demo
GO

--Simple INSERT statement
INSERT INTO Sales
	VALUES(NEWID(), 1, 1, 10, GETDATE())
GO

INSERT INTO Sales
	(ProductID, EmployeeID, Quantity)
	VALUES(1, 1, 10)
GO

--INSER INTO SELECT (insert from one table into another pre-existing table)
INSERT INTO Sales
	SELECT NEWID(), 2, 2, 20, GETDATE()
GO

INSERT INTO Sales (ProductID, EmployeeID, Quantity)
	SELECT 2, 2, 20
GO	

INSERT INTO Sales
	SELECT NEWID(), ProductID, EmployeeID, Quantity, SaleDate FROM Sales
	
SELECT @@ROWCOUNT
GO

--SELECT INTO (insert from table into a new table, creating the table)
SELECT
	*
INTO
	SalesEmployees
FROM
	Employees
WHERE 
	Title LIKE '%sales%'

select * from SalesEmployees