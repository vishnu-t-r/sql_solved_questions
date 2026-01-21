USE questions;

--Find the maximum number of viewers who were watching a specific live stream at the same time.
/*
-- Create the table
CREATE TABLE live_stream_viewers (
    user_id INT,
    start_time DATETIME,
    end_time DATETIME
);

-- Insert sample data
INSERT INTO live_stream_viewers (user_id, start_time, end_time) VALUES
(1, '2099-01-19 10:00:00', '2099-01-19 10:05:00'),
(2, '2099-01-19 10:03:00', '2099-01-19 10:08:00'),
(3, '2099-01-19 10:04:00', '2099-01-19 10:07:00'),
(4, '2099-01-19 10:06:00', '2099-01-19 10:10:00'),
(5, '2099-01-19 10:07:00', '2099-01-19 10:09:00');
*/

--select * from live_stream_viewers;

with event_log as(
select start_time as event_time,
			1 as indicator
from live_stream_viewers
union all
select end_time as event_time,
		-1 as indicator
from live_stream_viewers),
running_total as(
select event_time,
		sum(indicator) over(order by event_time asc, indicator desc) as current_viewers
from event_log)
select max(current_viewers) as peak_concurrent_viewers
from running_total;