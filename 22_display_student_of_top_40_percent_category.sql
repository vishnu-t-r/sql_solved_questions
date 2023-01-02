--question 4
--Write SQL query to display the students of top 40% category.
--Marks achieved by students in the examination are tabulated below. 
--The report should retrieve students in the top 40% scoring category.

--table created
--student_marks

/*
create table student_marks(
studentid int not null,
student_name varchar(250),
marks int
)

insert into student_marks(studentid,student_name,marks)
values(10,'sam',480),
(1,'ram',520),
(2,'ravi',620),
(3,'abhi',600),
(4,'seetha',540),
(5,'geetha',515),
(6,'dhaya',520),
(7,'uma',500),
(8,'amin',510),
(9,'joseph',490)

*/

--select * from student_marks

--soltuion 1
/*
select a.StudentId,a.Student_Name,a.Marks
FROM
(
SELECT *
,COUNT(1) OVER (ORDER BY Marks DESC) AS test
FROM student_marks
)a
where test <= 4

*/

--solution 2
--using cume_dist function (output will be between 0 and 1)
--select * from student_marks

select studentid,
		student_name,
		marks
from(
select *,(cume_dist() over(order by marks desc))*100 as dist
from student_marks
) a
where dist <= 40
