SELECT * FROM sys.login_token

[chk].[MSSQL_Version][chk].[Net_Link]


SELECT Host FROM [sw].[AllSoftwareList]	
	WHERE OriginalName NOT LIKE '%Boldon%'

SELECT * FROM 
	(SELECT DISTINCT HOST,SystemRole FROM sw.AllSoftwareList) A 
	WHERE NOT EXISTS (SELECT 1 FROM sw.AllSoftwareList WHERE host = a.host AND OriginalName LIKE '%BOLDON%') 
	AND
	SystemRole NOT LIKE '%Server%'

SELECT * FROM [chk].[Location] x
	where not exists (SELECT 1 FROM chk.Location WHERE Location > x.Location)

SELECT MAX(Location) FROM chk.Location

SELECT a.Location FROM chk.Location a
	LEFT JOIN chk.Location AS b
	ON b.Location > a.Location
	WHERE b.Location IS NULL


	SELECT * FROM
[dep].[Ci_Object]

SELECT DISTINCT dependOnCIType FROM 
dep.Ci_Dependency
WHERE oCIType = 'OS.Vm'