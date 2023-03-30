--Write a query to display the records for which more than 100(inclusive) are visiting the stadium
--for 3 or more consecutive days ? .

--table
--stadium

/*
create table stadium(
id int,
visit_date date,
people int
)

insert into stadium(id,visit_date,people)
values(1,'2022-01-01',10),
(2,'2022-01-02',109),
(3,'2022-01-03',150),
(4,'2022-01-04',99),
(5,'2022-01-05',150),
(6,'2022-01-06',145),
(7,'2022-01-07',199),
(8,'2022-01-08',188)

*/
/*
insert into stadium(id,visit_date,people)
values(9,'2022-01-09',99),
(10,'2022-01-10',109),
(11,'2022-01-11',150),
(12,'2022-01-12',100),
(13,'2022-01-13',89),
(14,'2022-01-14',121),
(15,'2022-01-15',145)
*/

with t1 as
(
select * 
		,row_number() over(order by visit_date asc) as nw_id
		,id - row_number() over(order by visit_date asc) as diff
from stadium
where people >= 100
),
t2 as
(
select *
		,count(*) over(partition by diff) as con_days
from t1
)
select id	
		,visit_date
		,people
from t2
where con_days >= 3


--select * from stadium
