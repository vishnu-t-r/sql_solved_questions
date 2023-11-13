--Question ?

use int_ques;

/*
For all countries that have multiple rows in the country_continent table, 
delete all multiple records leaving only the 1 record per country in the master table. 
The record that you keep should be the first one when sorted by the continent_code alphabetically ascending.
*/


select * from country_continent
order by country




insert into new_temp_table
select country,
		continent
from
(
select cc.country,
		cc.continent,
		row_number() over(partition by country order by continent asc) as rw_number
from country_continent cc
) a
where rw_number = 1


create table new_temp_table(country varchar(50), continent varchar(50));


select * from new_temp_table;

delete from country_continent;

select * from country_continent;

insert into country_continent
select * from new_temp_table;

select * from country_continent;


