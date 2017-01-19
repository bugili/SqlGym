USE Demo
GO

--Drop Foreign Key Constraints
ALTER TABLE Sales
	DROP CONSTRAINT FK_EmployeeSales, FK_ProductSales
GO

--Disable Triggers
EXEC sp_MSforeachtable  'ALTER TABLE ? DISABLE TRIGGER ALL'

---Empty tables / Re-ssed auto-numbers
TRUNCATE TABLE Employees
TRUNCATE TABLE Products
TRUNCATE TABLE Sales

--ADD Foreign Key Constraints
ALTER TABLE Sales
	ADD CONSTRAINT FK_ProductSales FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
		,CONSTRAINT FK_EmployeeSales FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)

--Re-enable Triggers
EXEC sp_MSforeachtable 'ALTER TABLE ? ENABLE TRIGGER ALL'

ALTER TABLE Employees
	ALTER COLUMN LastName nvarchar(50) NULL

INSERT Employees SELECT 'Luke',NULL,'Skywalker','Sales Person','10/1/2017',0,500.00
INSERT Employees SELECT 'Darth',NULL, 'Maul', 'Sales Person', '4/27/2005',0,10000.00
INSERT Employees SELECT 'Han', NULL, 'Solo', 'Sales Person', '6/19/2003','20',5000.00
INSERT Employees SELECT 'Emperor', NULL, 'Palpatine', 'Human Reosurces', '7/22/2013',0,50000.00
INSERT Employees SELECT 'Count', NULL, 'Dooku', 'CFO', '12/12/2007',0, 25000.00
INSERT Employees SELECT 'Obi-Wan', NULL, 'Kenobi', 'CEO', '2/14/2005',0, 10000.00
INSERT Employees SELECT 'Yoda', NULL, NULL, 'Sales Manager', '1/14/1900',0,1000000000.00


INSERT Products SELECT 'Lightsaber', 49.99, 0
INSERT Products SELECT 'Blaster', 79.99, 0 
INSERT Products SELECT 'Droid', 99.99, 0
INSERT Products SELECT 'Speeder', 250.00, 0 
INSERT Products SELECT 'Spaceship', 300.00, 0 

--Create 50,000 random sale records!
DECLARE @counter int
SET @counter = 1

WHILE @counter <= 1000
	BEGIN
		INSERT Sales
			SELECT
				NEWID()
				,(ABS(CHECKSUM(NEWID())) % 5) + 1
				,(ABS(CHECKSUM(NEWID())) % 3) + 1
				,(ABS(CHECKSUM(NEWID())) % 10) + 1
				,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 3650), '2007-04-01')
		SET @counter += 1
	END
