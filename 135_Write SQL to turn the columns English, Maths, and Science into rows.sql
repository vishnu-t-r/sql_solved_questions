use sql_challenge;

-- Question statements :- Write SQL to turn the columns English, Maths and Science
--into rows. It should display Marks for each student for each subjects in a single column.

/*
create table student_info(
StudentName varchar(20), 
English int, 
Maths int,
Science int)

insert into student_info(StudentName, English, Maths, Science)
values('David',85,90,88),
('John',75,85,80),
('Tom',83,80,92)
*/


--select * from  student_info;

--method 1
select * from
(select StudentName, English, Maths, Science
from  student_info) as p
unpivot (
Marks for Subjects in (English, Maths, Science)
) as upvt;

--method 2 ( small diff)
select StudentName, Subjects, Marks 
from
(select StudentName, English, Maths, Science
from  student_info) as p
unpivot (
Marks for Subjects in (English, Maths, Science)
) as upvt;


----method 3 ( using union all)

select StudentName, 'English' as Subject, English as Marks
from student_info
union all
select StudentName, 'Maths' as Subject, Maths as Marks
from student_info
union all
select StudentName, 'Science' as Subject, Science as Marks
from student_info
