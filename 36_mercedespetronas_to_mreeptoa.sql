--select * from [dbo].[input_string]


with cte as
(
select input,1 as n
from input_string
union all

select input, n+2 as n
from cte
where n <= len(input)
)

select input,string_agg(letter,'') within group(order by n asc)
from
(
select input
		,n
		,substring(input,n,1) as letter
from cte
--order by input,n asc
) a
group by input
--string_agg