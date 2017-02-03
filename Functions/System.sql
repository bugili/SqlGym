USE Demo
GO

--Configuration Functions (Global variables)
SELECT @@VERSION
SELECT @@SERVERNAME
SELECT @@SERVICENAME

--System Functions
SELECT @@CONNECTIONS --TOTAL number of connections

--Security Functions
SELECT SYSTEM_USER
SELECT CURRENT_USER

--Conversion Functions
---CAST
SELECT '$' + CAST(Price AS nvarchar(20)) AS Price FROM Products

---CONVERT
SELECT SaleDate, CONVERT(varchar, SaleDate, 7) AS FormattedSaleDate From Sales --SHIFT+1 on convert for format types

--Logic Functions
---IF IIF([bool test], '$true', '$false') 
SELECT 
	EmployeeID
	,FirstName
	,LastName
	,ManagerID
	,IIF(ManagerID IS NULL, 'No', 'Yes') AS HasManager
FROM
	Employees

--Mathematical Functions
---ROUND ROUND([decimal], int --- na koliko decimala zaokruzuje ; ako je broj decimala negativan zaokruzuje se broj levo od zareza)
SELECT ROUND(10.124, 2) AS RoundRight, ROUND(104.124, -2) AS RoundLeft

---POWER
DECLARE @value int, @counter int

SET @value = 2 
SET @counter = 1

WHILE @counter < 100
	BEGIN
		PRINT POWER(@value, @counter)
		SET @counter += 1
	END
GO

--RAND (Non-deterministic)
SELECT RAND()

--RAND (deterministic --- with seed)
SELECT RAND(1)

--Metadata Functions
---OBJECT_ID
IF OBJECT_ID('dbo.TableToDrop', 'U') IS NOT NULL
	DROP TABLE dbo.TableToDrop
GO

---OBJECTPROPERTY
SELECT OBJECTPROPERTY(OBJECT_ID('dbo.GetProductSalesTotal'), 'IsDeterministic')

---SERVERPROPERTY
SELECT SERVERPROPERTY('Edition')

---DB_NAME
SELECT DB_NAME()

--String Functions
---REPLACE --- REPLACE([Ime kolone],[prvi string],[drugi string])
SELECT
	Name
	,REPLACE(Name, 'er', 'ing') AS ErToIng
FROM
	Products

---LEN
SELECT 
	FirstName
	,LEN(FirstName) AS FirstNameLength
	,LastName
	,LEN(LastName) AS LastNameLength
FROM
	Employees

---RTRIM/LTRIM (trim right / trim left)
SELECT '       Spaces!' AS TooMany, LTRIM('    Spaces!') AS JustRight

---SUBSTRING
SELECT
	FirstName
	,LastName
	,(SUBSTRING(FirstName, 1,1) + SUBSTRING(ISNULL(LastName, '%'), 1, 1)) AS Intitials
FROM
	Employees

---LEFT
SELECT LEFT('Levo',1) AS LEVO, RIGHT('Desno',1) AS DESNO

---STUFF / CHARINDEX / SPACE    --- STUFF([string u kome se prave promene],[na kom znaku po redu pocinje promena],[koliko sledecih znakova se menja],[cime se menja])
								---	CHARINDEX --- pretrazuje string i vraca redni broj znaka koji je pronadjem CHARINDEX([sta trazi],[string u kom trazi],[startna lokacija, nije obavezno])
								--- SPACE --- SPACE(Broj space-ova)
SELECT CHARINDEX('M','Iron Man')
SELECT '5' + SPACE(5) + 'Spaces' as Spaces

DECLARE @string varchar(20)
SET @string = 'Watch    Avengers!'
SELECT STUFF(@string, CHARINDEX(SPACE(1), @string) + 1, 2, 'more') AS [:)]

---REVERSE
SELECT REVERSE('Avengers assemble')
