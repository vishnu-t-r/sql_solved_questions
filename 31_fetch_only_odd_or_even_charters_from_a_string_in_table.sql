/*
create table input_string(
input varchar(50)
)

insert into input_string(input)
values('mercedespetronas')
values('lewishamilton')

*/

--select * from input_string


with cte as
(
select input as string
		,1 as strt
		--,len(input) as lngth
from input_string

union all

select input as string
		,strt+2 as strt
from cte
join input_string
on cte.string = input_string.input
where strt <= len(input)
)


select string_agg(odd_char,' ') within group (order by strt) as string_req
from 
(
select *,substring(string,strt,1) as odd_char 
from cte
--order by string,strt
) A
GROUP BY STRING
/*
select distinct string,strt
	--substring(string,strt,1) as odd_char 
from cte
order by string,strt
*/