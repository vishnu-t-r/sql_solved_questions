use questions;

/*
The relationship between the LIFT and LIFT_PASSENGERS Table is such that multiple passengers 
can attempt to enter the same lift, 
but the total weight of the passengers in a lift cannot exceed the lift's capacity.

Write an SQL query that produces a comma separated list of passengers who can be accommodated 
in each lift without exceeding the lift's capacity. 
The passengers in the list should be ordered by their weight in increasing order
*/

/*
Create Table lift_passengers(
Passenger_Name Varchar(20),
Weight_Kg int,
Lift_Id int)

Insert into Lift_Passengers Values('Lewis',85,1)
Insert into Lift_Passengers Values('Anto',73,1)
Insert into Lift_Passengers Values('Danny',95,1)
Insert into Lift_Passengers Values('Mary',80,1)
Insert into Lift_Passengers Values('Raj',92,1)
Insert into Lift_Passengers Values('Mark',83,2)
Insert into Lift_Passengers Values('Robert',77,2)
Insert into Lift_Passengers Values('Maria',73,2)
Insert into Lift_Passengers Values('Susan',85,2)
Insert into Lift_Passengers Values('John',92,2)

Create Table Lift( Id int,
Capacity_Kg Bigint)

Insert into Lift Values(1,300)
Insert into Lift Values(2,350)
*/

select * from lift_passengers;
select * from lift;

with lift_cte as(
select *,
		sum(weight_kg) over(partition by lift_id order by weight_kg asc) as running_weight,
		case when (sum(weight_kg) over(partition by lift_id order by weight_kg asc)) > capacity_kg 
				then 1
				else 0 end as flag
from lift_passengers lp
left join lift l
on lp.lift_id = l.id
)
select lift_id, string_agg(passenger_name,',') within group (order by passenger_name asc) as passenger_list
from lift_cte
where flag <> 1
group by lift_id

