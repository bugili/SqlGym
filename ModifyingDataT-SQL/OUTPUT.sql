USE Demo
GO

--OUTPUT statement to view affected rows (INSERTED)
DECLARE @InsertedProducts table(ProductID int, Name nvarchar(255), Price decimal(19,4))

INSERT INTO 
	Products (Name,Price)
OUTPUT
	inserted.ProductID
	,inserted.Name
	,inserted.Price
INTO 
	@InsertedProducts
VALUES ('PowerBelt', '59.99')

SELECT * FROM @InsertedProducts
SELECT * FROM Products


--OUTPUT statement to view affected rows (DELETED)
DECLARE @DeletedProducts table(EmployeeID int, FirstName nvarchar(255), LastName nvarchar(255))

DELETE FROM
	SalesEmployees
OUTPUT
	deleted.EmployeeID
	,deleted.FirstName
	,deleted.LastName
INTO 
	@DeletedProducts
WHERE
	Title = 'Sales Person'

SELECT * FROM @DeletedProducts
SELECT * FROM SalesEmployees


--OUTPUT statement to view affected rows (INSERTED/DELETED)
DECLARE @DiscountProducts table(ProductID int, OldPrice decimal(19,4), NewPrice decimal(19,4))

UPDATE
	Products
SET
	Price *= .5
	,Name += '*'
OUTPUT
	inserted.ProductID
	,deleted.Price
	,inserted.Price
INTO 
	@DiscountProducts
WHERE 
	DiscontinuedFlag = 1

SELECT * FROM @DiscountProducts
SELECT * FROM Products
