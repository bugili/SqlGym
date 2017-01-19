USE Computers
GO

CREATE VIEW vCompAndNIC
AS
	SELECT DISTINCT
	computerinfo.*
	FROM
		ComputerInfo
		JOIN
		NetworkCards ON ComputerInfo.ComputerName = NetworkCards.ComputerName

GO


SELECT * FROM ComputerInfo
DROP VIEW vCompAndNIC

DELETE ComputerInfo
	WHERE NumberOfCpus IS NULL