use questions;

--Question
/*
Analyze the frequency of rides during peak hours (7 AM to 10 AM and 5 PM to 8 PM) compared to non-peak hours.

Write a SQL query to calculate the total number of rides and the average fare during peak hours and non-peak hours. 
The result should display the time_period (either 'Peak Hours' or 'Non-Peak Hours'), total_rides, and average_fare.

Peak Hours:
Rides with ride_date times between 7 AM to 10 AM and 5 PM to 8 PM.
Non-Peak Hours:
Rides with ride_date times outside of those ranges.
*/

/*
create table rides(ride_id int,
ride_date datetime,
ride_distance decimal(10,2),
ride_fare decimal(10,2));

insert into rides(ride_id, ride_date, ride_distance, ride_fare)
values(1	,'2024-09-01 07:30:00',	5.2,	12.50),
(2	,'2024-09-01 09:15:00',	3.1,	8.00),
(3	,'2024-09-01 12:00:00',	10.0,	20.00),
(4	,'2024-09-01 18:45:00',	7.5,	15.75),
(5	,'2024-09-02 06:30:00',	4.0,	10.00),
(6	,'2024-09-02 19:30:00',	8.2,	18.00),
(7	,'2024-09-02 08:00:00',	6.0,	14.25),
(8	,'2024-09-02 22:00:00',	2.5,	7.50),
(9	,'2024-09-03 17:30:00',	5.0,	13.00),
(10	,'2024-09-03 15:45:00',	6.8,	16.25),
(11	,'2024-09-03 08:45:00',	3.8,	9.75),
(12	,'2024-09-03 05:15:00',	6.2,	13.50),
(13	,'2024-09-03 19:00:00',	7.1,	17.80),
(14	,'2024-09-04 07:15:00',	2.9,	6.25),
(15	,'2024-09-04 09:45:00',	4.5,	11.00),
(16	,'2024-09-04 20:30:00',	5.3,	14.00),
(17	,'2024-09-04 18:00:00',	3.0,	8.75),
(18	,'2024-09-05 08:30:00',	9.0,	22.50),
(19	,'2024-09-05 10:15:00',	7.7,	19.25),
(20	,'2024-09-05 17:15:00',	4.8,	12.75)
*/

--select * from rides;

with peak_or_non_peak as(
select *,
		datepart(hour,ride_date) as hr,
		case when (datepart(hour,ride_date) between 7 and 10) 
			or (datepart(hour,ride_date) between 17 and 20) then 'peak_hour'
			else 'non_peak_hour' end as time_period
from rides)
select time_period,
		count(ride_id) as ride_count,
		avg(ride_fare) as average_fare
from peak_or_non_peak
group by time_period;
