USE Demo
GO

IF OBJECT_ID ('ProductPriceHistory','U') IS NOT NULL
	DROP TABLE ProductPriceHistory
GO


CREATE TABLE ProductPriceHistory
(
	PriceHistoryID uniqueidentifier NOT NULL PRIMARY KEY
	,ProductID int NOT NULL
	,PreviousPrice decimal(19,4) NULL
	,NewPrice decimal(19,4) NOT NULL
	,PriceChangeDate datetime NOT NULL 
)

GO

IF OBJECT_ID ('uProductPriceChange','TR') IS NOT NULL 
	DROP TRIGGER uProductPriceChange
GO


CREATE TRIGGER uProductPriceChange ON Products
	AFTER UPDATE
AS
	INSERT ProductPriceHistory (PriceHistoryID, ProductID, PreviousPrice, NewPrice, PriceChangeDate)
		SELECT 
			NEWID(), p.ProductID, d.price, i.price, GETDATE()
		FROM
			Products AS p
				JOIN 
			inserted AS i on p.ProductID = i.ProductID
				JOIN
			deleted AS d on p.ProductID = d.ProductID


