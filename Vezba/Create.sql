USE COMPUTERS 
GO

CREATE TABLE ComputerInfo
(
	NAME nvarchar(50) NOT NULL,
	Mem int NOT NULL,
	CPU nvarchar(50) NOT NULL,
	DiskSize int NOT NULL,
	FreeSpace int NOT NULL,
	IPAddress nvarchar(15) NOT NULL,
	Date datetime NOT NULL
)


ALTER TABLE ComputerInfo
	ADD 
		NumberOfCores smallint NOT NULL