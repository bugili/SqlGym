USE Demo
GO

SELECT 
	
	
	FirstName + ' ' + LastName AS Employee
	,p.Name
	,COUNT(*) AS NumberOFQuantOf10Sales
FROM
	(SELECT * FROM Sales WHERE Quantity = 10) AS SalesQuantityOf10
		JOIN
	Products AS p ON SalesQuantityOf10.ProductID = p.ProductID
		JOIN
	Employees AS e ON SalesQuantityOf10.EmployeeID = e.EmployeeID

GROUP BY 
	FirstName + ' ' + LastName
	,p.Name
ORDER BY 
	p.Name


select * from Sales

select 
	SUM(s.Quantity * p.Price) AS Earning
	,e.FirstName + ' ' + e.LastName AS Employee
	,SUM(s.quantity) AS NumberOfSales
	,p.Name
from
	Sales AS s
		JOIN
	Employees AS e ON s.EmployeeID = e.EmployeeID
		JOIN 
	Products as p ON s.ProductID = p.ProductID
group by
	e.FirstName + ' ' + e.LastName
	,p.Name

select name,price from Products
