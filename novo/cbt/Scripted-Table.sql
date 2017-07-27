USE [SqlGym]
GO

/****** Object:  Table [dbo].[Employees]    Script Date: 7/26/2017 6:39:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON --- dozvoljava da se pod navodnicima "" koriste keywords ("select")
GO

CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](75) NOT NULL,
	[Title] [nvarchar](100) NULL,
	[HireDate] [datetime] NOT NULL,
	[VacationHours] [smallint] NULL,
	[Salary] [decimal](19, 4) NOT NULL
) ON [PRIMARY] --- filegroups
GO											--- batch terminator --- (salje se odvojeno database engine-u)



if null = null
	print 'yes... null = null'
else
	print 'no ... null != null'

set ansi_nulls off --- null = null