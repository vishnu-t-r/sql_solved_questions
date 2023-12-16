use leetcode;

--TRIPS table

--id is the primary key (column with unique values) for this table.
--The table holds all taxi trips. Each trip has a unique id, while client_id and driver_id are 
--foreign keys to the users_id at the Users table.
--Status is an ENUM (category) type of ('completed', 'cancelled_by_driver', 'cancelled_by_client').

--USERS table

--users_id is the primary key (column with unique values) for this table.
--The table holds all users. Each user has a unique users_id, and role is an ENUM type of ('client', 'driver', 'partner').
--banned is an ENUM (category) type of ('Yes', 'No').

--QUESTION ?

--The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users 
--by the total number of requests with unbanned users on that day.

--Write a solution to find the cancellation rate of requests with unbanned users 
--(both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". 
--Round Cancellation Rate to two decimal points.


/*
create table trips(
id int,
client_id int,
driver_id int,
city_id int,
status varchar(50),
request_at date
)

insert into trips(id, client_id, driver_id, city_id, status, request_at)
values( 1, 1, 10, 1,'completed','2013-10-01'),
( 2, 2, 11, 1,'cancelled_by_driver','2013-10-01'),
( 3, 3, 12, 6,'completed','2013-10-01'),
( 4, 4, 13, 6,'cancelled_by_client' ,'2013-10-01'),
( 5, 1, 10, 1,'completed','2013-10-02'),
( 6, 2, 11, 6,'completed','2013-10-02'),
( 7, 3, 12, 6,'completed','2013-10-02'),
( 8, 2, 12, 12,'completed','2013-10-03'),
( 9, 3, 10, 12,'completed','2013-10-03'),
( 10, 4, 13, 12,'cancelled_by_driver' ,'2013-10-03')

| id   | client_id | driver_id | city_id | status    | request_at |
| ---- | --------- | --------- | ------- | --------- | ---------- |
| 1111 | 1         | 10        | 1       | completed | 2013-10-01 |

truncate table trips

insert into trips(id, client_id, driver_id, city_id, status, request_at)
values(1111,1,10,1,'completed','2013-10-01')


create table users(
users_id int,
banned varchar(20),
role varchar(100)
)

insert into users(users_id, banned, role)
values(1, 'No', 'client'),
(2, 'Yes', 'client'),
(3, 'No', 'client'),
(4, 'No', 'client'),
(10, 'No', 'driver'),
(11, 'No', 'driver'),
(12, 'No', 'driver'),
(13, 'No', 'driver')

| users_id | banned | role   |
| -------- | ------ | ------ |
| 1        | No     | client |
| 10       | Yes    | driver |

truncate table users

insert into users(users_id, banned, role)
values(1,'No','client'),
(10,'Yes','driver')
*/


--select * from trips
--select * from users

with t1 as
(
select t.id, t.client_id, t.driver_id, t.city_id, t.status, t.request_at, u.*
from trips t left join
users u on t.client_id = u.users_id or t.driver_id = u.users_id
where t.client_id not in (select users_id from users where banned = 'Yes')
and t.driver_id not in (select users_id from users where banned = 'Yes')
and t.request_at >= '2013-10-01' and t.request_at <= '2013-10-03'
), t2 as
(
select request_at, count(distinct id) as total_trip_count
from t1
group by request_at
),
t3 as
(
select request_at, count(distinct id) as cancelled_trip_count
from t1
where banned = 'No' and role in ('client','driver')
and status in ('cancelled_by_driver', 'cancelled_by_client')
group by request_at
)
select t2.request_at as Day, isnull(round(cast(t3.cancelled_trip_count as float)/t2.total_trip_count,2),0) as [Cancellation Rate]
from t2 left join t3
on t2.request_at = t3.request_at


