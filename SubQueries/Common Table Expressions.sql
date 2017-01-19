USE Demo
GO

--Basic Common Table Expression
WITH SalesByYearCTE (EmployeeID, SaleID, SalesYear)
AS
(
	SELECT
		EmployeeID
		,SaleID
		,YEAR(SaleDate) AS SalesYear
	FROM
		Sales
)

SELECT 
	EmployeeID
	,COUNT(SaleID) AS TotalSales
	,SalesYear
FROM
	SalesByYearCTE
WHERE
	SalesYear >= YEAR(DATEADD(yyyy, -3, GETDATE())) --last 3 years
GROUP BY
	SalesYear
	,EmployeeID
ORDER BY
	EmployeeID, SalesYear



--multiple CTE's
WITH EmployeeProductSales (EmployeeID, ProductID, TotalSales) AS
(
	SELECT
		e.EmployeeID
		,p.ProductID
		,SUM(p.Price * s.Quantity) as TotalSales
	FROM
		Employees as e
			JOIN
		Sales AS s ON e.EmployeeID = s.EmployeeID
			JOIN
		Products AS p ON s.ProductID = p.ProductID
	GROUP BY
		p.ProductID, e.EmployeeID
),
ProductInfo (ProductID, ProductName, Price) AS
(
	SELECT 
		ProductID
		,Name
		,Price
	FROM
		Products
),
EmployeeInfo (EmployeeID, EmployeeName) AS
(
	SELECT 
		EmployeeID
		,COALESCE(FirstName + ' ' + MiddleName + ' ' + LastName,
			FirstName + ' ' + LastName,
				FirstName,
					LastName) AS EmployeeName
	FROM
		Employees
)

SELECT 
	[pi].ProductName
	,ei.EmployeeName
	,eps.TotalSales
FROM
	EmployeeProductSales as eps
		JOIN
	ProductInfo as [pi] ON [pi].ProductID = eps.ProductID
		JOIN
	EmployeeInfo as ei ON ei.EmployeeID = eps.EmployeeID
ORDER BY
	ProductName, TotalSales DESC, EmployeeName



--the same with JOIN
select 
	COALESCE( FirstName + ' ' + LastName,
		FirstName) as EmployeeName
	,p.Name
	,SUM(s.Quantity * p.Price) as TotalSale
from
	Employees as e
		join 
	Sales as s on e.EmployeeID = s.EmployeeID
		join
	Products as p on p.ProductID = s.ProductID
group by
	COALESCE( FirstName + ' ' + LastName,
		FirstName)
	,p.Name
order by
	p.Name, TotalSale desc, EmployeeName
	


--self referencing recursive query with CTE
WITH ManagerEmployeesCTE (Name, Title, EmployeeID, EmployeeLevel, Sort)
AS 
(
	--Anchor result set
	SELECT 
		CAST(COALESCE(e.FirstName + ' ' + e.LastName, FirstName) as nvarchar(255)) AS Name
		,e.Title
		,e.EmployeeID
		,1 AS EmployeeLevel
		,CAST(COALESCE(e.FirstName + ' ' + e.LastName, FirstName) AS nvarchar(255)) AS Sort
	FROM 
		Employees AS e
	WHERE 
		e.ManagerID IS NULL
	
	UNION ALL

	--Recursive result set
	SELECT 
		CAST(REPLICATE('|        ', EmployeeLevel) + CAST(COALESCE(e.FirstName + ' ' + e.LastName, FirstName) AS nvarchar(255)) as nvarchar(255)) AS Name
		,e.Title
		,e.EmployeeID
		,EmployeeLevel + 1 AS EmployeeLevel
		,CAST(RTRIM(Sort) + '|    ' + CAST(COALESCE(e.FirstName + ' ' + e.LastName, FirstName) AS nvarchar(255)) AS nvarchar(255)) AS SortOrder
	FROM
		Employees AS e
			JOIN
		ManagerEmployeesCTE AS d on e.ManagerID = d.EmployeeID
)

SELECT 
	EmployeeID, Name, Title, EmployeeLevel
FROM
	ManagerEmployeesCTE
ORDER BY 
	Sort
