use Demo
go

--Ranking
SELECT
	EmployeeID
	,ProductID
	,SUM(Quantity) AS TotalProductSale
	,RANK() OVER (ORDER BY SUM(Quantity) DESC) AS QuantityRank --same totalproductsale same rank
	,DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS QuantityDenseRank
	,NTILE(4) OVER (ORDER BY SUM(Quantity) DESC) AS QuantityQuartile
	,ROW_NUMBER() OVER (ORDER BY SUM(Quantity) DESC) AS RowNumber
FROM 
	Sales 
GROUP BY
	EmployeeID, ProductID


SELECT
	EmployeeID
	,p.ProductID
	,SUM(Quantity) AS TotalProductSale
	,RANK() OVER (ORDER BY SUM(Quantity) DESC) AS QuantityRank
	,DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS QuantityDenseRank
	,NTILE(4) OVER (ORDER BY SUM(Quantity) DESC) AS QuantityQuartile
	,ROW_NUMBER() OVER (ORDER BY SUM(Quantity) DESC) AS RowNumber
FROM 
	Sales AS s
JOIN
	Products AS p ON s.ProductID = p.ProductID
GROUP BY
	EmployeeID, p.ProductID

--Ranking  across group by PARTITION (function name OVER (sta god da radis)
SELECT
	EmployeeID
	,ProductID
	,SUM(Quantity) AS TotalProductSale
	,RANK() OVER (PARTITION BY EmployeeID ORDER BY SUM(Quantity) DESC) AS QuantityRank --same totalproductsale same rank
	,DENSE_RANK() OVER (PARTITION BY EmployeeID ORDER BY SUM(Quantity) DESC) AS QuantityDenseRank
	,NTILE(4) OVER (PARTITION BY EmployeeID ORDER BY SUM(Quantity) DESC) AS QuantityQuartile
	,ROW_NUMBER() OVER (PARTITION BY EmployeeID ORDER BY SUM(Quantity) DESC) AS RowNumber
FROM 
	Sales 
GROUP BY
	EmployeeID, ProductID
