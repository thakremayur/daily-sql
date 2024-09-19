/* 
	PROBLEM STATEMENT(21):
	UBER PROFIT RIDES
A profit ride for a Uber driver is considered when the
start location and start time of a ride exactly match
with the previous ride's end location and end time.
Write an SQL to calculate total number of rides and
total profit rides by each driver, display the output in
ascending order of id.
*/
CREATE TABLE booking (
    ID VARCHAR(10),
    START_TIME TIME,
    END_TIME TIME,
    START_LOC VARCHAR(10),
    END_LOC VARCHAR(10)
);
INSERT INTO booking (ID, START_TIME, END_TIME, START_LOC, END_LOC) VALUES
('dri_1', '09:00:00', '09:30:00', 'a', 'b'),
('dri_1', '09:30:00', '10:30:00', 'b', 'c'),
('dri_1', '11:00:00', '11:30:00', 'd', 'e'),
('dri_1', '12:00:00', '12:30:00', 'f', 'g'),
('dri_1', '13:30:00', '14:30:00', 'c', 'h'),
('dri_2', '12:15:00', '12:30:00', 'f', 'g'),
('dri_2', '12:30:00', '14:30:00', 'c', 'h');

/*
EXPECTED OUTPUT:
|-------------------------------------|
| ID     | TOTAL_RIDES | PROFIT_RIDES |
--------------------------------------|
| dri_2  | 2           | 0            |
| dri_1  | 5           | 1            |
|-------------------------------------|

*/

-- SOLUTION:
select * from booking;

with my_cte as (
select
*,
case 
	when (start_time = lag(end_time,1) over(partition by id order by start_time) and
			start_loc = lag(end_loc,1) over(partition by id order by start_time)
		) then 1 else 0
	end as profit_rides
from booking
)
select
id,
count(*) as total_rides,
sum(profit_rides) as profit_rides
from my_cte 
group by id

-- explaination:
/*
The case statement checks if the current ride's start_time matches the previous ride's end_time 
and if the current ride's start_loc matches the previous ride's end_loc.
*/ 