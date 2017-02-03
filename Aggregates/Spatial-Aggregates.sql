USE Demo
GO

--UNION AGGREGATE to combine spatial object into one

--ENVELOP AGGREGATE
USE AdventureWorks2012
GO
SELECT
	City
	--,SpatialLocation
	,COUNT(City) AS Ukupno
	,RANK() OVER (ORDER BY COUNT(City) DESC) as [RANK]
FROM
	PERSON.Address
WHERE
	StateProvinceID = 79
GROUP BY City

--how to see spatial 
SELECT
	City
	,SpatialLocation
	,CAST(SpatialLocation as nvarchar(max))
FROM
	PERSON.Address
WHERE
	StateProvinceID = 79



SELECT
	City
	,geography::EnvelopeAggregate(SpatialLocation) AS SpatialLocation
FROM
	PERSON.Address
WHERE
	StateProvinceID = 79
GROUP BY City

--COLLECTION --- geography to geometry (returns collection)
SELECT
	geography::CollectionAggregate(SpatialLocation).ToString() AS SpatialLocation
FROM
	Person.Address
WHERE 
	StateProvinceID = 79

--CONVEX HULL
SELECT
	geography::ConvexHullAggregate(SpatialLocation)
FROM
	Person.Address
WHERE 
	StateProvinceID = 79