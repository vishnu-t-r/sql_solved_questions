--find the unique distance between source and destination?

/*
create table src_dest(
source varchar(255),
destination varchar(255),
distance int
)


insert into src_dest(source,destination,distance)
values('kannur','kozhikode',400),
('kozhikode','kannur',400),
('kollam','kochi',300),
('kochi','kollam',300),
('idukki','wyanad',500),
('wyanad','idukki',500)
*/

select * from
src_dest t1
join
src_dest t2
on t1.source = t2.destination and t1.destination = t2.source
--where t1.source > t1.destination