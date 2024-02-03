--What is the overall friend acceptance rate by date? 
--Your output should have the rate of acceptances by the date the request was sent. Order by the earliest date to latest.

--Assume that each friend request starts by a user sending (i.e., user_id_sender) a friend request to another user 
--(i.e., user_id_receiver) that's logged in the table with action = 'sent'. 
--If the request is accepted, the table logs action = 'accepted'. 
--If the request is not accepted, no record of action = 'accepted' is logged.

use questions;

/*
create table fb_friend_requests(
user_id_sender varchar(100),
user_id_receiver varchar(100),	
[date] date,
[action] varchar(100)
)

insert into fb_friend_requests(user_id_sender,user_id_receiver,[date],[action])
values('ad4943sdz','948ksx123d','2020-01-04','sent'),
('ad4943sdz','948ksx123d','2020-01-06','accepted'),
('dfdfxf9483','9djjjd9283','2020-01-04','sent'),
('dfdfxf9483','9djjjd9283','2020-01-15','accepted'),
('ffdfff4234234','lpjzjdi4949','2020-01-06','sent'),
('fffkfld9499','993lsldidif','2020-01-06','sent'),
('fffkfld9499','993lsldidif','2020-01-10','accepted'),
('fg503kdsdd','ofp049dkd','2020-01-04','sent'),
('fg503kdsdd','ofp049dkd','2020-01-10','accepted'),
('hh643dfert','847jfkf203','2020-01-04','sent'),
('r4gfgf2344','234ddr4545','2020-01-06','sent'),
('r4gfgf2344','234ddr4545','2020-01-11','accepted')

*/

select * from fb_friend_requests


with t1 as
(
select a.user_id_sender, 
		a.user_id_receiver,
		date_sent,
		date_accepted
from
(
select user_id_sender, 
		user_id_receiver,
		date as date_sent,
		action as sent
from fb_friend_requests
where action = 'sent'
) a
left join
(
select user_id_sender, 
		user_id_receiver,
		date as date_accepted,
		action as accepted
from fb_friend_requests
where action = 'accepted'
) b
on a.user_id_sender = b.user_id_sender 
	and a.user_id_receiver = b.user_id_receiver
--order by date_sent
)

select date_sent, (count(date_accepted)*1.0)/count(date_sent) as n
from t1
group by date_sent
