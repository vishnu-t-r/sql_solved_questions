--use in operator to filter data based on a list of values

--Retrieve all customers who have placed an order
--select * from orders
--select * from CUSTOMERS

select * from customers
where order_id in (select distinct id from orders)


--use exists operator for checking existence

--Retrieve all customers who have placed an order
select * from customers
where exists (select * from orders
				where orders.id = customers.order_id)