use int_ques;

--Number of Shipments Per Month
/*
Write a query that will calculate the number of shipments per month. 
The unique key for one shipment is a combination of shipment_id and sub_id. 
Output the year_month in format YYYY-MM and the number of shipments in that month.
*/

/*
create table amazon_shipment(
shipment_id int,
sub_id int,
weight int,
shipment_date date
)

insert into amazon_shipment(shipment_id, sub_id, weight, shipment_date)
values(101,	1,10,'2021-08-30'),
(101,2,20,'2021-09-01'),
(101,3,10,'2021-09-05'),
(102,1,50,'2021-09-02'),
(103,1,25,'2021-09-01'),
(103,2,30,'2021-09-02'),
(104,1,30,'2021-08-25'),
(104,2,10,'2021-08-26'),
(105,1,20,'2021-09-02')
*/

select * from amazon_shipment

--method 1

select concat(year(shipment_date),'-',month(shipment_date)) as year_month,
		count(distinct(concat(shipment_id,sub_id))) as shipment
from amazon_shipment
group by concat(year(shipment_date),'-',month(shipment_date))

--method 2

select convert(varchar(7),shipment_date,120) as year_month,
	count(distinct(concat(shipment_id,sub_id))) as shipment
from amazon_shipment
group by convert(varchar(7),shipment_date,120)

--convert function syntax
	--convert(to what data type, expression, style)