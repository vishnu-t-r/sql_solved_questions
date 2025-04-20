--Given a table Sales that records transactions for an e-commerce platform

use questions;

/*
CREATE TABLE Ecomm_Sales (
    OrderID INT PRIMARY KEY,
    CustomerID VARCHAR(10) NOT NULL,
    OrderDate DATE NOT NULL,
    Product VARCHAR(100) NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    Price DECIMAL(10,2) CHECK (Price > 0),
    Discount DECIMAL(5,2) CHECK (Discount BETWEEN 0 AND 1),
    Category VARCHAR(50) NOT NULL
);

INSERT INTO Ecomm_Sales (OrderID, CustomerID, OrderDate, Product, Quantity, Price, Discount, Category)
VALUES 
    (101, 'C001', '2099-03-01', 'Laptop', 1, 800.00, 0.10, 'Electronics'),
    (102, 'C002', '2099-03-02', 'Phone', 2, 500.00, 0.05, 'Electronics'),
    (103, 'C003', '2099-03-03', 'Headphones', 3, 50.00, 0.00, 'Accessories'),
    (104, 'C001', '2099-03-04', 'Laptop', 1, 750.00, 0.15, 'Electronics'),
    (105, 'C004', '2099-03-05', 'Mouse', 4, 25.00, 0.10, 'Accessories');
*/

/*
Tasks:

1. Calculate the total revenue after applying discounts for each order.
	--Formula: Total Revenue = (Quantity * Price) * (1 - Discount)

2. Find the cumulative revenue generated over time.
	--Show revenue accumulated per order date.

3. Determine the most popular product category based on total quantity sold.

4. Identify repeat customers who have placed more than one order.

5. Pivot the data to show total quantity sold per category in a single row.
*/

--Task 1

select orderid,
		(Quantity * Price) * (1 - Discount) as Total_revenue
from ecomm_sales
order by Total_revenue desc;

--Task 2

select orderdate,
		sum((Quantity * Price) * (1 - Discount)) over(order by orderdate asc) as cummulative_revenue
from ecomm_sales;

--Task 3

select top 1 category, sum(quantity) as quantity_sold
from ecomm_sales
group by category
order by quantity_sold desc;

--Task 4

select customerid, count(orderid) as order_count 
from ecomm_sales
group by customerid
having count(orderid) > 1;

--Task 5

select  sum(case when category = 'Electronics' then quantity else 0 end) as Electronics,
		sum(case when category = 'Accessories' then quantity else 0 end) as Accessories
from ecomm_sales;

