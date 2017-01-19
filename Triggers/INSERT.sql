USE Demo
GO

IF OBJECT_ID ('iProductNotification','TR') IS NOT NULL
	DROP TRIGGER iProductNotification
GO

CREATE TRIGGER iProudctNotification ON Products
	AFTER INSERT
AS
	DECLARE @ProductInformation nvarchar(255);

	SELECT 
		@ProductInformation = 'New product' + Name + 'is now available for' + CAST(price as nvarchar(20)) + '!'
	FROM
		inserted;

	PRINT @ProductInformation
GO