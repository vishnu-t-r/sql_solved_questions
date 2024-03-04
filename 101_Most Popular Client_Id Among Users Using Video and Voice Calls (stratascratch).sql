--The Most Popular Client_Id Among Users Using Video and Voice Calls

/*
Select the most popular client_id based on a count of the number of users 
who have at least 50% of their events from the following list: 
'video call received', 'video call sent', 'voice call received', 'voice call sent'.
*/

/*
(consider only the event_types mentioned, and sum of total users wrt a client_id should be > 50% of the total users
for all events mentioned in the list('video call received', 'video call sent', 'voice call received', 'voice call sent').
from those client_id, take the client_id at the top.
*/


use int_ques;

--select * from fact_events;

with t1 as
(select client_id, --count(event_id) as total_events,
    sum(iif(event_type in ('video call received', 'video call sent', 'voice call received', 'voice call sent'),1,0)) as specific_event_count
from fact_events
group by client_id
)
select top 1 client_id from t1
where specific_event_count > 0.5*(select sum(specific_event_count) from t1)