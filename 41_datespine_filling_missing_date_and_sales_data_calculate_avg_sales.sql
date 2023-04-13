--datespine
--select * from datespine
with t1 as
(
select datediff(day,min(sales_date),max(sales_date))+1 as total_day
		,min(sales_date) as firstday
from datespine
),
t2 as
(
select distinct product
from datespine
),
t3 as
(
select row_number() over(order by (select null)) as rownumber
from datespine as a
cross join
datespine as b--sys.objects
),
t4 as
(
select *
		,dateadd(day,(t3.rownumber-1),t1.firstday) as all_day
from t3,t1,t2
where rownumber <= t1.total_day
)

select t4.all_day as sales_date
		,t4.product
		,isnull(ds.sales,0) as sales
from t4
left join
datespine ds
on t4.product = ds.product
and t4.all_day = ds.sales_date