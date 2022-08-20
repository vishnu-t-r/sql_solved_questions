--1.Calculate the average rating given by students to each teacher for each session created. 
--Also, provide the batch name for which session was conducted.
/*
SELECT --teacher
		teacher_name
		--,batch
		,batch_name
		,session_id
		--,session_id_2
		,AVG(rating) as avg_rating
FROM
(
SELECT users.id as teacher
		,users.name as teacher_name
		--,instructor_batch_maps.batch_id as batch
		,batches.name as batch_name
		,sessions.id as session_id
		--,attendances.session_id as session_id_2
		,attendances.rating as rating

FROM users
INNER JOIN
sessions 
ON users.id = sessions.conducted_by
	--AND instructor_batch_maps.batch_id = sessions.batch_id
LEFT JOIN
attendances 
ON sessions.id = attendances.session_id
LEFT JOIN
batches
ON sessions.batch_id = batches.id
) c

GROUP BY --teacher
		teacher_name
		--,batch
		,batch_name
		,session_id

ORDER BY session_id
	

	*/

--2.Find the attendance percentage  for each session for each batch.
--Also mention the batch name and users name who has conduct that session


/*

WITH T1 AS
--active students
(
SELECT user_id as student_id
		,batch_id as batch_id
		,active as active
FROM 
student_batch_maps
WHERE active = 'True'
),
T2 AS
(
SELECT id as session_id
		,conducted_by as teacher_id
		,batch_id as batch_id
FROM
sessions
--WHERE batch_id IN (SELECT id as batch_id
					--FROM batches
					--WHERE active = 'True'
					--)
),
T3 AS 
(SELECT T1.student_id
		,T1.active
		,T1.batch_id as batch_id_t1
		,T2.batch_id as batch_id_t2
		,T2.session_id
		,T2.teacher_id		
FROM T1
INNER JOIN
T2
ON T1.batch_id = T2.batch_id
),
T4 AS 
(
SELECT 
		session_id
		,batch_id_t1
		,teacher_id
		,count(student_id) as total_students
FROM T3
GROUP BY session_id
		,batch_id_t1
		,teacher_id
),
T5 AS 
(
SELECT session_id,batch_id,teacher_id,count(student_id) as total_attendance
FROM
(
select e.student_id,e.session_id,e.batch_id,e.conducted_by as teacher_id
from
(
select c.student_id,c.session_id,d.batch_id,d.conducted_by from 
attendances c
join
sessions d
on c.session_id = d.id
) e
left join
(
select a.user_id as user_id,a.batch_id as active_batch,b.batch_id as inactive_batch
from
(select user_id,batch_id
from student_batch_maps as active
where active = 'True')a
join
(
select user_id,batch_id
from student_batch_maps as inactive
where active = 'False')b
on a.user_id = b.user_id
) f
on e.student_id = f.user_id
and e.batch_id = f.inactive_batch
where f.user_id is null and f.inactive_batch is null

) A
GROUP BY session_id,batch_id,teacher_id
)
SELECT T4.session_id
		,T4.batch_id_t1
		,T4.teacher_id
		,T5.total_attendance
		,T4.total_students
		,round((cast(T5.total_attendance as decimal)/cast(T4.total_students as decimal))* 100,2,1) AS attendance_percent
FROM T4
JOIN
T5 ON T4.session_id = T5.session_id
		AND T4.batch_id_t1 = T5.batch_id
		AND T4.teacher_id = T5.teacher_id

*/

--3.What is the average marks scored by each student in all the tests the student had appeared?


/*
with t1 as 
(
select a.test_id as test_id,a.user_id as student, a.score as score, b.total_mark as total
		,cast(a.score as decimal)/cast(b.total_mark as decimal)*100 as score_100
from
test_scores a
left join
tests b
on a.test_id = b.id
)

select student,count(student) as test_taken_by_stud,round(sum(score_100)/count(student),2,1) as avg_marks
from t1
group by student



*/

--4.A student is passed when he scores 40 percent of total marks in a test.
--Find out how many students passed in each test. Also mention the batch name for that test.


/*
with t1 as 
(
select a.test_id as test_id,b.batch_id,c.name as batch_name--, a.score as score
		,cast(a.score as decimal)/cast(b.total_mark as decimal)*100 as score_100
from
test_scores a
left join
tests b
on a.test_id = b.id
left join
batches c
on b.batch_id = c.id
),
t2 as 
(
select batch_name,test_id,batch_id,score_100,case when score_100 >= 40 then 'Pass'
							when score_100 < 40 then 'Fail'
							end as Pass_Fail
from t1
where score_100 >= 40
)
select test_id,batch_id,batch_name,count(1) as students_passed
from t2
group by test_id,batch_id,batch_name
order by test_id

*/

/*
select ts.test_id, b.name as batch, count(1) as students_passed
from tests t
left join test_scores ts on t.id = ts.test_id
--join users u on u.id = ts.user_id
join batches b on b.id = t.batch_id
where ((cast(ts.score as decimal)/cast(t.total_mark as decimal))*100) >= 40
group by ts.test_id,b.name
order by 1;
*/

--5.A student can be transferred from one batch to another batch. If he is transferred from batch a to batch b. 
--batch b’s active=true and batch a’s active=false in student_batch_maps.
--At a time, one student can be active in one batch only. One Student can not be transferred more than four times. 
--Calculate each students attendance percentage for all the sessions created for his past batch. 
--Consider only those sessions for which he was active in that past batch.

/*
with t1 as
(
select a.user_id as student_id,a.batch_id,b.id as session_id
from 
student_batch_maps a
left join
sessions b
on a.batch_id = b.batch_id
where a.active = 'False'
),
t2 as
(
select student_id,count(1) as session_attended
from
(select c.student_id,d.batch_id,d.session_id
from attendances c
inner join
t1 d
on c.student_id = d.student_id
and c.session_id = d.session_id
) e
group by student_id
),
t3 as
(
select student_id,count(1) as total_session
from t1 
group by student_id
)
select t3.student_id,isnull(t2.session_attended,0) as attendance
			,t3.total_session
			,cast(isnull(t2.session_attended,0) as decimal)/cast(t3.total_session as decimal)*100 as attendance_percent
from t3
left join
t2
on t3.student_id = t2.student_id

*/

--6. What is the average percentage of marks scored by each student in all the tests the student had appeared?

/*
select student,student_name
		,avg(percent_100) as avg_percent--over(partition by student) as avg_percent
from
(
select a.test_id, a.user_id as student, a.score, b.total_mark,u.name as student_name
		,(cast(a.score as decimal)/cast(b.total_mark as decimal))*100 as percent_100
from
test_scores a
left join
tests b on a.test_id = b.id
left join 
users u on a.user_id = u.id
) c
group by student,student_name
order by student_name

*/



--7. A student is passed when he scores 40 percent of total marks in a test. 
--Find out how many percentage of students have passed in each test. Also mention the batch name for that test.

/*
with t1 as 
(
select ts.test_id,ts.user_id,ts.score,t.batch_id,t.total_mark
		,(cast(ts.score as decimal)/cast(t.total_mark as decimal))*100 as percent_score
from test_scores ts
left join
tests t on ts.test_id = t.id
),
t2 as
(
select test_id,batch_id
		,count(1) as attended, count(case when percent_score >= 40 then 1
									end) as passed
from t1
group by test_id,batch_id
)
select t.test_id--,t.batch_id
		,b.name as batch_name
		,(cast(passed as decimal)/cast(attended as decimal))*100 as pass_percentage
from t2 t
join
batches b on t.batch_id = b.id
order by 1

*/

--8. A student can be transferred from one batch to another batch. 
--If he is transferred from batch a to batch b. batch b’s active=true and batch a’s active=false in student_batch_maps.
--At a time, one student can be active in one batch only. One Student can not be transferred more than four times.
--Calculate each students attendance percentage for all the sessions.
with t1 as 
(
select sbm.user_id as student--,sbm.batch_id--,sbm.active
		--,s.id as session_id
		,count(1) as total_session
from student_batch_maps sbm
left join 
sessions s on sbm.batch_id = s.batch_id
where active = 'True'
group by sbm.user_id
),
t2 as
(
select c.student_id as student_id
		--,c.session_id,c.batch_id
		,count(1) as session_attended
from
(
select a.student_id,a.session_id,s.batch_id from 
attendances a
join
sessions s on a.session_id = s.id
) c
left join
(
select distinct user_id,batch_id from student_batch_maps
where active = 'False'
) d
on
c.student_id = d.user_id 
and 
c.batch_id = d.batch_id
where d.user_id is null
	and d.batch_id is null
group by c.student_id
)

select t1.student--,t1.total_session,isnull(t2.session_attended,0) as session_attended
		,(cast(isnull(t2.session_attended,0) as decimal)/cast(t1.total_session as decimal))*100 as student_attendance_percentage
from
t1 
left join
t2 on t1.student = t2.student_id


