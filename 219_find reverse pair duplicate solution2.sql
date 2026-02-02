use questions;

--Find reverse pair duplicate?

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

-- solution 2

select a.source, a.destination from travel as a
inner join travel as b
on a.source = b.destination and a.destination = b.source 
where a.source > b.source;