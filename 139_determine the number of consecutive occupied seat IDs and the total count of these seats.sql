use sql_challenge;

/*
Question :- Write a query to determine the number of consecutive occupied seat IDs and the total count of these seats?
*/

/*
create table cinema_tbl (seat_id int, status int)

insert into cinema_tbl values (1,1);
insert into cinema_tbl values(2,0);
insert into cinema_tbl values (3,1);
insert into cinema_tbl values (4,0);
insert into cinema_tbl values (5,1);
insert into cinema_tbl values (6,1);
insert into cinema_tbl values (7,1);
insert into cinema_tbl values (8,0);
insert into cinema_tbl values (9,1);
insert into cinema_tbl values (10,1);
*/

--select * from cinema_tbl;
with t1 as(
select seat_id,
		status,
		row_number() over(order by seat_id asc) as nw_id,
		(seat_id - row_number() over(order by seat_id asc)) as flg
from cinema_tbl
where status = 1
), t2 as
(
select *,
		sum(1) over(partition by flg) as seat_count
from t1
)
select * from t2 
where seat_count > 1;
