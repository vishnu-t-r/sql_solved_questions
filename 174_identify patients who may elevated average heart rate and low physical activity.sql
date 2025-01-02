use int_ques;

/*
Question
You are given a table, PatientActivity, with information about patients' daily activity and heart rate. 
Write a query to identify patients who may be at high risk due to an elevated average heart rate 
and low physical activity.

Conditions:

1) A high-risk patient is defined as someone whose average heart rate over the past 7 days is above 100.
2) They also need to have taken fewer than 4000 steps per day on average over the same period.

Write a query to return the patient_id of all high-risk patients based on the above criteria.
*/

/*
create table PatientActivity(
patient_id int,
on_date date,
steps int,
heart_rate int)

insert into PatientActivity(patient_id, on_date, steps,	heart_rate)
values(1	,'2024-10-01',	4500,	102),
(1	,'2024-10-02',	4800,	105),
(1	,'2024-10-03',	4700,	98),
(1	,'2024-10-04',	4600,	110),
(1	,'2024-10-05',	4300,	103),
(1	,'2024-10-06',	4200,	106),
(1	,'2024-10-07',	4400,	107),
(2	,'2024-10-01',	6000,	85),
(2	,'2024-10-02',	6100,	90),
(2	,'2024-10-03',	6200,	88),
(2	,'2024-10-04',	5800,	92),
(2	,'2024-10-05',	6000,	89),
(2	,'2024-10-06',	5900,	87),
(2	,'2024-10-07',	6050,	86),
(3	,'2024-10-01',	3000,	120),
(3	,'2024-10-02',	3100,	122),
(3	,'2024-10-03',	3200,	118),
(3	,'2024-10-04',	2900,	119),
(3	,'2024-10-05',	2800,	121),
(3	,'2024-10-06',	2700,	123),
(3	,'2024-10-07',	2600,	125),
(1	,'2024-10-08',	4500,	102),
(1	,'2024-10-09',	3500,	104),
(2	,'2024-10-08',	5500,	95),
(2	,'2024-10-09',	3500,	120),
(3	,'2024-10-08',	2700,	120),
(3	,'2024-10-09',	2600,	121)
*/



--select * from PatientActivity
--order by patient_id asc, on_date asc;

with patient_info as(
select patient_id,
		on_date,
		steps,
		heart_rate,
		avg(heart_rate) 
		over(partition by patient_id order by on_date asc rows between 6 preceding
		and current row) as seven_day_avg_hr,
		avg(steps)
		over(partition by patient_id order by on_date asc rows between 6 preceding
		and current row) as seven_day_avg_steps
from PatientActivity
)
select patient_id
from patient_info
where seven_day_avg_hr > 100
and seven_day_avg_steps < 4000
group by patient_id;