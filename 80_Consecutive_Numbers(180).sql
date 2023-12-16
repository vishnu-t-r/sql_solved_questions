use leetcode;

/*
create table logs(
id int,
num int
)

insert into logs(id, num)
values(1,1),
(2,1),
(3,1),
(4,2),
(5,1),
(6,2),
(7,2),

--test case added
insert into logs(id, num)
values(8,3),
(9,3),
(11,3),
(12,1)

*/




--Find all numbers that appear at least three times consecutively.
--Return the result table in any order.


/*
select value
from generate_series(1,10);
*/
/*
with t4 as
(
select N from (values(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) as table_1(N)
), 
t5 as
(
select row_number() over(order by (select null)) as rw_num 
from t4 ten cross join t4 hundred
), t6 as
(
select rw_num
from t5 where rw_num <= (select max(id) from logs)
), 
t1 as
(
select t6.rw_num as id, --id, 
		num,
		--lag(num,1,0) over(order by id) as lag_num,
		--lead(num,1,0) over(order by id) as lead_num,
		--sum(num) over(order by id) as sum_num,
		case when lag(num,1,0) over(order by id)-num = 0 then 0 else 1 end as new_flag	
from t6 left join logs on t6.rw_num = logs.id
), t2 as
(
select t1.id, t1.num, t1.new_flag,
		sum(new_flag) over(order by id) as flag		
from t1
)
select num
from t2
group by num, flag
having count(*) >= 3
*/


-- this is a scalable solution and any number of consecutive numbers can be found

with t4 as
(
select N from (values(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) as table_1(N)
), 
t5 as
(
select (row_number() over(order by (select null)))-1 as rw_num 
from t4 ten cross join t4 hundred cross join t4 thous cross join t4 lakh
), t6 as
(
select rw_num
from t5 where rw_num <= (select max(id) from logs)
),
t1 as
(
select t6.rw_num as id, --id, 
		num,
		--lag(num,1,0) over(order by id) as lag_num,
		--lead(num,1,0) over(order by id) as lead_num,
		--sum(num) over(order by id) as sum_num,
		case when lag(num,1,0) over(order by t6.rw_num)-num = 0 then 0 else 1 end as new_flag	
from t6 left join logs on t6.rw_num = logs.id
)
, t2 as
(
select t1.id, t1.num, t1.new_flag,
		sum(isnull(new_flag,0)) over(order by id) as flag		
from t1
)
select num as ConsecutiveNums
from t2
group by num, flag
having count(*) >= 3
--order by max(id) asc
