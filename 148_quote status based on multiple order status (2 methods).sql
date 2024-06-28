use sql_challenge;

/*
Question:- Order Status Table has three columns Quote_id, Order_id and Order_Status

When all Orders are in delivered status then Quote status should be 'Complete'.
When one or more Orders in delivered status then " In Delivery".
When One or more in Submitted status then "Awaiting for Submission" Else "Awaiting for Entry" by default
Note :- Order Priority should be Delivered, Submitted and Created

If one order is in delivered and other one is in Submitted then Quote_Status should be "In Delivery"
Similarly if one order is in Submitted and others in Created then the Quote_Status should be "Awaiting for
Submission"
*/

/*
create table order_status(quote_id varchar(5), order_id varchar(10), order_status varchar(20));

insert into order_status
values('A','A1','Delivered'),
('A','A2','Delivered'),
('A','A3','Delivered'),
('B','B1','Submitted'),
('B','B2','Delivered'),
('B','B3','Created'),
('C','C1','Submitted'),
('C','C2','Created'),
('C','C3','Submitted'),
('D','D1','Created')
*/

--select * from order_status;

--all delivered then 'complete'
--one or more in delivered status then 'in delivery'
--one or more in submitted status then 'awaiting for submission'
--by default 'awaiting of entry'

--Priority should be Delivered, Submitted and Created

--Method 1 (using row_number and dense_rank function)

with t1 as(
select quote_id,
		order_id,
		order_status,
		row_number() over(partition by quote_id
						order by (case when order_status = 'Delivered' then 1
										when order_status = 'Submitted' then 2
										when order_status = 'Created' then 3
										else 4 end) asc) as order_status_priority,
		dense_rank() over(partition by quote_id order by (case when order_status = 'Delivered' then 1
										when order_status = 'Submitted' then 2
										when order_status = 'Created' then 3
										else 4 end) desc) as distinct_order_status
from order_status
)
select quote_id,
		case when order_status = 'Delivered' and distinct_order_status = 1 then 'complete'
			when order_status = 'Delivered' and distinct_order_status <> 1 then 'in delivery'
			when order_status = 'Submitted' then 'awaiting for submission'
			else 'awaiting for entry' end as quote_status
from t1
where order_status_priority = 1


--Method 2 (using string agg and char index function)

with t2 as(
select distinct quote_id,order_status from order_status
), 
t3 as(
select quote_id,
		string_agg(order_status,',') within group(order by order_status) as order_status
from t2
group by quote_id
)
select quote_id,
		case when charindex('Delivered',order_status) = 1 and charindex(',',order_status) = 0 then 'complete'
			when charindex('Delivered',order_status) <> 0 and charindex(',',order_status) <> 0 then 'in delivery'
			when charindex('Delivered',order_status) = 0 and charindex('Submitted',order_status) <> 0 then 'awaiting for submission'
			else 'awaiting for entry' end as quote_status
from t3


--test charindex fucntion
--select CHARINDEX('t', 'Customer') AS MatchPosition;








