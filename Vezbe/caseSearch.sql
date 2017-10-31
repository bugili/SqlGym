select 
	orderid
	,custid
	,val
	,case
		when 
			val < 1000.00
		then 
			'less than 1000'
		when 
			val between 1000.00 and 3000.00
		then 
			'between 1000 and 3000'
		when
			val > 3000.00
		then
			'More than 3000'
		else
			'Unknown'
	end as valueCategory
	,ROW_NUMBER() over(partition by custid order by val) as rowNum
from 
	sales.OrderValues
order by
	rowNum