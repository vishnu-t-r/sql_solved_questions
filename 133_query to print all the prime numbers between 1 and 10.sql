use sql_challenge;

--write a sql query to print prime numbers in bewteen 1 and 10 ?

--Prime numbers are natural numbers that are divisible by only 1 and the number itself


with cte as
(
select 2 as prime_num

union all 

select (prime_num+1) as prime_num
from cte
where prime_num < 10
)
select t1.prime_num
from cte t1
where not exists (select 1 from cte t2
				where 1=1
				and t1.prime_num%t2.prime_num = 0
				--and t1.prime_num != t2.prime_num
				and t1.prime_num > t2.prime_num
				)








