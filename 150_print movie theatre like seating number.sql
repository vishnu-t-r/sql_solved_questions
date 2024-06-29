use sql_challenge;

/*
Write a SQL query to print movie theatre like seating numbers.
*/

--first rcte
with cte as(
select char(65) as letter
union all
select char(ascii(letter)+1) as letter
from cte
where letter < 'Z'
)
--second rcte
,cte2 as(
select 1 as num
union all

select num+1 as num
from cte2
where num < 10
),t3 as(
--joing all records of cte and cte2
select letter,num,
		concat(letter,num) as seat_id
from cte,cte2
)
select letter,
		string_agg(seat_id,',') within group(order by seat_id asc) as seat_id
from t3
group by letter