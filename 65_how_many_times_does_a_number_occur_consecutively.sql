-- how many times does a number occur consecutively?

use int_ques;

/*
Create table Logs 
	( id integer identity,
	  num varchar(50)
	);



INSERT INTO Logs VALUES ('1');
INSERT INTO Logs VALUES ('1');
INSERT INTO Logs VALUES ('1');
INSERT INTO Logs VALUES ('2');
INSERT INTO Logs VALUES ('1');
INSERT INTO Logs VALUES ('2');
INSERT INTO Logs VALUES ('2');
*/

--select * from logs


-- method 1
/*
with t1 as
(
select *,
		row_number() over(order by num,id asc) as new_id,
		(id - row_number() over(order by num,id asc)) as id_diff
from logs
--order by num asc,id
)
select num,count(*) as n
from t1
where id_diff = 0
group by num
*/

-- method 2 
-- using lead and lag function

with t1 as(
select *,
		lead(num) over(order by id) as lead_num,
		lag(num) over(order by id) as lag_num
from logs
),
t2 as
(
select * from t1
where (num = lead_num or num = lag_num)
)
select num,count(*) as n
from t2
group by num