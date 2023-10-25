--create database accident_analysis

use accident_analysis;

--select * from accident
--select * from vehicle

--Question 1
--How many accidents have occurred in urban areas versus rural areas?

select area, count(*) as accident_count
from accident
group by area

select (select count(*) from accident where area = 'Urban') as Urban_Accident,
		(select count(*) from accident where area = 'Rural') as Rural_Accident



--Question 2: 
--Which day of the week has the highest number of accidents?

select top 1 day,count(*) as accident_count
from accident
group by day 
order by accident_count desc


select top 1 DATENAME(weekday,date) as week_day ,count(*) as accident_count
from accident
group by DATENAME(weekday,date)
order by accident_count desc



--Question 3: 
--What is the average age of vehicles involved in accidents based on their type?

select vehicletype, avg(agevehicle) as n
from vehicle 
group by vehicletype

--ALTER TABLE Statement
--alter the datatype of vehicle age column
alter table vehicle
alter column agevehicle int;

with t1 as
(
select vehicletype, avg(agevehicle) as n
from vehicle 
group by vehicletype
)
select * from vehicle 
where vehicletype in (select vehicletype from t1 where n is null)--'Van / Goods 3.5 tonnes'--'Tram'
order by vehicletype

select vehicletype, avg(isnull(agevehicle,0)) as avg_vehicle_age
from vehicle 
group by vehicletype



--Question 4: 
--Can we identify any trends in accidents based on the age of vehicles involved?


--compare the age of vehicle involved and number of accidents
--consider as a hisogram

select * from accident
select * from vehicle

select isnull(agevehicle,0) as vehicle_age, count(*) as accident_count
from vehicle
group by agevehicle
order by agevehicle asc





--Question 5: 
--Are there any specific weather conditions that contribute to severe accidents?
--severe accidents are accidents which belongs to 'fatal' and 'serious' severity

select * from accident
select * from vehicle

select weatherconditions, count(*) as accident_count
from accident
group by weatherconditions
order by accident_count desc


with t1 as (
select weatherconditions,severity, count(*) as accident_count
from accident
group by weatherconditions, severity
--order by accident_count, severity desc
),
t2 as
(
select * from 
(select * from t1) t
pivot (sum(accident_count)
	for severity in ([Fatal],[Serious],[Slight]))as b
)
select t2.*,
	(isnull(fatal,0)+isnull(serious,0)) as severe_accidents
from t2

--select distinct severity from accident




--Question 6: 
--Do accidents often involve impacts on the left-hand side of vehicles?


select * from accident
select * from vehicle

with t1 as
(
select lefthand, count(*) as accident_count from vehicle
where lefthand is not null
group by lefthand
)
select t1.*,
		round((convert(float,(t1.accident_count))*100/sum(accident_count) over()),2) as total
from t1


--Question 7: 
--Are there any relationships between journey purposes and the severity of accidents?

select * from accident
select * from vehicle

select * from
(
select a.severity,
		v.journeypurpose,
		count(a.accidentindex) as accident_count
from accident a
left join
vehicle v on a.accidentindex = v.accidentindex
group by a.severity,
		v.journeypurpose
) a
pivot (sum(accident_count)
	for severity in ([Fatal],[Serious],[Slight])
	)as b




--Question 8: 
--create a stored procedure to Calculate the average age of vehicles involved in accidents , 
--considering light conditions and point of impact as two varibale/inputs:


select * from accident
select * from vehicle

/*
-- example test procedure created
create procedure test_procedure
as
begin
select top 10 * from vehicle
order by agevehicle desc
end 

exec test_procedure
*/

create procedure vehicle_average_age
(@lightcondition varchar(100) = 'Daylight',
@pointofimpact varchar(100) = 'Offside')
as
begin

select avg(agevehicle)
from vehicle v
join accident a
on v.accidentindex = a.accidentindex
where v.pointimpact = @pointofimpact
and a.lightconditions = @lightcondition

end

/*
select * --distinct lightconditions
from accident
*/


exec vehicle_average_age 
exec vehicle_average_age 'Daylight','Offside'
exec vehicle_average_age 'Daylight'--,'Offside'

--another solution version
/*
DECLARE @Impact varchar(100)
DECLARE @Light varchar(100)
SET @Impact = 'Offside' --Did not impact, Nearside, Front, Offside, Back
SET @Light = 'Darkness' --Daylight, Darkness

SELECT 
	A.[LightConditions], 
	V.[PointImpact], 
	AVG(V.[AgeVehicle]) AS 'Average Vehicle Year'
FROM 
	[dbo].[accident] A
JOIN 
	[dbo].[vehicle] V ON A.[AccidentIndex] = V.[AccidentIndex]
GROUP BY 
	V.[PointImpact], A.[LightConditions]
HAVING 
	V.[PointImpact] = @Impact AND A.[LightConditions] = @Light;

*/