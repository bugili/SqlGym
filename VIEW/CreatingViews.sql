USE Computers
GO

CREATE VIEW vComputersWithOS
AS
	SELECT DISTINCT
		ComputerInfo.*
	FROM 
		ComputerInfo
			JOIN
		OS ON ComputerInfo.ComputerName = os.ComputerName

GO


CREATE VIEW vTop5ComputersByMemory
AS
	SELECT TOP 5
		ComputerInfo.ComputerName AS Name,
		SUM(physicalmemory.size) AS TotalMem
	FROM 
		ComputerInfo
			JOIN 
			PhysicalMemory ON ComputerInfo.ComputerName = physicalmemory.psComputerName
	GROUP BY 
		ComputerInfo.ComputerName
GO

SELECT * FROM vTop5ComputersByMemory
	
CREATE VIEW dbo.vComputerDiskMemEasy
	WITH SCHEMABINDING
	
AS
	SELECT 
		ComputerInfo.ComputerName,
		LogicalDisk.FileSystem,
		SUM(PhysicalMemory.size) AS SizeMem,
		COUNT_BIG(*) AS MemSlotsCount
	FROM
		dbo.ComputerInfo
			JOIN 
		dbo.LogicalDisk ON ComputerInfo.ComputerName = LogicalDisk.SystemName
			JOIN 
		dbo.PhysicalMemory ON ComputerInfo.ComputerName = PhysicalMemory.PSComputerName
	GROUP BY 
		ComputerName,
		LogicalDisk.FileSystem
		

GO