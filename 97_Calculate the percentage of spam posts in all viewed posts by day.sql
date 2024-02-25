use int_ques;

--Spam Posts

--Calculate the percentage of spam posts in all viewed posts by day. 
--A post is considered a spam if a string "spam" is inside keywords of the post. 
--Note that the facebook_posts table stores all posts posted by users. 
--The facebook_post_views table is an action table denoting if a user has viewed a post.

--facebook_posts, facebook_post_views
/*
create table facebook_posts(
post_id int,
posted_by int,
post_text varchar(max),
post_keywords varchar(max),
post_date datetime
)

insert into facebook_posts(post_id, posted_by,	post_text,	post_keywords,	post_date)
values(0,2,'The Lakers game from last night was great','[basketball,lakers,nba]','2019-01-01'),
(1,1,'Lebron James is top class','[basketball,lebron_james,nba]','2019-01-02'),
(2,2,'Asparagus tastes OK','[asparagus,food]','2019-01-01'),
(3,1,'Spaghetti is an Italian food','[spaghetti,food]','2019-01-02'),
(4,3,'User 3 is not sharing interests','[#spam#]','2019-01-01'),
(5,3,'User 3 posts SPAM content a lot','[#spam#]','2019-01-02')
*/

/*
create table facebook_post_views(
post_id int,
viewer_id int
)


insert into facebook_post_views(post_id, viewer_id)
values(4,0),
(4,1),
(4,2),
(5,0),
(5,1),
(5,2),
(3,1),
(3,2),
(3,3)
*/


--select * from facebook_posts;
--select * from facebook_post_views;

--Calculate the percentage of spam posts in all viewed posts by day

with t1 as
(
select * from facebook_posts
where post_id in (select distinct post_id from facebook_post_views)
)
select 
	post_date,
	sum(case when post_keywords like '%spam%' then 1 else 0 end) as spam_count,
	sum(1) as total_post,
	(sum(case when post_keywords like '%spam%' then 1 else 0 end)*1.0/sum(1)) * 100 as percent_spam
from t1
group by post_date