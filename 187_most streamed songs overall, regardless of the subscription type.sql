use int_ques;

/*
Write an SQL query to find the following:

The top 3 most streamed songs overall, regardless of the subscription type.
For each of these top 3 songs, calculate the percentage of streams that came from Free users and Premium users.
For each song, determine the most streamed subscription type (either 'Free' or 'Premium') 
based on the total number of streams.

Requirements:

1.The query should calculate the total number of streams for each song.
2.Calculate the percentage of streams that come from Free and Premium users.
3.Determine the most streamed subscription type for each song.
4.Sort the songs by total streams in descending order, and return only the top 3.
*/

/*
CREATE TABLE Song_Streams (
    stream_id INT PRIMARY KEY,
    song_id INT,
    song_name VARCHAR(255),
    artist_name VARCHAR(255),
    genre VARCHAR(100),
    user_id INT,
    subscription_type VARCHAR(50),
    stream_date DATE
);

-- Inserting sample data into Song_Streams
INSERT INTO Song_Streams (stream_id, song_id, song_name, artist_name, genre, user_id, subscription_type, stream_date) VALUES
(1, 1, 'Song A', 'Artist 1', 'Pop', 1, 'Premium', '2099-06-15'),
(2, 1, 'Song A', 'Artist 1', 'Pop', 2, 'Free', '2099-06-20'),
(3, 2, 'Song B', 'Artist 2', 'Rock', 3, 'Premium', '2099-07-01'),
(4, 3, 'Song C', 'Artist 1', 'Pop', 1, 'Free', '2099-07-10'),
(5, 1, 'Song A', 'Artist 1', 'Pop', 4, 'Free', '2099-08-05'),
(6, 2, 'Song B', 'Artist 2', 'Rock', 5, 'Premium', '2099-08-10'),
(7, 3, 'Song C', 'Artist 1', 'Pop', 2, 'Premium', '2099-08-15'),
(8, 1, 'Song A', 'Artist 1', 'Pop', 1, 'Premium', '2099-09-01'),
(9, 4, 'Song D', 'Artist 3', 'Jazz', 3, 'Free', '2099-09-01'),
(10, 2, 'Song B', 'Artist 2', 'Rock', 5, 'Free', '2099-09-05'),
(11, 5, 'Song E', 'Artist 2', 'Rock', 4, 'Premium', '2099-09-10'),
(12, 1, 'Song A', 'Artist 1', 'Pop', 2, 'Free', '2099-09-15'),
(13, 3, 'Song C', 'Artist 1', 'Pop', 3, 'Premium', '2099-09-20'),
(14, 4, 'Song D', 'Artist 3', 'Jazz', 1, 'Free', '2099-09-25'),
(15, 2, 'Song B', 'Artist 2', 'Rock', 1, 'Premium', '2099-09-30');
*/

--select * from Song_Streams;


with top_three as(
select top 3 song_id,
		count(stream_id) as stream_count
from song_streams
group by song_id
order by stream_count desc
), t2 as (
select song_id,
		sum(case when subscription_type = 'Premium' then 1 else 0 end) as pre_sub_count,
		sum(case when subscription_type = 'Free' then 1 else 0 end) as fre_sub_count,
		count(stream_id) as stream_count
from 
song_streams
where song_id in (select distinct song_id from top_three)
group by song_id
)
select song_id,
		cast((100.0*pre_sub_count/stream_count) as decimal(8,2)) as premium_percent,
		cast((100.0*fre_sub_count/stream_count) as decimal(8,2)) as fre_percent,
		case when pre_sub_count > fre_sub_count then 'Premium'
			when pre_sub_count < fre_sub_count then 'Free'
			else 'Both' end as most_streamed_sub,
			stream_count
from t2
order by stream_count desc;
