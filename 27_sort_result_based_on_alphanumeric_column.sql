--sorting alphanumeric data?

--table
--keyid 

/*
create table keyid(id varchar(250))

insert into keyid(id)
values('1'),
('10'),('2'),('21'),('210'),('Alpha1'),('Alpha11')

*/

select * from keyid
order by id desc	

--Return the position of a pattern in a string:
--PATINDEX(%pattern%, string)

--Required. 
--The pattern to find. It MUST be surrounded by %. Other wildcards can be used in pattern, such as:
--% - Match any string of any length (including 0 length)
--_ - Match one single character
--[] - Match any characters in the brackets, e.g. [xyz]
--[^] - Match any character not in the brackets, e.g. [^xyz]

--logic
--create two columns seperately for id (splittin numeric and alphabetical part)
--sort based on the two columns
select *
		--,left(id,(PATINDEX('%[0-9]%',id)-1)) as string
		--,substring(id,PATINDEX('%[0-9]%',id),len(id)) as num
from keyid
order by
left(id,(PATINDEX('%[0-9]%',id)-1))
		,convert(int,substring(id,PATINDEX('%[0-9]%',id),len(id)))

