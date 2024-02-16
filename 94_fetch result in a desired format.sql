use int_ques;

/*
create table sales_data
    (
        sales_date      date,
        customer_id     varchar(30),
        amount          varchar(30)
    );
insert into sales_data values ('01-Jan-2021', 'Cust-1', '50$');
insert into sales_data values ('02-Jan-2021', 'Cust-1', '50$');
insert into sales_data values ('03-Jan-2021', 'Cust-1', '50$');
insert into sales_data values ('01-Jan-2021', 'Cust-2', '100$');
insert into sales_data values ('02-Jan-2021', 'Cust-2', '100$');
insert into sales_data values ('03-Jan-2021', 'Cust-2', '100$');
insert into sales_data values ('01-Feb-2021', 'Cust-2', '-100$');
insert into sales_data values ('02-Feb-2021', 'Cust-2', '-100$');
insert into sales_data values ('03-Feb-2021', 'Cust-2', '-100$');
insert into sales_data values ('01-Mar-2021', 'Cust-3', '1$');
insert into sales_data values ('01-Apr-2021', 'Cust-3', '1$');
insert into sales_data values ('01-May-2021', 'Cust-3', '1$');
insert into sales_data values ('01-Jun-2021', 'Cust-3', '1$');
insert into sales_data values ('01-Jul-2021', 'Cust-3', '-1$');
insert into sales_data values ('01-Aug-2021', 'Cust-3', '-1$');
insert into sales_data values ('01-Sep-2021', 'Cust-3', '-1$');
insert into sales_data values ('01-Oct-2021', 'Cust-3', '-1$');
insert into sales_data values ('01-Nov-2021', 'Cust-3', '-1$');
insert into sales_data values ('01-Dec-2021', 'Cust-3', '-1$');
*/


--select * from sales_data;

with cte1 as
(
select month(sales_date) as mnth,
		customer_id,
		sum(cast(left(amount,len(amount)-1) as float)) as amount
from sales_data
group by month(sales_date),
		customer_id
),
cte2 as
(
select * from cte1
pivot ( sum(amount) for 
		mnth in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
		) as pivot_result
),
result1 as
(
select cte2.customer_id,
		cast(coalesce(cte2.[1],0) as varchar(max)) as [1],
		cast(coalesce(cte2.[2],0) as varchar(max)) as [2],
		cast(coalesce(cte2.[3],0) as varchar(max)) as [3],
		cast(coalesce(cte2.[4],0) as varchar(max)) as [4],
		cast(coalesce(cte2.[5],0) as varchar(max)) as [5],
		cast(coalesce(cte2.[6],0) as varchar(max)) as [6],
		cast(coalesce(cte2.[7],0) as varchar(max)) as [7],
		cast(coalesce(cte2.[8],0) as varchar(max)) as [8],
		cast(coalesce(cte2.[9],0) as varchar(max)) as [9],
		cast(coalesce(cte2.[10],0) as varchar(max)) as [10],
		cast(coalesce(cte2.[11],0) as varchar(max)) as [11],
		cast(coalesce(cte2.[12],0) as varchar(max)) as [12],
		cast((coalesce([1],0)+coalesce([2],0)
		+coalesce([3],0)+coalesce([4],0)
		+coalesce([5],0)+coalesce([6],0)
		+coalesce([7],0)+coalesce([8],0)
		+coalesce([9],0)+coalesce([10],0)
		+coalesce([11],0)+coalesce([12],0)) as varchar(max)) as Total
from cte2
),
result2 as
(
select 'Total' as customer_id,
		cast(sum(coalesce([1],0)) as varchar(max)) as [1],
		cast(sum(coalesce([2],0)) as varchar(max)) as [2],
		cast(sum(coalesce([3],0)) as varchar(max)) as [3],
		cast(sum(coalesce([4],0)) as varchar(max)) as [4],
		cast(sum(coalesce([5],0)) as varchar(max)) as [5],
		cast(sum(coalesce([6],0)) as varchar(max)) as [6],
		cast(sum(coalesce([7],0)) as varchar(max)) as [7],
		cast(sum(coalesce([8],0)) as varchar(max)) as [8],
		cast(sum(coalesce([9],0)) as varchar(max)) as [9],
		cast(sum(coalesce([10],0)) as varchar(max)) as [10],
		cast(sum(coalesce([11],0)) as varchar(max)) as [11],
		cast(sum(coalesce([12],0)) as varchar(max)) as [12],
		' ' as Total	
from cte2
),
result3 as
(
select * from result1
union all
select * from result2
)
select customer_id,
		iif([1]<0,'('+cast(abs(cast([1] as int)) as varchar)+')'+'$',[1]+'$') as [Jan],
		iif([2]<0,'('+cast(abs(cast([2] as int)) as varchar)+')'+'$',[2]+'$') as [Feb],
		iif([3]<0,'('+cast(abs(cast([3] as int)) as varchar)+')'+'$',[3]+'$') as [Mar],
		iif([4]<0,'('+cast(abs(cast([4] as int)) as varchar)+')'+'$',[4]+'$') as [Apr],
		iif([5]<0,'('+cast(abs(cast([5] as int)) as varchar)+')'+'$',[5]+'$') as [May],
		iif([6]<0,'('+cast(abs(cast([6] as int)) as varchar)+')'+'$',[6]+'$') as [Jun],
		iif([7]<0,'('+cast(abs(cast([7] as int)) as varchar)+')'+'$',[7]+'$') as [Jul],
		iif([8]<0,'('+cast(abs(cast([8] as int)) as varchar)+')'+'$',[8]+'$') as [Aug],
		iif([9]<0,'('+cast(abs(cast([9] as int)) as varchar)+')'+'$',[9]+'$') as [Sep],
		iif([10]<0,'('+cast(abs(cast([10] as int)) as varchar)+')'+'$',[10]+'$') as [Oct],
		iif([11]<0,'('+cast(abs(cast([11] as int)) as varchar)+')'+'$',[11]+'$') as [Nov],
		iif([12]<0,'('+cast(abs(cast([12] as int)) as varchar)+')'+'$',[12]+'$') as [Dec],
		iif([Total] = ' ',' ',iif([Total]<0,'('+cast(abs(cast([Total] as int)) as varchar)+')'+'$',[Total]+'$')) as [Total]
from result3;