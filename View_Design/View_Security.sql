USE master
GO

CREATE LOGIN TestUser WITH PASSWORD='', DEFAULT_DATABASE=[AdventureWorks2012],
	CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;

USE AdventureWorks2012
GO

CREATE USER TestUser FOR LOGIN TestUser WITH DEFAULT_SCHEMA=[dbo]


USE [AdventureWorks2012]
GO



CREATE VIEW [dbo].[vProductAndDescription] 
 AS 

	SELECT 
	    p.[ProductID] 
	    ,p.[Name] 
	    ,pm.[Name] AS [ProductModel] 
	    ,pmx.[CultureID] 
	    ,pd.[Description]
		,p.StandardCost
		,p.ListPrice
		,p.Class
		,p.ReorderPoint
	FROM 
		[Production].[Product] p 
			INNER JOIN [Production].[ProductModel] pm 
	    ON p.[ProductModelID] = pm.[ProductModelID] 
			INNER JOIN [Production].[ProductModelProductDescriptionCulture] pmx 
	    ON pm.[ProductModelID] = pmx.[ProductModelID] 
			INNER JOIN [Production].[ProductDescription] pd 
	    ON pmx.[ProductDescriptionID] = pd.[ProductDescriptionID]
			INNER JOIN Production.ProductInventory pi 
		ON p.ProductID = pi.ProductID;

GO

GRANT SELECT ON dbo.vProductAndDescription TO TestUser
REVOKE SELECT ON dbo.vProductAndDescription TO TestUser


CREATE SCHEMA Computers AUTHORIZATION dbo
GO

CREATE VIEW Computers.vEmployee
AS
	SELECT * FROM HumanResources.Employee
GO

CREATE VIEW Computers.vProducts
AS
	SELECT * FROM Production.Product
GO

ALTER USER TestUser WITH DeFAULT_SCHEMA=[Computers]

GRANT SELECT ON SCHEMA::Computers TO TestUser;