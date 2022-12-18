/*
There is a live production system with a table ("ORDERS") that captures order information in real-time. 
We wish to capture "deltas" from this table (inserts and deletes) by leveraging a nightly copy of the 
table. There are no timestamps that can be used for delta processing.
*/

--ORDER (TABLE at present)
/*
ORDER_ID (Primary key)
This table processes 10,000 transactions per day, including INSERTS, UPDATES, and DELETES. The 
DELETES are physical, so the records will no longer exist in the table.
Every day at 12:00AM, a snapshot (copy) of this table created and is an exact copy of the table at that 
time.
*/

--ORDER_COPY (TABLE copied from a previous timestamp)
/*
ORDER_ID (Primary key)
Requirement:
Write a query that (as efficiently as possible) will return only new INSERTS into ORDER since the 
snapshot was taken (record is in ORDER, but not ORDER_COPY) OR only new DELETES from ORDER since 
the snapshot was taken (record is in ORDER_COPY, but not ORDER).
The query should return the Primary Key (ORDER_ID) and a single character 
("INSERT_OR_DELETE_FLAG") of "I" if it is an INSERT, or "D" if it is a DELETE.
*/

--create a table orders
create table orders (
order_id int,
order_date date
)

insert into orders(order_id,order_date)
values(1,'10-11-2022'),
(2,'09-11-2022'),
(3,'08-11-2022'),
(4,'07-11-2022'),
(5,'06-11-2022'),
(6,'05-11-2022'),
(7,'03-11-2022')

--create table orders_copy
--taking the copy of orders to orders_copy
select * into orders_copy from orders

--insert new records to orders
insert into orders(order_id,order_date)
values(8,'02-11-2022'),
(9,'01-11-2022')

--delete records from orders table
delete from orders
where order_id in (1,2)

select * from orders
select * from orders_copy


--solution _1
--using exist
select order_id, 'I' as ind
from orders n
where not exists (select 1 from orders_copy o
					where n.order_id = o.order_id)

union all

select order_id, 'D' as ind
from orders_copy o
where not exists (select 1 from orders n
					where o.order_id = n.order_id)

--solution_2
--using except

select order_id, 'I' as ind
from orders
except
select order_id, 'I' as ind
from orders_copy

union all

select order_id, 'D' as ind
from orders_copy
except
select order_id, 'D' as ind
from orders

--solution_3
--using join

select coalesce(n.order_id, o.order_id) as order_id
		,case when o.order_id is null then 'I'
			when n.order_id is null then 'D'
			end as ind
from orders n
full outer join orders_copy o
on n.order_id = o.order_id
where o.order_id is null or n.order_id is null

drop table orders
drop table orders_copy

