--select distinct * from stringlovsup
--find from the table which are the short_name in lower case, ideally it should have been in upper case?

---this wont give any result because of colation
select * from stringlovsup
where UPPER(short_name) != short_name

---change collation(to case sensitive -CS)
---by default server instance level collation was case insensitive(CI)
--here using query level collation
select * from stringlovsup
where UPPER(short_name) COLLATE Latin1_General_CS_AS != short_name

--collation ref
--https://www.javatpoint.com/sql-server-collation
--collation - Collation in SQL Server is a predefined set of rules that determine how data is saved, accessed, and compared.

--list of available collations
SELECT * FROM sys.fn_helpcollations();  

--get the SQL Server instance level collation
SELECT SERVERPROPERTY('collation') AS "Server collation";  

--Get the current database collation
SELECT name, collation_name AS "database collation" FROM sys.databases;  


--creating a database with collation specified
CREATE DATABASE collation_test COLLATE SQL_Latin1_General_CP1_CS_AS; 
