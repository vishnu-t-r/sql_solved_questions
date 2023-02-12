--select * from points


select min(distance) as short
from
(
select round(sqrt(power((p2.x-p1.x),2)+power((p2.y-p1.y),2)),2) as distance
from points p1
cross join points p2
where p1.x <> p2.x
or p1.y <> p2.y
) a