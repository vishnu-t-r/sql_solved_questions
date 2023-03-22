--Write an SQL query to report the students (student_id, student_name) being “quiet” in ALL exams.
--A “quite” student is the one who took at least one exam and didn’t score neither the high score nor the low score.

/*
create table student(
student_id int,
student_name varchar(100)
)

create table exam(
exam_id int,
student_id int,
score int
)
*/

/*
insert into student(student_id,student_name)
values(1,'George'),
(2,'Jade'),
(3,'Stella'),
(4,'Jonathan'),
(5,'Will')

insert into exam(exam_id,student_id,score)
values(10,1,70),
(10,2,80),
(10,3,90),
(20,1,80),
(30,1,70),
(30,3,80),
(30,4,90),
(40,1,60),
(40,2,70),
(40,4,80)

*/
--Write an SQL query to report the students (student_id, student_name) 
--being "quiet" in ALL exams.
--Don't return the student who has never taken any exam. Return the result 
--table ordered by student_id.

select * from student
select * from exam;

with t1 as
(
select e.*
		,s.student_name
from exam e
join student s
on e.student_id = s.student_id
--order by exam_id asc,student_id asc
),
t2 as
(
select *
		,max(score) over(partition by exam_id) as max_mark
		,min(score) over(partition by exam_id) as min_mark
from t1
)

select *--distinct student_name
from t2
where score <> max_mark and score <> min_mark



