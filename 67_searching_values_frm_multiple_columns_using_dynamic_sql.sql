-- searching values from multiple columns


use int_ques;


/*
Create table text_table
(col1 varchar(50) null,
col2 varchar(50) null,
col3 varchar(50) null,
col4 varchar(50) null,
col5 varchar(50) null);


 
INSERT into text_table VALUES
('champion lh', 'champion kimi', 'fernando', 'champion seb', 'charles race')
,('','champ drive','race weekend','sprint weekend', 'sprint race');
*/

select * from text_table


-- manually entering the column names and finding the row in which the text is present
select * from text_table
where 'champ drive' in (col1, col2, col3, col4, col5)


select column_name
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'text_table'



-- this will not provide the output because 
-- select clause insdie the in statement will considered as a text
select * from text_table
where 'champ drive' in (select string_agg(column_name,',')
						from INFORMATION_SCHEMA.COLUMNS
						where TABLE_NAME = 'text_table'
						)

-- using dynamic sql to overcome this limiation
declare @sql nvarchar(500);
declare @col nvarchar(500);


set @col = (select string_agg(column_name,',') from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'text_table')
set @sql = 'select * from text_table where ''champ drive'' in ('+@col+')'



-- executing a dynamic sql query with exec()

exec(@sql);