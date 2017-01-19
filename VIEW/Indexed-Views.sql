USE Computers
GO

CREATE VIEW dbo.vComputerDiskMem
	WITH SCHEMABINDING
AS
	SELECT 
		ComputerInfo.ComputerName,
		LogicalDisk.FileSystem,
		SUM(PhysicalMemory.size) AS SizeMem,
		SUM(LogicalDisk.size - LogicalDisk.Free) AS DiskUsed
	FROM
		dbo.ComputerInfo
			JOIN 
		dbo.LogicalDisk ON ComputerInfo.ComputerName = LogicalDisk.SystemName
			JOIN 
		(select sum(size) as size, PSComputerName from dbo.PhysicalMemory group by PSComputerName) AS PhysicalMemory
			ON dbo.ComputerInfo.ComputerName = PhysicalMemory.PSComputerName
	GROUP BY 
		ComputerName,
		LogicalDisk.FileSystem
		

GO

ALTER VIEW dbo.vComputerDiskMemEasy
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

SELECT ComputerName,FileSystem FROM vComputerDiskMemEasy (NOEXPAND)

CREATE UNIQUE CLUSTERED INDEX CIDX_vComputerDiskMemEasy
	ON dbo.vComputerDiskMemEasy(ComputerName,FileSystem)
GO

