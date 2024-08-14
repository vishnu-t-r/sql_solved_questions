use sql_challenge;

/*
Question:- Write a SQL query to calculate the percentage of results using the best of the five rule i.e. 
You must take the top five grades for each student and calculate the percentage.
*/

/*
create table Exam (
Id int,
English int,
Maths int,
Science int,
Geography int,
History int,
Sanskrit int)

Insert into Exam Values (1,85,99,92,86,86,99)
Insert into Exam Values (2,81,82,83,86,95,96)
Insert into Exam Values (3,76,55,76,76,56,76)
Insert into Exam Values (4,84,84,84,84,84,84)
Insert into Exam Values (5,83,99,45,88,75,90)
*/

--select * from exam;

with marks_cte as(
select id, marks, subjects from
(
	select * from exam
) as base_query
unpivot
(
	marks for subjects in (English,Maths,Science,Geography,History,Sanskrit)
) as pt
),
rank_cte as(
select id,
		subjects,
		marks,
		row_number() over(partition by id order by marks desc) as rnk
from marks_cte
),
percentage_cte as(
select id, cast(avg(1.0*marks) as decimal(10,2)) as percentage_top5 
from rank_cte
where rnk <= 5
group by id
)
select e.*,
		pc.percentage_top5 as Percentage
from exam e join percentage_cte pc
on e.id = pc.id