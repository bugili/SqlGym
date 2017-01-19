USE Demo
GO

SELECT 
	FirstName
	,LastName
	,Title
FROM 
	Employees
WHERE
	Title LIKE '%sale%'

--Inner Join
SELECT 
	e.FirstName,e.LastName,p.Name,s.Quantity,s.SaleDate
FROM
	Sales AS s
		JOIN 
	Products AS p on s.ProductID = p.ProductID
		JOIN 
	Employees AS e on s.EmployeeID = e.EmployeeID	
ORDER BY
	Quantity DESC
	

--Left JOIN
SELECT 
	*
FROM
	Products AS p
		LEFT JOIN
	Sales AS s ON p.ProductID = s.ProductID

--GROUP BY		
SELECT 
	p.Name
	,COUNT(s.ProductID) AS NumberOfSales
	,ISNULL(SUM(Quantity), 0) AS SalesQuantityTotal
	,ISNULL (SUM(Price * Quantity), 0) AS SaleGrossTotal
FROM
	Products AS p
		LEFT JOIN
	Sales AS s ON p.ProductID = s.ProductID
GROUP BY
	p.Name


--SELECT using right OUTER JOIN, employees with sales
SELECT 
	FirstName + ' ' + LastName + ' - ' + Title AS NameAndTitle
	,COUNT(s.SaleID) AS NumberOFSales
FROM
	Sales AS s
		RIGHT JOIN
	Employees AS e ON e.EmployeeID = s.EmployeeID
GROUP BY 
	FirstName + ' ' + LastName + ' - ' + Title 
HAVING 
	COUNT(s.SaleID) > 0


/*-- Dervied Tables --*/
--Simple Derived Table Query
SELECT 
	FirstName + ' ' + LastName AS Employee
FROM
	(SELECT * FROM Employees WHERE Title LIKE '%Sales%') AS EmployeeDepartment



--Derived Table Query with JOINS
SELECT TOP 10
	Name
	,Quantity
	,FirstName + ' ' + LastName AS Employee
	,SaleDate
	,p.ProductID
FROM
	(SELECT * FROM Sales WHERE Quantity = 10) AS SalesQuantityOf10
		JOIN
	Products AS p ON SalesQuantityOf10.ProductID = p.ProductID
		JOIN
	Employees AS e ON SalesQuantityOf10.EmployeeID = e.EmployeeID
WHERE 
	p.Name = 'spaceship'
ORDER BY 
	SaleDate DESC





SELECT 
	p.Name
	,COUNT(s.ProductID) AS NumberOfSales
	,ISNULL(SUM(Quantity), 0) AS SalesQuantityTotal
	,ISNULL (SUM(Price * Quantity), 0) AS SaleGrossTotal
FROM
	Products AS p
		LEFT JOIN
	Sales AS s ON p.ProductID = s.ProductID
GROUP BY
	p.Name




-- Use of Derived Tables For Perf Gain and Code simplicity

SELECT 
	Name
	,ISNULL(NumberOFSales,0) AS NumberOFSales
	,ISNULL(SalesQuantityTotal,0) AS SalesQuantityTotal
	,ISNULL(SalesGrossTotal,0) AS SalesGrossTotal
FROM
	Products AS pout
		LEFT JOIN
	(
		SELECT 
			p.ProductID
			,COUNT(s.ProductID) AS NumberOfSales
			,SUM(Quantity) AS SalesQuantityTotal
			,SUM(Price * Quantity) AS SalesGrossTotal
		FROM
			Sales AS s
				LEFT JOIN
			Products AS p ON s.ProductID = p.ProductID
		GROUP BY
			p.ProductID
	) AS pin ON pout.ProductID = pin.ProductID
ORDER BY
	SalesGrossTotal DESC

/*-- SYNONIMS --*/
CREATE SYNONYM AWEmployee
	FOR AdventureWorks2012.HumanResources.Employee
GO

SELECT * FROM AWEmployee

DROP SYNONYM AWEmployee