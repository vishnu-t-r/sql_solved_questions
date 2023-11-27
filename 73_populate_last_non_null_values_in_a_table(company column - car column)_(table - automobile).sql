--populate values to the last non-null values

use int_ques;

/*
create table automobile(
company varchar(100),
car varchar(100)
)

insert into automobile(company,car)
values('Mercedes', 'A-class'),
(null, 'GLE'),
(null, 'G-class'),
(null, 'CLS'),
('Audi', 'audi q7'),
(null, 'aud q3'),
(null, 'audi-etron'),
('Lexus', 'lexus es'),
(null, 'lexus lc'),
(null, 'NX')
*/


--select * from automobile;

with t1 as
(
select a.company as a_company,
		a.car as a_car,
		a.new_id,
		--b.company as b_company,
		--b.car as b_car,
		b.new_id2 as new_id2,
		--iif(b.new_id2 is null,lag(b.new_id2) over(order by a.new_id), b.new_id2) as col,
		case when new_id = 1 then 1
		else
		(a.new_id - iif(b.new_id2 is null,lag(b.new_id2) over(order by a.new_id), b.new_id2))
		end as new_partition
from
(
select company,
		car,
		row_number() over(order by (select null)) as new_id
from automobile
)a
left join
(
select company,
		car,
		row_number() over(order by (select null)) as new_id2
from automobile
where company is null
)b
on a.car = b.car
)

select a_company,
		first_value(a_company) over(partition by new_partition order by new_id asc) as new_company,
		a_car
from t1