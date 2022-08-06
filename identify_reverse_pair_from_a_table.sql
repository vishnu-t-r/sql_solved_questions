--identify the reverse pair from the table reverse_pair?
--select distinct * from reverse_pair

--implemeted using self join
select 
		a.x,a.y
--,b.x,b.y 
from 
		reverse_pair a
join
		reverse_pair b
on
		a.x = b.y and b.x = a.y
where 
		a.x > a.y
