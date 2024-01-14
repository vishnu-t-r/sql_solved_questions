--Group Sold Products By The Date

use leetcode;

/*
+------------+------------+
| sell_date  | product     |
+------------+------------+
| 2020-05-30 | Headphone  |
| 2020-06-01 | Pencil     |
| 2020-06-02 | Mask       |
| 2020-05-30 | Basketball |
| 2020-06-01 | Bible      |
| 2020-06-02 | Mask       |
| 2020-05-30 | T-Shirt    |
+------------+------------+
*/

/*
create table activities(
sell_date date,
product varchar(100)
)

insert into activities(sell_date, product)
values('2020-05-30','Headphone'),
('2020-06-01','Pencil'),
('2020-06-02','Mask'),
('2020-05-30','Basketball'),
('2020-06-01','Bible'),
('2020-06-02','Mask'),
('2020-05-30','T-Shirt'),
('2020-05-30','T-Shirt')
*/


select * from activities

--Question ?
	--Write a solution to find for each date the number of different products sold and their names.



select sell_date,
		count(product) as products_sold,
		string_agg(product,',') as products
from
(select distinct * from activities)a
group by sell_date