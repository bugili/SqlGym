USE Demo
GO

--FIRST_VALUE / LAST_VALUE to return product with the lowest price FIRST_VALUE(koje columne) OVER (ORDER BY columna --- desava se pre FIRST_VALUE())
SELECT
	Name
	,Price
	,FIRST_VALUE(Name) OVER (ORDER BY Price) AS Cheapest
FROM
	Products

--LAG to compare next years data with current years data --- LAG(SaCimSePoredi, SaKolikoIza, Default(0))
SELECT
	ProductID
	,YEAR(SaleDate) AS SalesYear
	,SUM(Quantity) AS Quantity
	,LAG(SUM(Quantity), 1, 0) OVER (ORDER BY YEAR(SaleDate)) AS PreviousYearQuantity
FROM
	Sales
WHERE
	ProductID = 1
GROUP BY 
	ProductID, YEAR(SaleDate)



--LEAD to compare next years data with current years data
SELECT
	ProductID
	,YEAR(SaleDate) AS SalesYear
	,SUM(Quantity) AS Quantity
	,LEAD(SUM(Quantity), 1, 0) OVER (ORDER BY YEAR(SaleDate)) AS PreviousYearQuantity
FROM
	Sales
WHERE
	ProductID = 1
GROUP BY 
	ProductID, YEAR(SaleDate)

--CUME_DIST / PERCENT_RANK to show distribution and rank by salary
SELECT
	COALESCE(FirstName + ' ' + LastName, FirstName, LastName) AS Name
	,Title
	,Salary
	,CUME_DIST() OVER (ORDER BY Salary) AS CumeDist
	,PERCENT_RANK() OVER (ORDER BY Salary) AS PctRank
FROM
	Employees
ORDER BY
	COALESCE(FirstName + ' ' + LastName, FirstName, LastName)
	,Salary DESC
--with partition by	
SELECT
	COALESCE(FirstName + ' ' + LastName, FirstName, LastName) AS Name
	,Title
	,Salary
	,CUME_DIST() OVER (PARTITION BY Title ORDER BY Salary) AS CumeDist
	,PERCENT_RANK() OVER (PARTITION BY Title ORDER BY Salary) AS PctRank
FROM
	Employees
ORDER BY
	COALESCE(FirstName + ' ' + LastName, FirstName, LastName)
	,Salary DESC


--PERCENTILE_COUNT / PERCENTILE_DISC to calculate median salary by title
SELECT
	COALESCE(FirstName + ' ' + LastName, FirstName, LastName) AS Name
	,Title
	,Salary
	,PERCENTILE_CONT(.5) WITHIN GROUP (ORDER BY Salary) OVER (PARTITION BY Title) AS MedianCount
	,PERCENTILE_DISC(.5) WITHIN GROUP (ORDER BY Salary) OVER (PARTITION BY Title) AS MedianDisc -- more precise number
FROM 
	Employees
ORDER BY
	COALESCE(FirstName + ' ' + LastName, FirstName, LastName)
	,Salary DESC