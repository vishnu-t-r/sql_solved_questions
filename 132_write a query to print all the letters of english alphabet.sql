use sql_challenge;

--Question

/*
write a query to print all the letters of english alphabet
*/

select char(ascii('A'))
select ascii('Z')

with alphabet as(
select char(ascii('A')) as letter

union all

select char(ascii(letter)+1) as letter
from alphabet
where letter <> 'Z'
)
select * from alphabet
