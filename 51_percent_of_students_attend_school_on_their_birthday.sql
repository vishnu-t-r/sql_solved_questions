--all_students
--attendance_events

--Write SQL to find out what percent of students attend school on their birthday from attendance_events and all_students tables?

select * from all_students
select * from attendance_events


select count(*) as stud_count
from all_students

select count(student_id) as stud_count
from attendance_events


select convert(decimal(7,2),count(ae.student_id))/convert(decimal(7,2),(select count(distinct student_id) from attendance_events))*100 as atte_per
from attendance_events ae
join all_students stud
on ae.student_id = stud.student_id
and month(ae.date_event) = month(stud.date_of_birth)
and day(ae.date_event) =  day(stud.date_of_birth)
where ae.attendance = 'present'


/*
select (count(attendance_events.student_id) * 100 / (select count(student_id) from attendance_events)) as Percent_a
from attendance_events 
join all_students 
on all_students.student_id = attendance_events.student_id
where month(attendance_events.date_event) = month(all_students.date_of_birth)
and day(attendance_events.date_event) = day(all_students.date_of_birth);
*/