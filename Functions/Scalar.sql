USE Demo
GO

--Basic scalar function to return a products sale total
CREATE FUNCTION GetProductSalesTotal
(
	@ProductID int
)
RETURNS decimal(19,4)
AS
BEGIN

	DECLARE @SalesTotal decimal(19,4)			--value that will store result

	SELECT 
		@SalesTotal = SUM(Quantity * Price)
	FROM
		Sales AS s
			JOIN
		Products AS p ON s.ProductID = p.ProductID
	WHERE
		s.ProductID = @ProductID
	GROUP BY 
		s.ProductID

	RETURN @SalesTotal

END
GO


select 
	Name
	,dbo.GetProductSalesTotal(ProductID)
From
	Products


--Scalar function to validate email address
ALTER FUNCTION ValidateEmailAddress
(
	@Email varchar(255)
)
RETURNS bit
AS
BEGIN

	DECLARE @valid bit = 0

	IF @Email IS NOT NULL AND @Email LIKE '%_@_%_.__%'
		SET @valid = 1

	RETURN @valid

END
GO

ALTER TABLE Employees ADD EmailAddress nvarchar(255) NULL


UPDATE Employees SET EmailAddress = 'lskywalker@demo.com' WHERE EmployeeID = 1
UPDATE Employees SET EmailAddress = 'dmauldemo.com' WHERE EmployeeID = 2
UPDATE Employees SET EmailAddress = 'hsolo@demo.com' WHERE EmployeeID = 3
UPDATE Employees SET EmailAddress = 'epalp@demo.com' WHERE EmployeeID = 4
UPDATE Employees SET EmailAddress = 'cdook.com' WHERE EmployeeID = 5
UPDATE Employees SET EmailAddress = 'okenobi@demo.com' WHERE EmployeeID = 6

GO

--Use in SELECT list to view results for every row
SELECT
	EmployeeID
	,FirstName
	,LastName
	,EmailAddress
	,dbo.ValidateEmailAddress(EmailAddress) as [Valid?]
FROM
	Employees


--Use in WHERE clause to return list of invalid email addresses
SELECT
	*
FROM 
	Employees
WHERE
	dbo.validateemailaddress(Emailaddress) = 0
		AND
	EmailAddress IS NOT NULL


--Scalar functions to format a date
CREATE FUNCTION CustomDateFormat
(
	@Date datetime
)
RETURNS char(10)
AS

BEGIN 
	
	RETURN CAST(DATEPART(day, @date) AS varchar)
		+ '/' + CAST(DATEPART(month, @Date) AS varchar)
		+ '/' + CAST(DATEPART(year, @Date) AS varchar)
END


SELECT
	p.Name
	,s.Quantity
	,s.SaleDate
	,dbo.CustomDateFormat(s.SaleDate) as FormattedDate
FROM 
	Sales as s
		join
	Products as p on s.ProductID = p.ProductID
GO