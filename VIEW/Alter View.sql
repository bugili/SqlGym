USE Computers
GO

ALTER VIEW vComputersWithOS
AS
	SELECT DISTINCT
		ComputerInfo.ComputerName,
		CPU
	FROM 
		ComputerInfo
			JOIN
		OS ON ComputerInfo.ComputerName = os.ComputerName

GO