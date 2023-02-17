--select * from [dbo].[Sample_Superstore]

--without using context filter in tableau

with table1 as
(
select top 10 Product_Name
		,sum(Sales) as total_sales
from Sample_Superstore
group by Product_Name
order by total_sales desc
)
select distinct ss.Category,t1.Product_Name,t1.total_sales
from table1 t1
join Sample_Superstore ss
on t1.Product_Name = ss.Product_Name
where Category = 'Technology'
order by total_sales desc


--with using context filter

select top 10 Product_Name
		,sum(Sales) as total_sales
from Sample_Superstore
where Category = 'Technology'
group by Product_Name
order by total_sales desc