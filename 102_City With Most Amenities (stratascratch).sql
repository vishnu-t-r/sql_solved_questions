--City With Most Amenities

/*
You're given a dataset of searches for properties on Airbnb. For simplicity, 
let's say that each search result (i.e., each row) represents a unique host. 
Find the city with the most amenities across all their host's properties. Output the name of the city.
*/

use int_ques;

--select * from airbnb_search_details;


with temp as
(select city, replace(replace(replace(amenities,'{',''),'}',''),'"','') as amenities
from airbnb_search_details
),
temp2 as
(select city, amenities, value
from temp
cross apply string_split(amenities,',')
)
select top 1 city
from temp2
group by city
order by count(*) desc

