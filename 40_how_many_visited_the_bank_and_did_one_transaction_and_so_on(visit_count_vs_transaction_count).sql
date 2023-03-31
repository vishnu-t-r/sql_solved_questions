--Write an SQL query to find how many users visited the bank and didn’t do any transactions,
--how many visited the bank and did one transaction and so on.

--result should contain columns namely
		--transaction_count
		--visit_count
/*
create table visits(
user_id int,
visit_date date
)

insert into visits(user_id,visit_date)
values(1,'2020-01-01'),
(2,'2020-01-02'),
(12,'2020-01-01'),
(19,'2020-01-03'),
(1,'2020-01-02'),
(2,'2020-01-03'),
(1,'2020-01-04'),
(7,'2020-01-11'),
(9,'2020-01-25'),
(8,'2020-01-28')

create table transactions(
user_id int,
transaction_date date,
amount int
)

insert into transactions(user_id,transaction_date,amount)
values(1,'2020-01-02',120),
(2,'2020-01-03',22),
(7,'2020-01-11',232),
(1,'2020-01-04',7),
(9,'2020-01-25',33),
(9,'2020-01-25',66),
(8,'2020-01-28',1),
(9,'2020-01-25',99)
*/

select * from visits
select * from transactions


select * 
		,count(v.visit_date) over(partition by t.user_id) as visit_count
from visits v
left join
transactions t
on v.user_id = t.user_id
and v.visit_date = t.transaction_date

select user_id
		,count(*) as visit_count
from visits
group by user_id