use int_ques;

/*
Question?
Solving the 80/20 Pareto rule

Find the 20 percent products that contribute to 80 percent of the sales?
*/


/*
CREATE TABLE walmart (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(50),
    Sales int
);



-- Insert data into the table
INSERT INTO walmart (ProductID, Name, Sales) VALUES
(1, 'Laptop', 7500),
(2, 'Smartphone', 6000),
(3, 'Furniture', 2500),
(4, 'Headphones', 800),
(5, 'Smartwatch', 700),
(6, 'Books', 500),
(7, 'Keyboard', 300),
(8, 'Bags', 200),
(9, 'Charger', 200),
(10, 'Toys', 100),
(11, 'Peronal Care', 100);
*/

--select * from walmart;

with percent_sales as(
select *,
		sum(sales) over(order by sales desc, productid asc) as cumulative_sales,
		sum(sales) over(partition by (select null)) as total,
		1.0*sales/sum(sales) over(partition by (select null)) as percent_sales
from walmart
),
cum_percent as(
select productid,
		name,
		cumulative_sales,
		percent_sales,
		(sum(percent_sales) over(order by percent_sales desc))*100 as cumulative_percent
from percent_sales
)
select * from cum_percent
where cumulative_percent <= 80;