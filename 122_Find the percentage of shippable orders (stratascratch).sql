--Find the percentage of shipable orders

use int_ques;

/*
Find the percentage of shipable orders.
Consider an order is shipable if the customer's address is known.
*/

select * from orders
select * from customer

--select count(*) as n
--from orders

select cast((1.0*count(*)/(select count(*) from orders))*100 as int) as shipable_order_percent
from orders o left join
customer c on o.cust_id = c.id
where address <> ' '


