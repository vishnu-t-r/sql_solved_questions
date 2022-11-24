/*
create table t_person(
id int not null,
name varchar(20),
dob date,
gender varchar(5)
)


insert into t_person(id,name,dob,gender)
values(1,'tom','1-1-2000','m'),
(2,'gary','1-1-2000','m'),
(1,'pam','1-1-2000','f')
*/

select * from t_person

--select * into t_person_new from t_person

select * from t_person_new

/*
update t_person_new
set gender = 'f'
where name = 'gary'

update t_person
set id = 3
where name = 'pam'
*/

--using exist
select id,name,dob,gender
from t_person_new tpn
where not exists (select 1
					from t_person tp
					where tp.id = tpn.id and tp.name = tpn.name and tp.dob = tpn.dob and tp.gender = tpn.gender)

--using except
select * from t_person_new
except
select * from t_person

--using join
select tpw.* from t_person_new tpw
left join t_person tp
on tpw.id = tp.id
and tpw.name = tp.name
and tpw.dob = tp.dob
and tpw.gender = tp.gender
where tp.id is null and tp.id is null and tp.dob is null and tp.gender is null