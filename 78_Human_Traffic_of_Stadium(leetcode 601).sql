--Write a solution to display the records with three or more rows with consecutive id's, 
--and the number of people is greater than or equal to 100 for each.
--Return the result table ordered by visit_date in ascending order.

use leetcode;

--LEETCODE 601

/*
create table stadium(
id int,
visit_date date,
people int
)

insert into stadium(id, visit_date, people)
values(1, '2020-01-01', 10),
(2, '2020-01-02', 109),
(3, '2020-01-03', 150),
(4, '2020-01-04', 99),
(5, '2020-01-05', 145),
(6, '2020-01-06', 1455),
(7, '2020-01-07', 199),
(8, '2020-01-09', 188)
*/

--visit_date is the column with unique values for this table.
--Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
--As the id increases, the date increases as well.


with t1 as(
select id, visit_date, people,
        row_number() over(order by id asc) as new_id,
        id - (row_number() over(order by id asc)) as diff
from stadium
where people >= 100
), t2 as
(
select id, visit_date, people, count(1) over(partition by diff)
 as new_part 
 from t1
)
select id, visit_date, people
from t2 
where new_part >= 3
