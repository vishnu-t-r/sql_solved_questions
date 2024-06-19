use sql_challenge;

/*
Input :- Phone_Log Table has three columns namely Source_Phone_Nbr,
Destination_Phone_Nbr and Call_Start_DateTime. This table records all phone numbers
that we dial in a given day.
*/

/*
Question :- Write a SQL to display the Source_Phone_Nbr and a flag where
the flag needs to be set to 'Y' if first called number and last called number are the same and
'N' if first called number and last called number are different
*/

/*
create table phone_log(
source_phone_nbr int,
destination_phone_nbr int,
call_start_date_time datetime
)

insert into phone_log
values(2345,6789,'2099-07-01 10:00:00'),
(2345,1234,'2099-07-01 11:00:00'),
(2345,4567,'2099-07-01 12:00:00'),
(2345,4567,'2099-07-01 13:00:00'),
(2345,6789,'2099-07-01 15:00:00'),
(3311,7890,'2099-07-01 10:00:00'),
(3311,6543,'2099-07-01 12:00:00'),
(3311,1234,'2099-07-01 13:00:00')
*/

--select * from phone_log;
with t1 as
(
select source_phone_nbr,
		destination_phone_nbr,
		call_start_date_time,
		row_number() over(partition by source_phone_nbr order by call_start_date_time asc) as s_flag,
		row_number() over(partition by source_phone_nbr order by call_start_date_time desc) as e_flag
from phone_log
), t2 as(
select source_phone_nbr,
		max(case when s_flag = 1 then destination_phone_nbr end) as first_call,
		max(case when e_flag = 1 then destination_phone_nbr end) as last_call
from t1
group by source_phone_nbr
)
select source_phone_nbr,
		case when first_call = last_call then 'Y' 
			when first_call <> last_call then 'N' end as flag
from t2







