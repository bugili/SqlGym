USE [Demo]
GO

/****** Object:  StoredProcedure [dbo].[GetEmployees3]    Script Date: 01.02.2017 08:45:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--Create sproc with date range parameters
ALTER PROCEDURE [dbo].[GetEmployees4]
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
		(@FirstName IS NULL OR FirstName LIKE '%' + @FirstName + '%')
			AND
		(@LastName IS NULL OR LastName LIKE '%' + @LastName + '%')
			AND
		(@Title IS NULL OR Title LIKE '%' + @Title + '%')
			AND
		(
			DATEDIFF(d, @BeginHireDate, HireDate) >= 0   --DATEDIFF([sta se poredi - d za days],[start data],[end date])
				AND
			DATEDIFF(d, @EndHireDate, HireDate) <= 0
		)
		--HireDate BETWEEN @BeginHireDate @EndHireDate

GO

exec GetEmployees4 @FirstName = 'aN'
go

--Search engine on top of sales table
CREATE PROCEDURE GetSales
	@EmployeeID int = NULL
	,@ProductID int = NULL
	,@Quantity smallint = NULL
	,@BeginSaleDate datetime = '1/1/1950'
	,@EndSaleDate datetime = '1//1/9999'
AS

	SELECT
		SaleID
		,EmployeeID
		,ProductID
		,Quantity
		,SaleDate
	FROM
		Sales
	WHERE 
		(@EmployeeID IS NULL OR @EmployeeID = EmployeeID)
			AND
		(@ProductID IS NULL OR @ProductID = ProductID)
			AND
		(
			DATEDIFF(d, SaleDate, @BeginSaleDate) <= 0
				AND
			DATEDIFF(d, SaleDate, @EndSaleDate) >= 0
		)
GO

--Insert new sale, returning SaleID sa output parameter
CREATE PROCEDURE AddSale
	@EmployeeID int
	,@ProductID int
	,@Quantity smallint
	,@SaleID uniqueidentifier OUTPUT

AS

	SET @SaleID = NEWID()

	INSERT INTO Sales
		SELECT @SaleID, @ProductID, @EmployeeID, @Quantity, GETDATE()

GO

--Update existing sale
CREATE PROCEDURE UpdateSale
	@SaleID uniqueidentifier
	,@EmployeID int
	,@ProductID int
	,@Quantity int
AS
	
	UPDATE 
		Sales
	SET
		EmployeeID = @EmployeID
		,ProductID = @ProductID
		,Quantity = @Quantity
		,SaleDate = GETDATE()
	WHERE
		SaleID = @SaleID
GO

--Add or Update existing sale
CREATE PROCEDURE UpdateSale
	@SaleID uniqueidentifier = NULL
	,@EmployeeID int
	,@ProductID int
	,@Quantity int
AS
	IF @SaleID IS NULL
		INSERT INTO  
			Sales
		SELECT
			NEWID()
			,@EmployeeID
			,@ProductID
			,@Quantity
			,GETDATE()
	ELSE
		UPDATE 
			Sales
		SET
			EmployeeID = @EmployeeID
			,ProductID = @ProductID
			,Quantity = @Quantity
			,SaleDate = GETDATE()
		WHERE 
			SaleID = @SaleID

GO

--Delete Sale
CREATE PROCEDURE DeleteSale
	@SaleID uniqueidentifier
AS
	
	DELETE FROM
		Sales
	WHERE
		SaleID = @SaleID

GO
