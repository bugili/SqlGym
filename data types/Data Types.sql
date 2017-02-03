USE Demo
GO

IF OBJECT_ID('DataTypeTester', 'U') IS NOT NULL
	DROP TABLE DataTypeTester 


CREATE TABLE DataTypeTester
(
	---Character data types
	[char] char(3)
	,[varchar] varchar(10)
	,[varcharMAX] varchar(MAX)
	,[text] text

	---Unicode character data types
	,[nchar] nchar(3)
	,[nvarchar] nvarchar(10)
	,[nvarcharMAX] nvarchar(MAX)
	,[ntext] ntext

	---Binary data types
	,[bit] bit
	,[binary] binary(3)
	,[varbinary] varbinary(10)
	,[varbinaryMAX] varbinary(MAX)
	,[image] image

	---Numeric data types (exact)
	,[tinyint] tinyint
	,[smalint] smallint
	,[int] int
	,[bigint] bigint
	,[decimal] decimal(14,6)
	,[numeric] numeric(14,6)
	,[smallmoney] smallmoney
	,[money] money

	---Numeric data types (approx)
	,[float] float
	,[real] real

	---Date data types
	,[datetime] datetime
	,[datetime2] datetime2
	,[smalldatetime] smalldatetime
	,[date] date
	,[datetimeoffset] datetimeoffset
	,[timestamp] timestamp

	---Special data types
	,[sql_variant] sql_variant
	,[uniqueidentifier] uniqueidentifier
	,[xml] xml
	,[hierarchyid] hierarchyid

	---Spatial data types
	,[geometry] geometry 
	--,[geography] geography
)

INSERT INTO DataTypeTester
	(
		[char]
		,[varchar]
		,[varcharMAX]
		,[text]
		,[nchar]
		,[nvarchar]
		,[nvarcharMAX]
		,[ntext]
		,[bit]
		,[binary]
		,[varbinary]
		,[varbinaryMAX]
		,[image]
		,[tinyint]
		,[smalint]
		,[int]
		,[bigint]
		,[decimal]
		,[numeric]
		,[smallmoney]
		,[money]
		,[float]
		,[real]
		,[datetime]
		,[datetime2]
		,[smalldatetime]
		,[date]
		,[datetimeoffset]
		,[sql_variant]
		,[uniqueidentifier]
		,[xml]
		,[hierarchyid]
		,[geometry]
	)
	VALUES
	(
		---ANSI
		'ABC'
		,'Vary'
		,'MAX of over billion and varying'
		,'Up to 2GB of data!'

		---Unicode
		,N'Šta'
		,N'Kolikooæeš'
		,N'Može i kineski'
		,N'A doðe baš i ruski'

		---Binary
		,0
		,CAST('ABC' as binary(3))
		,CAST('Varying' as varbinary(10))
		,CAST('MAX of 2gb binary data (varying)' as varbinary(MAX))
		,(select * from OPENROWSET (BULK 'C:\Users\Public\Pictures\Sample Pictures\Penguins.jpg', SINGLE_BLOB ) i)

		---Numeric data (exact)
		,255
		,32767
		,2147483647
		,9223372036854775807
		,99999999.999999
		,99999999.999999
		,214748.3647
		,922337203685477.5807

		---Numeric data (approx.)
		,1.79E+308
		,3.40E+38

		---DateTime data
		,GETDATE()
		,SYSDATETIME() --- returns datetime2
		,CAST(GETDATE() as smalldatetime)
		,CONVERT(varchar(12), GETDATE(), 14)
		,TODATETIMEOFFSET(GETDATE(), -120)

		---Special data
		,15--GETDATE()
		,NEWID()
		,'<XMLROOT>
			<Person>
				<FirstName>Luke</FirstName>
				<LastName>Skywalker</LastName>
			</Person>
		</XMLROOT>'
		,NULL

		--Spatial data
		,geometry::STGeomFromText('LINESTRING(1 1, 5 1, 3 5, 1 1)',0)
		--,geography::STMPolyFromText('MULTIPOLYGON(((-0.96555328369140625 60.

	)

GO

SELECT
	* 
FROM
	DataTypeTester