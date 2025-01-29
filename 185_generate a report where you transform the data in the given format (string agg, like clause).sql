use int_ques;

/*
Task:
You need to generate a report where you transform the data into the following format:

CustomerName: List of customers who ordered products with "Organic" in the name.
Total Quantity Ordered: Total quantity ordered by each customer, but only for products that contain 
			the word "Juice" or "Butter" in their names (case-insensitive).
Product Names: Comma-separated list of product names, but only for products containing 
		"Organic" and "Juice" or "Butter".
*/

/*
CREATE TABLE retail_orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    ProductName VARCHAR(255),
    Quantity INT,
    OrderDate DATE
);

INSERT INTO retail_orders (OrderID, CustomerName, ProductName, Quantity, OrderDate) 
VALUES
(1, 'Alice Johnson', 'Organic Apple Juice', 5, '2024-11-01'),
(2, 'Bob Smith', 'Organic Almond Butter', 3, '2024-11-02'),
(3, 'Alice Johnson', 'Gluten-Free Brownie', 2, '2024-11-02'),
(4, 'Charlie Brown', 'Fresh Organic Lemonade', 6, '2024-11-02'),
(5, 'Alice Johnson', 'Organic Peanut Butter', 4, '2024-11-03'),
(6, 'Bob Smith', 'Organic Apple Juice', 1, '2024-11-03'),
(7, 'Charlie Brown', 'Dark Chocolate Cake', 3, '2024-11-04'),
(8, 'Alice Johnson', 'Organic Almond Milk', 8, '2024-11-05'),
(9, 'Bob Smith', 'Organic Orange Juice', 7, '2024-11-05'),
(10, 'Charlie Brown', 'Organic Almond Butter', 5, '2024-11-06');
*/

select customername,
		sum(quantity) as quantity,
		string_agg(productname, ',') as product_names
from retail_orders
where productname like '%Organic%' and (productname like '%Juice%' or productname like '%Butter%')
group by customername;