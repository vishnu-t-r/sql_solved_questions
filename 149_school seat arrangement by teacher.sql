use sql_challenge;

/*
Ruby is a teacher in a school and she has created a table called
SeatArrangement which stores Student's name and corresponding seat ids. Column id is continuous
increment. Now Ruby wants to change the seats for adjacent seats. Write a SQL query to output the
result for Ruby.
*/

/*
create table seat_arrangement(
id int,
student_name varchar(20)
)

insert into seat_arrangement
values(1,'Emma'),
(2,'John'),
(3,'Sophia'),
(4,'Donald'),
(5,'Tom')
*/

--select * from seat_arrangement;

--Method 1

with union_cte as(
select *, (id-1) as nw_id from seat_arrangement
where id%2 = 0

union all

select *, case when (id+1) in (select id from seat_arrangement) then (id+1) 
				else id end as nw_id 
from seat_arrangement
where id%2 <> 0
)
select nw_id as id, student_name
from union_cte;