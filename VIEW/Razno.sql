USE Computers
GO

CREATE TABLE LogicalDisk
(
	Name nvarchar(50) NOT NULL,            
	Description nvarchar(50) NULL,        
	FileSystem nvarchar(50) NOT NULL,         
	Size int NOT NULL,               
	Free int NOT NULL,               
ALTER TABLE LogicalDisk
	ALTER COLUMN	
	VolumeName nvarchar(50) NULL         
	SystemName nvarchar(50) NOT NULL,         
	VolumeSerialNumber nvarchar(50) NULL
)

select * FROM LogicalDisk WHERE SystemName LIKE '%ict%' OR SystemName LIKE '%hvtest%'
SELECT * FROM ComputerInfo

DECLARE @Counter int 
SET @Counter = 1
WHILE @Counter <= 5
	BEGIN 
		SELECT 
			(ABS(CHECKSUM(NEWID())) % 4) + 1 AS Random,
			DATEADD(DAY,ABS(CHECKSUM(NEWID()) % 3650), '2007-04-01') AS Date
			
		SET @Counter += 1
	END

SELECT COUNT(*) AS Count FROM ComputerInfo 

SELECT SUM(@@ROWCOUNT) as mem FROM PhysicalMemory WHERE PSComputerName = 'hvtest1' 

SELECT * FROM ComputerInfo WHERE ComputerName LIKE '%XENAPP-DB-TRN01'