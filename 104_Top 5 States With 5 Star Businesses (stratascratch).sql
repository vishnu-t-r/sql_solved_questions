--Top 5 States With 5 Star Businesses

/*
Find the top 5 states with the most 5 star businesses.
Output the state name along with the number of 5-star businesses and 
order records by the number of 5-star businesses in descending order. 
In case there are ties in the number of businesses, return all the unique states. 
If two states have the same result, sort them in alphabetical order.
*/

https://platform.stratascratch.com/coding/10046-top-5-states-with-5-star-businesses?code_type=5

with t1 as
(
select state, count(distinct business_id) as  n_businesses
from yelp_business
where stars = 5
--and is_open = 1
group by state
), t2 as
(select state, n_businesses, rank() over(order by n_businesses desc) as rnk
from t1
)
select state, n_businesses
from t2
where rnk <= 5
order by rnk asc,state asc