use questions;

--reverse pair duplicate?

/*
-- Create the Table
CREATE TABLE travel (
    source VARCHAR(50),
    destination VARCHAR(50),
);

-- Insert Sample Data
INSERT INTO travel (Source, Destination)
VALUES 
('Delhi', 'Mumbai'),
('Mumbai', 'Delhi'),
('New York', 'London'),
('London', 'New York'),
('Paris', 'Tokyo'),
('Chicago', 'Denver'); -- Non-paired entry
*/

-- select * from travel;

-- solution 1
select distinct 
		case when source > destination then source else destination end as Source,
		case when source < destination then source else destination end as Destination
from travel;