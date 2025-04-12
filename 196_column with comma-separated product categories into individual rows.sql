
--E-commerce Data Transformation Question
/*
Question:
Transform a column with comma-separated product categories into individual rows for detailed analysis.
*/

--create database learn;

use learn;

/*
create table ecomm_orders(
order_id int primary key,
customer_name varchar(20),
product_categories varchar(255)
);

insert into ecomm_orders(order_id, customer_name, product_categories)
values(101,	'John Doe',	'Electronics, Home, Kitchen'),
(102,	'Jane Smith',	'Fashion, Beauty'),
(103,	'Mike Brown',	'Sports, Fitness, Outdoors')
*/

--select * from ecomm_orders;

select * from ecomm_orders cross apply string_split(product_categories,',');

select order_id,
		customer_name,
		product_categories,
		value as category
from ecomm_orders cross apply string_split(product_categories,',');


select * from 
string_split('The company leverages data analytics to identify customer trends and optimize marketing campaigns',' ');