use sql_challenge;

/*
Question :- A group of students participated in a course which has 4 subjects . 
In order to complete the course,  students must fulfill below criteria :-
   > Student should score at least 40 marks in each subject 
   > Student  must secure at least 50% marks overall (Assuming total 100)
Assuming 100 marks as the maximum achievable marks for a given subject. 
Write a SQL query to print the result for each student.
(Create a new result column with Pass/Fail status based on the mark obtained).
*/

/*
create Table Exam_Score
(
StudentId int,
SubjectID int,
Marks int
)

Insert Into Exam_Score values(101,1,60);
Insert Into Exam_Score values(101,2,71);
Insert Into Exam_Score values(101,3,65);
Insert Into Exam_Score values(101,4,60);
Insert Into Exam_Score values(102,1,40);
Insert Into Exam_Score values(102,2,55);
Insert Into Exam_Score values(102,3,64);
Insert Into Exam_Score values(102,4,50);
Insert Into Exam_Score values(103,1,45);
Insert Into Exam_Score values(103,2,39);
Insert Into Exam_Score values(103,3,60);
Insert Into Exam_Score values(103,4,65);
Insert Into Exam_Score values(104,1,83);
Insert Into Exam_Score values(104,2,77);
Insert Into Exam_Score values(104,3,91);
Insert Into Exam_Score values(104,4,74);
Insert Into Exam_Score values(105,1,83);
Insert Into Exam_Score values(105,2,77);
Insert Into Exam_Score values(105,4,74);
*/

--select * from exam_score;

--select distinct subjectID from exam_score;


with marks_cte as(
select studentid,
		isnull([1],0) as subject1,
		isnull([2],0) as subject2,
		isnull([3],0) as subject3,
		isnull([4],0) as subject4,
		isnull([1],0) + isnull([2],0) + isnull([3],0) + isnull([4],0) as total_marks
from 
(select studentid, subjectid, marks from exam_score) as base_table
pivot(
sum(marks) for subjectid in ([1],[2],[3],[4])
) as pivot_table
)
select *,
		case when (subject1 >= 40 and subject2 >= 40 and subject3 >= 40 and subject4 >= 40)
				and ((1.0*total_marks/400) >= 0.5) then 'pass'
			else 'fail' end as result
from marks_cte;

--simplified case statement
--greatest/least are two function in t-sql

/*
syntax:-
GREATEST ( expression1 [ ,...expressionN ] )
LEAST ( expression1 [ ,...expressionN ] )
*/

with marks_cte as(
select studentid,
		isnull([1],0) as subject1,
		isnull([2],0) as subject2,
		isnull([3],0) as subject3,
		isnull([4],0) as subject4,
		isnull([1],0) + isnull([2],0) + isnull([3],0) + isnull([4],0) as total_marks
from 
(select studentid, subjectid, marks from exam_score) as base_table
pivot(
sum(marks) for subjectid in ([1],[2],[3],[4])
) as pivot_table
)
select *,
		--used meast function to find the min mark
		case when least(subject1, subject2, subject3, subject4) >= 40
				and ((1.0*total_marks/400) >= 0.5) then 'pass'
			else 'fail' end as result
from marks_cte;