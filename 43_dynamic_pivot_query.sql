--dynamic pivot query
--select * from datespine

declare @column nvarchar(max) = ''
declare @sql nvarchar(max) = ''

select 
	@column += quotename(product)+','
from
	(select distinct product as product from datespine)t
order by product

set @column = left(@column,len(@column)-1)

set @sql ='select * from
				(select sales_date
					,product
					,sales
			from datespine)t
			pivot(sum(sales)
					for product in 
							('+ @column +'))as a'

execute sp_executesql @sql;
				