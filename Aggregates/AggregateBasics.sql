USE Demo
GO

/*-- GROUP BY --*/
--Basic Group BY

SELECT 
	ProductID
	,Quantity
FROM 
	Sales
ORder By
	ProductID	



SELECT 
	ProductID
	,SUM(Quantity) as TotalQuantity
FROM
	Sales
GROUP BY 
	ProductID
ORDER BY 
	ProductID

--GROUP BY with multiple groups / HAVING

SELECT
	EmployeeID
	,ProductID
	,SUM(Quantity) AS TotalQuantitySold
FROM 
	Sales
GROUP BY
	EmployeeID, ProductID
ORDER BY 
	ProductID


--GROUP BY with multiple groups / HAVING
SELECT
	EmployeeID
	,ProductID
	,SUM(Quantity) as TotalQuantitySolde
FROM
	Sales
GROUP BY 
	EmployeeID
	,ProductID
HAVING
	SUM(Quantity) > 400
ORDER BY
	EmployeeID


--GROUP BY result of function
SELECT
	DATEPART(yyyy, SaleDate) as SaleYear
	,SUM(Quantity) as TotalQuantitySold
FROM
	Sales
GROUP BY 
	DATEPART(yyyy, SaleDate)
ORDER BY
	DATEPART(yyyy, SaleDate) DESC

--Use derived tables and subqueries for taking aggregates and then join them to other tables

/*-- Grouping sets --*/
--Basic GROUPING SET
SELECT
	EmployeeID
	,SUM(Quantity) AS QuantitySold
FROM
	Sales
GROUP BY GROUPING SETS ((EmployeeID), ()) --GRAND TOTAL OF RESULT SET

SELECT 
	EmployeeID
	,DATEPART(yyyy, SaleDate) AS SaleYear
	,SUM(Quantity) AS QuantitySold
FROM
	Sales
GROUP BY GROUPING SETS ((EmployeeID, DATEPART(yyyy, SaleDate)), (EmployeeID) /* grand total */, ()) 


--GROUPING SET with multiple groups & multiple aggregations
SELECT 
	EmployeeID
	,DATEPART(MM, SaleDate) as SaleMonth
	,DATEPART(yyyy, SaleDate) as SaleYear
	,SUM(Quantity) AS Sales
FROM 
	Sales
GROUP BY GROUPING SETS (
							(EmployeeID, DATEPART(MM, SaleDate), DATEPART(yyyy, SaleDate))
							,(EmployeeID, DATEPART(MM, SaleDate))
							,(EmployeeID)
							,()
						)


--GROUPING SET with unrelated aggregations
SELECT 
	EmployeeID
	,DATEPART(yyyy, SaleDate) as SaleYear
	,SUM(Quantity) AS Sales
FROM 
	Sales
GROUP BY GROUPING SETS ((EmployeeID), (DATEPART(yyyy, SaleDate)))


--moja vezba
--GROUP BY GROUPING SETS ( (GROUP BY COLUMNS), (TOTAL COLUMNE NAPISANE U DRUGOJ ZAGRADI) )
SELECT 
	EmployeeID
	,DATEPART(yyyy, SaleDate) as SaleYear
	,SUM(Quantity) AS Sales
FROM 
	Sales
GROUP BY GROUPING SETS
	(
		(EmployeeID,DATEPART(yyyy, SaleDate)),
		(EmployeeID),
		()
	)
ORDER BY EmployeeID, SaleYear 