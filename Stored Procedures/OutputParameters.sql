USE Demo
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

--Execute
DECLARE @SaleID uniqueidentifier

EXECUTE AddSale 1,2,12, @SaleID OUTPUT

PRINT 'SaleID: ' + CAST(@SaleID as nvarchar(50))
GO

--Stored procedure returning scalar result as output parameter
CREATE PROCEDURE GetProductSalesAmountByYear
	@ProductID int
	,@Year SmallInt
	,@SalesTotal decimal(19,4) OUTPUT
AS

	SELECT 
		@SalesTotal = SUM(Quantity * Price)
	FROM
		Sales as s
			JOIN
		Products as p ON s.ProductID = p.ProductID
	WHERE 
		s.ProductID = @ProductID
			AND
		YEAR(s.SaleDate) = @Year
	GROUP BY 
		s.ProductID, YEAR(s.SaleDate)
GO

--Execute sproc storing and displaying output parameter
DECLARE @SalesTotal decimal(19,4)

EXECUTE GetProductSalesAmountByYear 1,2009,@SalesTotal OUTPUT

PRINT 'Total: ' + CAST(@SalesTotal AS nvarchar(50))
GO




--trpanje sproc u variablu
DECLARE @t TABLE 
(
	PROCEDURE_QUALIFIER nvarchar(10)
	, Procedure_Owner nvarchar(3)
	, ProcedureName nvarchar(100)
	, NUM_INPUT_PARAMS smallint
	, NUM_OUTPUT_PARAMS smallint
	,NUM_RESULT_SETS smallint
	,REMARKS nvarchar(50) NULL
	,PROCEDURE_TYPE smallint
)
insert into @t
exec sp_stored_procedures

select * from @t
where Procedure_Owner NOT LIKE 'sys' AND ProcedureName NOT LIKE 'sp_%' AND ProcedureName NOT LIKE 'fn_%'


select * from sys.all_objects where type_desc Like '%stored_procedure' AND name NOT LIKE '%sp_%'

