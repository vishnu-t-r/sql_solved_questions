--Solving SQL Screening Interview questions

use questions;

/*
CREATE TABLE Order_Info (
    OrderID INT PRIMARY KEY,
    CustomerID VARCHAR(10),
    OrderDate DATE,
    Product VARCHAR(50),
    Quantity INT,
    Price DECIMAL(10, 2)
);

INSERT INTO Order_Info (OrderID, CustomerID, OrderDate, Product, Quantity, Price) VALUES
(101, 'C001', '2099-01-15', 'Laptop',    1, 1000.00),
(102, 'C002', '2099-01-16', 'Mouse',     2,   25.00),
(103, 'C001', '2099-01-20', 'Monitor',   1,  200.00),
(104, 'C003', '2099-01-22', 'Keyboard',  1,   45.00),
(105, 'C002', '2099-02-01', 'Laptop',    1,  950.00),
(106, 'C004', '2099-02-05', 'Mouse',     3,   20.00),
(107, 'C001', '2099-02-10', 'Laptop',    2,  980.00);
*/

select * from order_info;

--1.How many orders were placed in January 2099?

select count(distinct orderid) as order_count
from order_info
where month(orderdate) = 1
and year(orderdate) = 2099;


--2.Which customer placed the most number of orders?

select top 1 customerid, count(distinct orderid) as order_count
from order_info
group by customerid
order by order_count desc;

--3.What is the total revenue from all orders?
select sum(revenue) as total_revenue
from
(
select *,
		(quantity*price) as revenue
from order_info) a;

--4.Find the average price of 'Laptop' sold.

with t1 as
(
select *,
		(quantity * price) as revenue
from order_info
where product = 'Laptop'
)
select sum(revenue)/sum(quantity) as average_price
from t1;

--5.List customers who have ordered more than once.

select customerid, count(distinct orderid) as order_count 
from order_info
group by customerid
having count(distinct orderid) > 1;

--6.Which product generated the highest total revenue?
with t1 as(
select *, (quantity * price) as revenue
from order_info)
select top 1 product, sum(revenue) as total_revenue
from t1
group by product
order by total_revenue desc;


--7.Get the first order date for each customer.

select customerid,
		min(orderdate) as first_order_date
from order_info
group by customerid;

--8.Find the month-wise total revenue.

select concat(month(orderdate),'-', year(orderdate)) as month_year, sum(revenue) as total_revenue
from 
(select *, (quantity * price) as revenue
from order_info) a
group by concat(month(orderdate),'-', year(orderdate))

--9.Which customer spent the most overall?
with t1 as(
select *, (quantity * price) as revenue
from order_info
), t2 as(
select customerid, sum(revenue) as total_revenue
from t1
group by customerid
), t3 as(
select *,
		rank() over(order by total_revenue desc) as rank_revenue
from t2
)
select * from t3
where rank_revenue = 1;

--10.List the most frequently purchased product.

select top 1 product, sum(quantity) as total_quantity
from order_info
group by product
order by total_quantity desc;