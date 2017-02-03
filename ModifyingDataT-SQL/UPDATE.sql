USE Demo
GO

--Simple UPDATE statement
UPDATE 
	Products
SET
	DiscontinuedFlag = 1
WHERE 
	ProductID = 5

select * from Products

--UPDATE multiple rows
UPDATE 
	Employees
SET
	VacationHours = VacationHours * 1.10
WHERE
	Title = 'Sales Person'

UPDATE 
	Employees
SET
	VacationHours /= 1.10
WHERE
	Title = 'Sales Person'

--UPDATE using join

UPDATE
	e
SET
	VacationHours = 0
	,Salary = 0
FROM 
	Employees as e
		LEFT JOIN
	Sales AS s ON  e.EmployeeID = s.EmployeeID
WHERE 
	e.Title LIKE 'Sales%'
		AND
	s.SaleID IS NULL
