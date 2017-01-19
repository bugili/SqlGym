USE Demo
GO

--PIVOT for sum of quantity by year
SELECT
	*
FROM 
	(
		SELECT
			YEAR(SALEDATE) AS SaleYear
--			,s.ProductID
			,p.Name
			,Quantity
		FROM
			Sales as s
				JOIN
			Products as p ON s.ProductID = p.ProductID
		
	) AS s
		PIVOT
	(
		SUM(Quantity)
		FOR [SaleYear]
			IN ([2007],[2008],[2009],[2010],[2011],[2012],[2013],[2014],[2015],[2016],[2017])
	) AS pt


--PIVOT for avg sales per year product
SELECT
	*
FROM 
	(
		SELECT
			YEAR(SALEDATE) AS SaleYear
			,s.ProductID
			,Price * Quantity AS SaleTotal
		FROM
			Sales as s
				JOIN
			Products as p ON s.ProductID = p.ProductID
		
	) AS s
		PIVOT
	(
		AVG([SaleTotal])
		FOR [SaleYear]
			IN ([2007],[2008],[2009],[2010],[2011],[2012],[2013],[2014],[2015],[2016],[2017])
	) AS pt
		JOIN
	Products AS p ON pt.ProductID = p.ProductID
ORDER BY
	pt.ProductID
