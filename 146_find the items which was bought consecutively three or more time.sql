use sql_challenge;

/*
Find the items which was bought consecutively three or more time.
*/


/*
CREATE TABLE Items_Table (
    id INT PRIMARY KEY identity(1,1),
    item VARCHAR(50)
);

INSERT INTO Items_Table (item) VALUES
('Smartphone'),
('Laptop'),
('Table'),
('Chair'),
('Smartphone'),('Smartphone'),('Smartphone'),
('T-shirt'),('T-shirt'),('T-shirt'),
('Jeans'),
('Smartphone'),
('Table'),
('Jacket'),
('Laptop'),('Laptop'),('Laptop'),
('Chair'),('Chair'),('Chair'),
('Jeans'),
('Smartwatch'),
('Sofa'),('Sofa'),
('Tablet'),
('Jacket'),('Jacket'),('Jacket'),
('Shoes');
*/

--select * from items_table;
with t1 as(
select id,item,
		lag(item) over(order by id asc) lag_item,
		lead(item) over(order by id asc) lead_item
from items_table
)
select distinct item 
from t1
where lag_item = lead_item