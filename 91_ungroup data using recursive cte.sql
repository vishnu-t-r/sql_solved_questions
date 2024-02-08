use questions;

--ungroup data

/*
create table store_sales(
id int,
item varchar(50),
total_count int
)

insert into store_sales(id, item, total_count)
values(1,'pen',	2),
(2,'pencil',	1),
(3,'book',2),
(4,'umbrella',3)
*/

--select * from store_sales;

with r1 as
(
select id,item, total_count
from store_sales
--where item = 'pen'

union all

select id,item, (total_count-1) as total_count
from r1
where total_count > 1
)

select id, item--* 
from r1
order by id asc
