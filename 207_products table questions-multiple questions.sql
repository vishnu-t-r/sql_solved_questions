--SQL Challenge - Solve the following questions using Products table

--Question 1.
--Write a query to find the product(s) in each category that has the highest price within its category.

--Question 2.
--Write a query to list the names of products where the price is greater than the average price of all products.

--Question 3.
--Write a query to show the total stock quantity available for each category, 
--but only for those categories where total stock is greater than 100.

--Question 4.
--Write a query to find the second cheapest product across all categories.

--Question 5.
--Write a query to find the categories where the average price of products is greater than 200, 
--and show the category name along with its average price.

use questions;

/*
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);


INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity)
VALUES
(1, 'Wireless Mouse', 'Electronics', 25.50, 150),
(2, 'Office Chair', 'Furniture', 120.00, 80),
(3, 'Gaming Laptop', 'Electronics', 1500.00, 20),
(4, 'Standing Desk', 'Furniture', 350.00, 35),
(5, 'Bluetooth Speaker', 'Electronics', 75.00, 60),
(6, 'LED Monitor', 'Electronics', 220.00, 45),
(7, 'Bookshelf', 'Furniture', 200.00, 25),
(8, 'Noise Cancelling Headphones', 'Electronics', 180.00, 50),
(9, 'Recliner Sofa', 'Furniture', 800.00, 10),
(10, 'Smartphone', 'Electronics', 999.99, 30),
(11, 'Coffee Table', 'Furniture', 145.00, 40),
(12, 'Portable Hard Drive', 'Electronics', 89.99, 100),
(13, 'Electric Kettle', 'Home Appliances', 55.00, 70),
(14, 'Air Purifier', 'Home Appliances', 300.00, 20),
(15, 'Blender', 'Home Appliances', 65.00, 90);
*/


--Question 1.
--Write a query to find the product(s) in each category that has the highest price within its category.

select * from products;

with t1 as(
select *,
		max(price) over(partition by category) as highest_price
from products
)
select *
from t1
where price = highest_price;


--Question 2.
--Write a query to list the names of products where the price is greater than the average price of all products.

select * from products;

with t1 as(
select *, 
		avg(price) over() as avg_price
from products
)
select productname from t1
where price > avg_price;


--Question 3.
--Write a query to show the total stock quantity available for each category, 
--but only for those categories where total stock is greater than 200.

select * from products;

select category,
		sum(stockquantity) as total_stock
from products
group by category
having sum(stockquantity) > 200;

--Question 4.
--Write a query to find the highest priced product across all categories.

select * from products;

with t1 as(
select *,
		dense_rank() over(order by price desc) as flag
from products
)
select * from t1
where flag = 1;

--Question 5.
--Write a query to find the categories where the average price of products is greater than 200, 
--and show the category name along with its average price.

select * from products;

with t1 as(
select distinct category,
		avg(price) over(partition by category) as avg_price
from products
)
select * from t1
where avg_price > 200;