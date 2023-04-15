--table used 'datespine'

--pivot operator

--select * from datespine

--example 1
select *
from
(
select product
		,sales
from datespine
)t
pivot(sum(sales)
		for product in ([A],[B])
) AS b

--example 2
select * from
(
select sales_date	
		,product
		,sales
from datespine
) t
pivot(
sum(sales)
	for product in ([A],[B])
) A


--USING QUOTENAME


declare @column nvarchar(max) = ''

select
	@column += quotename(product)+','
from
	(select distinct product as product
from datespine)t
order by
	product

--print @column
set @column = left(@column,len(@column)-1)
print @column

--select * from datespine
--copy and paste the above @column value in the pivot condition