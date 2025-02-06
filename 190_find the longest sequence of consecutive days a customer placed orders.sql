use int_ques;

/*
Question
table with CustomerID, OrderDate, and OrderID, 
how would you find the longest sequence of consecutive days a customer placed orders?
*/

/*
CREATE TABLE Customer_Order (
    CustomerID INT,
    OrderDate DATE,
    OrderID INT PRIMARY KEY
);

INSERT INTO Customer_Order (CustomerID, OrderDate, OrderID)
VALUES
(1, '2025-01-01', 101),
(1, '2025-01-02', 102),
(1, '2025-01-04', 103),
(1, '2025-01-05', 104),
(1, '2025-01-07', 105),
(2, '2025-01-01', 106),
(2, '2025-01-02', 107),
(2, '2025-01-03', 108),
(3, '2025-01-01', 109),
(3, '2025-01-03', 110);
*/

--select * from customer_order;

with t1 as(
select customerid,
		orderdate,
		orderid,
		row_number() over(partition by customerid order by orderdate asc) as id
from customer_order
), t2 as(
select customerid,
		orderdate,
		orderid,
		id,
		dateadd(day,-id,orderdate) as window
from t1), t3 as(
select customerid,
		window,
		count(orderid) as consecutive_orders
from t2
group by customerid,
		window
		)
select customerid,
		max(consecutive_orders) as max_consecutive_days
from t3
group by customerid;