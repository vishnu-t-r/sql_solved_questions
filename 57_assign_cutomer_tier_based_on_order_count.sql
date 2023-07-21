--using case statement for conditional logics

--assign a customer tier based on number of orders 
--(gold/silver/bronze)
--order_count >= 20 gold, order count between 10 and 19 silver, 0 to 9 bronze
select * from sample_superstore

select customer_id, 
		count(order_id) as order_count,
		case when count(order_id) >= 20 then 'gold'
				when count(order_id) < 20 and count(order_id) >= 10 then 'silver'
				when count(order_id) < 10 then 'bronze'
				end as customer_tier
from sample_superstore
group by customer_id
order by order_count desc