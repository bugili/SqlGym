USE Demo
GO

--Inline table-value function to return table data type with employees
CREATE FUNCTION EmployeesByTitle
(
	@Title as nvarchar(100)
)
RETURNS TABLE
AS
RETURN

	SELECT 
		*
	FROM 
		Employees
	WHERE 
		Title LIKE '%' + @Title + '%'

GO

select * from EmployeesByTitle('Sales')
select * from EmployeesByTitle('Manager')

--Multi-statement table-value function to return table with product sales
CREATE FUNCTION ProductSales
(
	@ProductID int
)
RETURNS @ProductSalesData table
								(
									ProductID int NOT NULL
									,EmployeeID int NOT NULL
									,Quantity smallint NOT NULL
									,SaleDate datetime NOT NULL
								)
AS
BEGIN

	INSERT INTO @ProductSalesData
		SELECT 
			ProductID
			,EmployeeID
			,Quantity
			,SaleDate
		FROM
			Sales
		WHERE ProductID = @ProductID
RETURN
END

GO

--Select from table-value function
select * from ProductSales(1)

--JOIN using standard join syntax (must hardcode params)
SELECT
	p.ProductID
	,p.Name
	,DiscontinuedFlag
	,EmployeeID
	,ps.Quantity
	,ps.SaleDate
	,dbo.CustomDateFormat(ps.SaleDate) as FormattedDate
FROM
	Products AS p
		JOIN
	ProductSales(1) AS ps ON p.ProductID = ps.ProductID

--CROSS APPLY for INNER joining to table-value function
SELECT
	*
FROM
	Products AS p
		CROSS APPLY
	ProductSales(p.ProductID)

--CROSS APPLY for OUTER joining to table-value function (LEFT JOIN)
SELECT
	*
FROM
	Products AS p
		OUTER APPLY
	ProductSales(p.ProductID)