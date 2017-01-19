USE Demo
GO

CREATE TABLE EmployeeAuditTrail
(
	EmployeeAuditID int IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED 
	,EmployeeID int NOT NULL
	,FirstName nvarchar(50) NULL
	,MiddleName nvarchar(50) NULL
	,LastName nvarchar(50) NULL
	,Title nvarchar(100) NULL
	,HireDate datetime NULL
	,VacationHours int NULL
	,Salary decimal(19,4) NULL
	,ModifiedDate datetime NULL
	,ModifiedBy nvarchar(255) NULL
)

GO


IF OBJECT_ID ('udEmployeeAudit','TR') IS NOT NULL
	DROP TRIGGER udEmployeeAudit
GO


CREATE TRIGGER udEmployeeAudit ON Employees
	AFTER UPDATE,DELETE
AS

	INSERT EmployeeAuditTrail
		SELECT
			e.EmployeeID,d.FirstName,d.MiddleName,d.LastName,d.Title,d.HireDate,d.VacationHours,d.Salary,GETDATE(),SYSTEM_USER
		FROM
			Employees AS e
				JOIN
			deleted AS d ON e.EmployeeID = d.EmployeeID

GO

IF OBJECT_ID ('uRecalculateVacationHours','TR') IS NOT NULL
	DROP TRIGGER uRecalculateVacationHours
GO



CREATE TRIGGER uRecalculateVacationHours on Employees
	AFTER UPDATE
AS

	IF UPDATE(HireDate)
		BEGIN
			DECLARE @RecalcFlag bit
			SELECT @RecalcFlag = IIF(YEAR(HireDate) = 2012, 0, 1) FROM Employees

			IF (@RecalcFlag = 1)
				UPDATE Employees SET VacationHours += 40 FROM Employees AS e JOIN inserted AS i ON e.EmployeeID = i.EmployeeID
		END

GO



-- Altering trigger

ALTER TRIGGER uRecalculateVacationHours on Employees
	AFTER UPDATE
AS

	IF UPDATE(HireDate)
		BEGIN
			DECLARE @RecalcFlag bit
			SELECT @RecalcFlag = IIF(YEAR(HireDate) = 2017, 1, 1) FROM Employees

			IF (@RecalcFlag = 1)
				UPDATE Employees SET VacationHours += 40 FROM Employees AS e JOIN inserted AS i ON e.EmployeeID = i.EmployeeID
		END

GO

-- Turning off nested triggers 
sp_configure 'nested_triggers', 0 
GO
RECONFIGURE
GO