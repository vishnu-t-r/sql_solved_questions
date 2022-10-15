--find the average dstance between the locations?
--solution 2

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



select --source,destination,
		case when source > destination then concat(source,'-',destination)
			else concat(destination,'-',source)
			end as unique_route,
		avg(distance) as average_distance
from locations
group by case when source > destination then concat(source,'-',destination)
			else concat(destination,'-',source)
			end --as unique_route