use sql_challenge;

/*
Question :-
Find the number which is appearing consecutively three or more time.
*/

/*
create table num_table(id int);

insert into num_table
values(1),(1),(1),(2),(3),(3),(4),(4),(4),(4),(5),(5),(7),(7),(7),(7)
*/

--select * from num_table;

--Method 1 (using aggregate function as analytical function - sum or count)
with t1 as(
select id,
		--not necessary to use the order by clause in the sum and count function here
		sum(1) over(partition by id order by id asc) as flg_sum,
		count(1) over(partition by id order by id asc) as flg_count
from num_table
)
select distinct id 
from t1
where flg_sum >= 3;

--Method 2 (using lead and lag function)
with t1 as(
select id,
		lag(id) over(partition by id order by id asc) as lag_id,
		lead(id) over(partition by id order by id asc) as lead_id
from num_table
)
select distinct id
from t1
where id = lag_id and id = lead_id;