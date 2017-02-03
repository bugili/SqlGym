USE Demo
GO

--Simple DELETE
DELETE FROM
	Products
WHERE 
	ProductID = 5

--DELETE multiple rows
DELETE FROM
	Sales
WHERE 
	DATEPART(yyyy, SaleDate) <= 2008

--DELETE based on join

--DELETE based on join
DELETE
	s
FROM
	Sales as s
		JOIN
	Employees e on s.EmployeeID = e.EmployeeID
WHERE
	e.Title = 'Sales Manager'

select * from Sales

--DELETE to remove duplicates
SELECT 
	ProductID, EmployeeID, Quantity, SaleDate, COUNT(*) as Count
FROM
	Sales
GROUP BY
	ProductID, EmployeeID, Quantity, SaleDate
HAVING 
	COUNT(*) > 1

DELETE 
	Sales
WHERE
	SaleID IN
		(
			SELECT	
				MAX(SaleID) AS SaleIDToDelete
			FROM
				Sales
			GROUP BY
				ProductID, EmployeeID, Quantity, SaleDate
			HAVING
				COUNT(*) > 1
		)
				
