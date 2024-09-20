-- PROBLEM STATEMENT:
-- DAY 2 (LIFT OVERLOADED PART 2) (PS-16)

-- You are given a table of list of lifts , 
-- their maximum capacity and people along with their weight and gender who wants to enter into it. 
-- You need to make sure maximum people enter into the lift without 
-- lift getting overloaded but you need to give preference to female passengers first.
-- For each lift find the comma separated list of people who can be accomodated. 
-- The comma separated list should have female first and 
-- then people in the order of their weight in increasing order, 
-- display the output in increasing order of id.

-- Create the table lifts
CREATE TABLE Lifts (
    ID INT,
    CAPACITY_KG INT
);

-- Insert the data
INSERT INTO Lifts (ID, CAPACITY_KG) VALUES
(1, 300),
(2, 350);

-- Create the lift_passengers table
CREATE TABLE lift_passengers (
    PASSENGER_NAME VARCHAR(50),
    WEIGHT_KG INT,
    GENDER CHAR(1),
    LIFT_ID INT
);

-- Insert data into the lift_passengers table
INSERT INTO lift_passengers (PASSENGER_NAME, WEIGHT_KG, GENDER, LIFT_ID)
VALUES
    ('Rahul', 85, 'M', 1),
    ('Adarsh', 73, 'M', 1),
    ('Riti', 95, 'F', 1),
    ('Dheeraj', 80, 'M', 1),
    ('Vimal', 83, 'M', 2),
    ('Neha', 77, 'F', 2),
    ('Priti', 73, 'F', 2),
    ('Himanshi', 85, 'F', 2);

-- expected output
-- | LIFT_ID | PASSENGER_LIST             |
-- |---------|-----------------------------|
-- | 1       | Riti, Adarsh, Dheeraj       |
-- | 2       | Priti, Neha, Himanshi, Vimal |

with my_cte as (
select
*,
sum(weight_kg) over(partition by id order by gender, weight_kg) as running_sum
from lifts l join  lift_passengers p 
on l.id = p.lift_id
)
select
id as LIFT_ID,
group_concat(passenger_name order by gender,weight_kg) as PASSENGER_LIST
from my_cte 
where running_sum <= capacity_kg
group by id

-- Explaination
-- CTE Query
-- SUM(weight_kg) OVER(PARTITION BY id ORDER BY gender, weight_kg) 
-- computes the cumulative weight sum for each lift partitioned by id 
-- and ordered by gender and weight_kg
-- gender is typically ordered alphabetically, 'F' comes before 'M'
