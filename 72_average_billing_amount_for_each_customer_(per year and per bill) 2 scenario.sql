drop table billing;
create table billing
(
      customer_id               int
    , customer_name             varchar(1)
    , billing_id                varchar(5)
    , billing_creation_date     date
    , billed_amount             int
);

-- mm-dd-yyyy

/*
insert into billing values (1, 'A', 'id1', '10-10-2020', 100);
insert into billing values (1, 'A', 'id2', '11-11-2020', 150);
insert into billing values (1, 'A', 'id3', '11-12-2021', 100);
insert into billing values (2, 'B', 'id4', '11-10-2019', 150);
insert into billing values (2, 'B', 'id5', '11-11-2020', 200);
insert into billing values (2, 'B', 'id6', '11-12-2021', 250);
insert into billing values (3, 'C', 'id7', '01-01-2018', 100);
insert into billing values (3, 'C', 'id8', '01-05-2019', 250);
insert into billing values (3, 'C', 'id9', '01-06-2021', 300);
*/

select * from billing
/*
select billing_creation_date,
		month(billing_creation_date) as mo_nth,
		day(billing_creation_date) as da_y
from billing
*/

--Display average billing amount for each customer between 2019 to 2021, 
--assume $0 billing amount if nothing is billed for a particular year for that customer


--generate_series funcion will not work in this scenario because of the compactibility level below 160
/*
select value
from generate_series(2019, 2021, 1);
*/


--Scenario 1
-- found the average billing amount per year for a customer
with t1 as
(
select billing_year
from (
values
(2019),(2020),(2021)
)a (billing_year)
),
t2 as
(
select distinct customer_name from billing
where year(billing_creation_date) in (2019,2020,2021)
),
t3 as
(
select customer_name,year(billing_creation_date) as billing_year,
		sum(billed_amount) as amount
from billing
where year(billing_creation_date) in (2019,2020,2021)
group by customer_name,year(billing_creation_date)
),
t4 as
(
select a.billing_year,
		a.customer_name,
		isnull(t3.amount,0) as amount
from
(
select t1.billing_year,
		t2.customer_name
from t1,t2
) a
left join t3 on a.billing_year = t3.billing_year
		and a.customer_name = t3.customer_name
)
select  customer_name,
		avg(amount) as average_billing_amount
from t4
group by customer_name

--Scenario 2
--average billing amount per customer (ie average amount per bill)

with t1 as 
(
select billing_year
from (
values
(2019),(2020),(2021)
)a (billing_year)
),
t2 as
(
select distinct customer_name
from billing
),
t3 as
(
select billing_year, customer_name
from t1,t2
),
t4 as
(
select a.customer_name,
		a.billing_year,
		b.billed_amount
from
(select * from t3) a
left join 
(
select customer_name,
		year(billing_creation_date) as billing_year,
		billed_amount
from billing
) b
on a.billing_year = b.billing_year
	and a.customer_name = b.customer_name
)
select customer_name,
		avg(isnull(billed_amount,0)) as average_billed_amount
from t4
group by customer_name
order by customer_name