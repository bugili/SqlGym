USE Demo
GO

INSERT Employees
	(FirstName, MiddleName, LastName, Salary)
	VALUES('John',NULL,'Shepard','5000')


ALTER TABLE Products NOCHECK CONSTRAINT CHK_Price;
	INSERT Products SELECT 'Shirt', -1, 0
	INSERT Products SELECT 'Shorts', 14.99, 0
	INSERT Products SELECT 'Pants', -19.99, 0

ALTER TABLE Products CHECK CONSTRAINT CHK_Price;
	INSERT Products SELECT 'Hat', 9.99, 0
	

ALTER TABLE Products 
	ADD CONSTRAINT CHK_Price CHECK (Price > 0)

select * from Products