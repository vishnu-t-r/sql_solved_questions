--find the items which are frequently brought together?

--table
--'custorder'
/*
create table custorder(
orderid int,
customerid int,
productid varchar(100)
)
*/

--insert records

/*
insert into custorder(orderid,customerid,productid)
values(1111,1,'AAA'),
(1111,1,'BBB'),
(1111,1,'CCC'),
(2222,2,'AAA'),
(2222,2,'CCC'),
(3333,3,'BBB'),
(3333,3,'CCC'),
(4444,4,'AAA'),
(4444,4,'BBB'),
(4444,4,'CCC'),
(5555,5,'DDD'),
(5555,5,'AAA'),
(6666,6,'BBB'),
(6666,6,'CCC'),
*/


--SELECT * FROM CUSTORDER


--find the two items which are frequently brought together?

select o1.productid as product_1
		,o2.productid as product_2
		,count(1) as bought_together
from custorder o1
join custorder o2
on o1.orderid = o2.orderid
and o1.customerid = o2.customerid
and o1.productid < o2.productid
group by o1.productid,o2.productid
order by bought_together desc


--find the three items which are frequently bought together?

select o1.productid as product_1
		,o2.productid as product_2
		,o3.productid as product_3
		,count(1) as bought_together
from custorder o1
join custorder o2
on o1.orderid = o2.orderid
	and o1.customerid = o2.customerid
	--and o1.productid < o2.productid
join custorder o3
on o1.orderid = o3.orderid
	and o1.customerid = o3.customerid
	--and o1.productid < o3.productid
where o1.productid < o2.productid and o2.productid < o3.productid		
group by o1.productid,o2.productid,o3.productid
order by bought_together desc



