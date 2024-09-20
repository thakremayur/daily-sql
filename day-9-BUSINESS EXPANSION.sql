/* 
	PROBLEM STATEMENT(17):
	BUSINESS EXPANSION
Amazon is expanding their pharmacy business to
new cities every year. You are given a table of
business operations where you have information
about cities where Amazon is doing operations
along with the business date information.
Write a SQL to find year wise number of new cities
added to the business, display the output in
increasing order of year
*/
-- Create the table
CREATE TABLE business_data (
    business_date DATE,
    city_id INT
);
-- Insert the data
INSERT INTO business_data (business_date, city_id) VALUES
('2020-01-02', 3),
('2020-07-01', 7),
('2021-01-01', 3),
('2021-02-03', 19),
('2022-12-01', 3),
('2022-12-15', 3),
('2022-02-28', 12);

/*
EXPECTED OUTPUT:
+---------------+------------------+
| FIRST_OPERATION_YEAR | NO_OF_NEW_CITIES |
+---------------+------------------+
| 2020          | 2                |
| 2021          | 1                |
| 2022          | 1                |
+---------------+------------------+

*/

select * from business_data;

with my_cte as (
select
city_id,
min(year(business_date)) as first_year
from business_data
group by city_id
)
select
first_year as FIRST_OPERATION_YEAR,
count(*) as NO_OF_NEW_CITIES
from my_cte
group by first_year
order by first_year 

-- explaination:
/*
CTE Definition (my_cte): This part calculates the first year in which each city operated.
Main Query: It counts how many cities were first established in each year.
Ordering: The final output is sorted in increasing order of the year (first_year).
*/ 