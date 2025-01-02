use int_ques;

/*
Question
We have to find the most expensive  (‘Exp_Product’) and the least expensive (‘Che_Product’) product 
of a particular category with every row of the table using ‘first_value’ and ‘last_value’ window functions.

Limitation :- There is a default frame that SQL uses with every window function. 
The default FRAME is a  ‘range between unbounded preceding and current row’.
It means that it specifies the range our window function is supposed to consider while applying that 
particular window function. And by default it considers all the rows preceding the current row 
and also the current row itself in a particular partition (mentioned in the OVER clause).
*/

/*
Create Table STATIONERY(
Category VARCHAR(20),
Brand VARCHAR(20),
Product_Name VARCHAR(20),
Price int,
Primary Key(Product_Name));

INSERT INTO STATIONERY VALUES('Pen','Alpha','Alpen',280),
('Pen','Fabre','Fapen',250),
('Pen','Camel','Capen',220),
('Board','Alpha','Alord',550),
('Board','Fabre','Faord',400),
('Board','Camel','Carod',250),
('Notebook','Alpha','Albook',250),
('Notebook','Fabre','Fabook',230),
('Notebook','Camel','Cabook',210);
*/

--select * from STATIONERY;
with product_info as(
select category,
		brand,
		product_name,
		price,
		first_value(product_name) 
			over(partition by category order by price desc) as exp_product,
		last_value(product_name)
			over(partition by category order by price desc) as che_product
from stationery
)
select distinct category, exp_product, che_product
from product_info;

/*
Why?

There is a default frame that SQL uses with every window function. 
The default FRAME is a  ‘range between unbounded preceding and current row’.
It means that it specifies the range our window function is supposed to consider while applying that 
particular window function. And by default it considers all the rows preceding the current row 
and also the current row itself in a particular partition.
*/

with product_info as(
select category,
		brand,
		product_name,
		price,
		first_value(product_name) 
			over(partition by category order by price desc
			range between unbounded preceding and unbounded following) as exp_product,
		last_value(product_name)
			over(partition by category order by price desc
			range between unbounded preceding and unbounded following) as che_product
from stationery
)
select distinct category, exp_product, che_product
from product_info;
