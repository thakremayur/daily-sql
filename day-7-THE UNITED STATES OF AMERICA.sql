/* 
	PROBLEM STATEMENT(22):
	 THE UNITED STATES OF AMERICA
In some poorly designed UI applications, there's often a
lack of data input restrictions. For instance, in a free text
field for the country, users might input variations such as
'USA,' 'United States of America,' or 'US.'
Suppose we have survey data from individuals in the
USA about their job satisfaction, rated on a scale of 1 to
5. Write a SQL query to count the number of respondents
for each rating on the scale. Additionally, include the
country name in the format that occurs most frequently
in that scale, display the output in ascending order of job
satisfaction.
*/

-- Create the table
CREATE TABLE EmployeeSatisfaction (
    NAME VARCHAR(50),
    JOB_SATISFACTION INT,
    COUNTRY VARCHAR(50)
);
-- Insert data into the table
INSERT INTO EmployeeSatisfaction (NAME, JOB_SATISFACTION, COUNTRY) VALUES
('Alex', 4, 'USA'),
('Saurabh', 5, 'US'),
('Mark', 4, 'United States'),
('Shane', 4, 'USA'),
('Kim', 5, 'United States'),
('Joe', 5, 'USA'),
('Mira', 5, 'United States'),
('John', 3, 'USA'),
('Jane', 4, 'United States'),
('Sam', 3, 'US'),
('Sara', 4, 'USA'),
('Luis', 5, 'United States'),
('Carlos', 4, 'US'),
('Anna', 3, 'USA'),
('Maria', 5, 'United States');

/*
EXPECTED OUTPUT:
+------------------+------------------+------------------------+
| JOB_SATISFACTION | COUNTRY          | NUMBER_OF_RESPONDENTS  |
+------------------+------------------+------------------------+
| 4                | USA              | 6                      |
| 5                | United States    | 6                      |
| 3                | USA              | 3                      |
+------------------+------------------+------------------------+
*/

-- solution:
-- my_cte calculates the number of respondents for each combination of JOB_SATISFACTION and COUNTRY.
with my_cte as(
select
JOB_SATISFACTION,
COUNTRY,
count(*) as NUMBER_OF_RESPONDENTS
from EmployeeSatisfaction
group by JOB_SATISFACTION, COUNTRY
),
-- my_cte2 computes the maximum number of respondents (max_cnt) and 
-- the total number of respondents (total) for each JOB_SATISFACTION rating.
my_cte2 as(
select *,
	max(NUMBER_OF_RESPONDENTS) over(partition by JOB_SATISFACTION) as max_cnt,
    sum(NUMBER_OF_RESPONDENTS) over(partition by JOB_SATISFACTION) as total
from my_cte
)
select 
JOB_SATISFACTION,
COUNTRY,
total as NUMBER_OF_RESPONDENTS
from my_cte2
where NUMBER_OF_RESPONDENTS = max_cnt

