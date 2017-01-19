USE Demo
GO

--subquery in column list
SELECT
	Name
	,(select count(*) from sales) as TotalSales
	,(select count(*) from sales where ProductID = p.productID) as ProductSaleCOunt
FROM
	Products AS p


--subquery in WHERE clause using IN
SELECT
	*
FROM
	Sales
WHERE 
	EmployeeID IN (                --employeeID that are in IN query
					SELECT EmployeeID
					FROM Employees
					WHERE Title LIKE '%sales%'
				)

--Subquery re-written as JOIN
SELECT 
	s.*
FROM 
	Sales AS s
		JOIN
	Employees AS e ON s.EmployeeID = e.EmployeeID
WHERE 
	E.Title LIKE '%sales%'

--EXISTS / NOT EXISTS
USE AdventureWorks2012
GO

--EXISTS
SELECT 
	p.FirstName
	,p.LastName
	,e.JobTitle
FROM
	Person.Person AS p
JOIN
	HumanResources.Employee AS e ON e.BusinessEntityID = p.BusinessEntityID
WHERE EXISTS
		(
			SELECT
				edh.DepartmentID
			FROM
				HumanResources.Department AS d
					JOIN
				HumanResources.EmployeeDepartmentHistory AS edh ON d.DepartmentID = edh.DepartmentID
			WHERE
				e.BusinessEntityID = edh.BusinessEntityID
					AND
				d.Name LIKE 'Research%'
		)

--NOT EXISTS
SELECT 
	p.FirstName
	,p.LastName
	,e.JobTitle
FROM
	Person.Person AS p
JOIN
	HumanResources.Employee AS e ON e.BusinessEntityID = p.BusinessEntityID
WHERE NOT EXISTS
		(
			SELECT
				edh.DepartmentID
			FROM
				HumanResources.Department AS d
					JOIN
				HumanResources.EmployeeDepartmentHistory AS edh ON d.DepartmentID = edh.DepartmentID
			WHERE
				e.BusinessEntityID = edh.BusinessEntityID
					AND
				d.Name LIKE 'Research%'
		)