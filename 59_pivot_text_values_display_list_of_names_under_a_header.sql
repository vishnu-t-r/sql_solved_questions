use int_ques
go

--Question?
--pivot a list of values under a header
--here a list of values under a specific occupation?

/*
create table occupations(name varchar(100),occupation varchar(100))


insert into occupations(name,occupation)
values('samantha','doctor'),
('julia','actor'),
('maria','actor'),
('meera','singer'),
('ashely','professor'),
('ketty','professor'),
('christeen','professor'),
('jane','actor'),
('jenny','doctor'),
('priya','singer')
*/

select * from occupations

select actor,doctor,professor,singer
from
(
select * from
(
select name,
	occupation,
	row_number() over(partition by occupation order by name asc) as row_num
from occupations
) t
pivot(
	 max(name)
	 for occupation in
	 ([actor],
	 [doctor],
	 [professor],
	 [singer]
	 )
) as result_table
)a

