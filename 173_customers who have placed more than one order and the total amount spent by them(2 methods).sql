use int_ques;

/*
Question
Write a query to find the customers who have placed more than one order and the total amount spent by them.
*/

--Orders Table:
create table order_info(OrderID int,
CustomerID int,
OrderDate date,
Amount int)

insert into order_info(OrderID,	CustomerID,	OrderDate,	Amount)
values(1,	101,	'2099-01-10',	250),
(2,	102,	'2099-02-15',	450),
(3,	101,	'2099-03-12',	300),
(4,	103,	'2099-04-25',	500)

--Customers Table:
create table customer_info(
CustomerID int,
CustomerName varchar(20),	
Country varchar(20)
)

insert into customer_info(CustomerID,	CustomerName,	Country)
values(101,	'Alice',	'USA'),
(102,	'Bob',	'Canada'),
(103,	'Charlie',	'USA'),
(104,	'David',	'UK')

select * from order_info;
select * from customer_info;

--Solution 1
--Using HAVING with GROUP BY

select c.CustomerID, c.CustomerName,
		sum(o.amount) as total_amount
from customer_info c
left join order_info o
on c.CustomerID = o.CustomerID
group by c.CustomerID, c.CustomerName
having count(o.OrderID) > 1

--Solution 2
--Using a Subquery

select customerid,
		customername,
		total_amount
from
(
select c.CustomerID, c.CustomerName,
		count(o.OrderID) as order_count,
		sum(o.Amount) as total_amount
from customer_info c
left join order_info o
on c.CustomerID = o.CustomerID
group by c.CustomerID, c.CustomerName
) customer_order
where order_count > 1