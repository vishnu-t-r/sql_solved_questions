use sql_challenge;

/*
Write SQL to derive Start_Date and End_Date column when there is
continuous amount in Balance column as shown below.
*/

/*
create table bank_account(
amount int,
date_stamp date
)

insert into bank_account(amount, date_stamp)
values(26000,'2099-01-01'),
(26000,'2099-01-02'),
(26000,'2099-01-03'),
(30000,'2099-01-04'),
(30000,'2099-01-05'),
(26000,'2099-01-06'),
(26000,'2099-01-07'),
(32000,'2099-01-08'),
(31000,'2099-01-09')
*/

--select * from bank_account;

with t1 as(
select amount, date_stamp,
		row_number() over(partition by amount order by date_stamp asc) as flag
from bank_account
--order by date_stamp asc
),
t2 as(
select amount,
		date_stamp,
		flag,
		day(date_stamp) as date_day,
		(day(date_stamp)-flag) as flag_diff
from t1
--order by date_stamp asc
),
t3 as(
select amount,
		date_stamp,
		flag,
		date_day,
		flag_diff,
		min(date_stamp) over(partition by amount,flag_diff) as bank_start_date,
		max(date_stamp) over(partition by amount,flag_diff) as bank_end_date
from t2
--order by date_stamp asc
)
select distinct amount, bank_start_date, bank_end_date
from t3
order by bank_start_date asc
