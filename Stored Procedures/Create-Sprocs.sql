USE Demo
GO

--Basic stoerd procedure to get employees with first/last name parameters
CREATE PROC GetEmployees
	@FirstName nvarchar(50) -- ako ima =NULL - optional
	,@LastName nvarchar(50)
AS

	SET NOCOUNT ON; --turns off number of rows affected by procedure

	SELECT
		FirstName
		,LastName
		,MiddleName
		,Title
		,HireDate
	FROM
		Employees
	WHERE
		FirstName = @FirstName
			AND
		LastName = @LastName
GO

--Execute sproc
EXEC GetEmployees 'Luke','Skywalker'
GO


--Create Sproc with optional title parameter and wildcard first/last names
CREATE PROCEDURE GetEmployees2
	@FirstName nvarchar(50)
	,@LastName nvarchar(50)
	,@Title nvarchar(100) = NULL
AS

	SET NOCOUNT ON;

	SELECT
		FirstName
		,LastName
		,MiddleName
		,Title
		,HireDate
	FROM
		Employees
	WHERE
		FirstName LIKE '%' + @FirstName + '%'
			AND
		LastName LIKE '%' + @LastName + '%'
			AND
		Title = COALESCE(@Title, Title)
GO

GetEmployees2 'e','e','Sales person'

--Execute sproc specifying parameters
GetEmployees2 @LastName = 'e', @FirstName = 'e'
GO

--Create sproc with date range parameters
ALTER PROCEDURE GetEmployees3
	@FirstName nvarchar(50) = NULL
	,@LastName nvarchar(50) = NULL
	,@Title nvarchar(100) = NULL
	,@BeginHireDate datetime = '1/1/1800'
	,@EndHireDate datetime = '12/31/9999'
AS

	SET NOCOUNT ON;

	SELECT
		FirstName
		,LastName
		,MiddleName
		,Title
		,HireDate
	FROM
		Employees
	WHERE
		FirstName LIKE '%' + COALESCE(@FirstName, FirstName) + '%'
			AND
		LastName LIKE '%' + COALESCE(@LastName, LastName) + '%'
			AND
		Title = COALESCE(@Title, Title)
			AND
		(
			DATEDIFF(d, @BeginHireDate, HireDate) >= 0   --DATEDIFF([sta se poredi - d za days],[start data],[end date])
				AND
			DATEDIFF(d, @EndHireDate, HireDate) <= 0
		)
		--HireDate BETWEEN @BeginHireDate @EndHireDate
GO

EXEC GetEmployees3 'e','a',null,'1/1/2005','1/1/2017'

--Execute sproc specifying dates only
EXEC GetEmployees3 @BeginHireDate='1/1/1900', @EndHireDate='12/31/2017'

DROP PROCEDURE GetEmployees

GRANT EXECUTE ON GetEmployee TO [user]