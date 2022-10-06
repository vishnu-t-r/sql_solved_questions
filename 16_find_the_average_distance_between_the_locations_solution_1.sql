--find the average dstance between the locations?

--locations table
/*
create table locations (
source varchar(255),
destination varchar(255),
distance int
)

insert into locations(source,destination,distance)
values('A','B',21)
,('B','A',28)
,('A','B',19)
,('C','D',15)
,('C','D',17)
,('D','C',16.5)
,('D','C',18)

*/


with cte as
(
select source,destination,sum(distance) as total,count(1) as no_of_routes 
		,row_number() over(order by source) as id
		from locations
group by source,destination
)
select t1.source,t1.destination,
		(t1.total + t2.total)/(t1.no_of_routes + t2.no_of_routes) as average_distance
from cte as t1
join cte as t2
on t1.source = t2.destination and t1.id < t2.id--t1.destination = t2.source


select --source,destination,
		case when source > destination then concat(source,'-',destination)
			else concat(destination,'-',source)
			end as unique_route,
		avg(distance) as average_distance
from locations
group by case when source > destination then concat(source,'-',destination)
			else concat(destination,'-',source)
			end --as unique_route





