USE Demo
GO

-- CASE (equality expression)
SELECT
	FirstName 
	,LastName
	,CASE Gender
		WHEN 'F' THEN 'Female'
		WHEN 'M' THEN 'Male'
		ELSE 'Unknown'
	END AS GenderDescription, -- Aliasing name of column
	MaritalStatusDescription = CASE MaritalStatus -- another way of making alias
		WHEN 'S' THEN 'Single'
		WHEN 'M' THEN 'Married'
		ELSE 'Unknown'
	END
FROM 
	AdventureWorks2012.HumanResources.Employee AS e
		JOIN
	AdventureWorks2012.Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID 

-- CASE (searched expression using range)

SELECT 
	ProductID
	,Name
	,Price 
	,CASE 
		WHEN Price < 100 THEN 'Affordable'
		WHEN Price >= 100 and Price < 1000 THEN 'How much?!?!?' 
		WHEN Price > 1000 THEN 'Robbery far, far away!'
	END AS CustomerResponse
FROM 
	Products

-- CASE (in ORDER BY)
SELECT 
	*
FROM 
	Products
ORDER BY 
	CASE DiscontinuedFlag WHEN 0 THEN ProductID END DESC	
	,CASE DiscontinuedFlag WHEN 1 THEN ProductID END DESC	

--CASE (in WHERE)

SELECT 
	*
FROM
	Products
WHERE 
	1 = CASE WHEN Price < 100 THEN 1 ELSE 0 END
--  1 = CASE WHEN FIELD IS NULL THEN 1 ELSE 0 END


--COALESCE (x params, ANSI SQL standard)
SELECT
	EmployeeID
	,FirstName
	,MiddleName
	,FirstName + ' ' + LastName as FirstLastName
	,COALESCE(FirstName + ' ' + MiddleName + ' ' + LastName,
				FirstName + ' ' + LastName,
					FirstName,
						LastName,
							'No name') AS FullName
FROM
	Employees


--ISNULL (2 params, T-SQL specific) 
SELECT 
	EmployeeID
	,FirstName
	,ISNULL(MiddleName, 'N/A') AS MiddleName
	,LastName
FROM 
	Employees


--Ranking (employees by salary)
SELECT 
	COALESCE(FirstName + ' ' + MiddleName + ' ' + LastName,
				FirstName + ' ' + LastName,
					FirstName,
						LastName,
							'No name') AS FullName
	,Title
	,Salary
	,RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
	,DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryDenseRank --won't skip a number
	,ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum --gives row a number
FROM
	Employees




--Ranking (top sales by employee, products)
SELECT 
	s.EmployeeID
	,p.ProductID
	,SUM(Quantity * Price) AS TotalProductSales
	,RANK() OVER (PARTITION BY s.EmployeeID ORDER BY SUM(Quantity * Price)) AS EmployeeProductSalesRank
FROM
	Sales AS s
		JOIN
	Products AS p ON s.ProductID = p.ProductID
GROUP BY
	s.EmployeeID, p.ProductID