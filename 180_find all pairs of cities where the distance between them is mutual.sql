use int_ques;

/*
Question-
Write a SQL query to find all pairs of cities where the distance between them is mutual 
(i.e., the distance from City A to City B is the same as from City B to City A).
*/


/*
CREATE TABLE Cities (
    CityID INT,
    CityName VARCHAR(50),
    NeighborCityID INT,
    Distance INT
);

INSERT INTO Cities (CityID, CityName, NeighborCityID, Distance) VALUES 
(1, 'New York', 2, 200),
(1, 'New York', 3, 300),
(2, 'Boston', 1, 200),
(2, 'Boston', 3, 150),
(3, 'Chicago', 1, 280),
(3, 'Chicago', 2, 150);
*/

--select * from cities;




/*
select src.cityname as src_city,
		dest.cityname as dest_city,
		src.distance as distance
from cities as src
left join (select distinct cityid, cityname from cities) 
as dest
on src.neighborcityid = dest.cityid
order by src.distance asc;
*/


select src.cityname as source_city,
		dest.cityname as destination_city,
		src.distance as distance
from cities as src
left join cities as dest
on src.neighborcityid = dest.cityid 
and src.cityid = dest.neighborcityid
where src.distance = dest.distance;





