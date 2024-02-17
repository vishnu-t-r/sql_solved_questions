--Pizza delivery status

/*
a pizza company is taking orders from customers, and each pizza ordered to their database is added as seperate 
order. Each order has an associated status, 'CREATED', 'SUBMITTED' or 'DELIVERED'.
An orders final status is calculated based on the following condition:
	> when all orders from a customer have a status of DELIVERED, that customer's order has a final status of 'COMPLETED'.
	> if a customer has some orders that are not delivered and some orders that are delivered, the final status is 'IN PROGRESS'.
	> if all of a customers orders are submitted, the final status is 'AWAITING PROGRESS'.
	> otherwise the final status is 'AWAITING SUBMISSION'.

Question?

? Write a query to report the customer_name and final_status of each customer's order. 
Order the result by customer name.
*/


use int_ques;

/*
create table cust_orders
(
cust_name   varchar(50),
order_id    varchar(10),
status      varchar(50)
);

insert into cust_orders values ('John', 'J1', 'DELIVERED');
insert into cust_orders values ('John', 'J2', 'DELIVERED');
insert into cust_orders values ('David', 'D1', 'SUBMITTED');
insert into cust_orders values ('David', 'D2', 'DELIVERED');
insert into cust_orders values ('David', 'D3', 'CREATED');
insert into cust_orders values ('Smith', 'S1', 'SUBMITTED');
insert into cust_orders values ('Krish', 'K1', 'CREATED');
commit;

*/

select * from cust_orders;

with cust_status as
(
select cust_name, string_agg(status,',') as status
from (select distinct cust_name, status from cust_orders) a
group by cust_name
)

select cust_name,
		status,
		case when status = 'DELIVERED' then 'COMPLETED'
			when status = 'SUBMITTED' then 'AWAITING PROGRESS'
			when (status like '%DELIVERED%') and (status like '%CREATED%' or status like '%SUBMITTED%') then 'IN PROGRESS'
			else 'AWAITING SUBMISSION' end as order_status
from cust_status
order by cust_name asc