-- WORKHOLIC EMP 

-- Write a query to find workaholics employees. 
-- Workaholics employees are those who satisfy at least one of the given criterions:
--  
-- 1- Worked for more than 8 hours a day for at least 3 days in a week. 
-- 2- worked for more than 10 hours a day for at least 2 days in a week.
-- You are given the login and logout timings of all the employees for a given week. 
-- Write a SQL to find all the workaholic employees along 
-- with the criterion that they are satisfying (1,2 or both), 
-- display it in the order of increasing employee id

-- create table 
CREATE TABLE employee_logins (
    EMP_ID INT,
    LOGIN TIMESTAMP,
    LOGOUT TIMESTAMP
);
-- insert data into tbl
INSERT INTO employee_logins (EMP_ID, LOGIN, LOGOUT) VALUES
(100, '2024-02-19 09:15:00', '2024-02-19 18:20:00'),
(100, '2024-02-20 09:05:00', '2024-02-20 17:00:00'),
(100, '2024-02-21 09:00:00', '2024-02-21 17:10:00'),
(100, '2024-02-22 10:00:00', '2024-02-22 16:55:00'),
(100, '2024-02-23 10:30:00', '2024-02-23 19:15:00'),
(200, '2024-02-19 08:00:00', '2024-02-19 18:20:00'),
(200, '2024-02-20 09:00:00', '2024-02-20 16:30:00'),
(200, '2024-02-21 09:15:00', '2024-02-21 19:20:00'),
(200, '2024-02-22 11:00:00', '2024-02-22 17:05:00'),
(200, '2024-02-23 09:30:00', '2024-02-23 17:20:00'),
(300, '2024-02-19 07:00:00', '2024-02-19 18:15:00'),
(300, '2024-02-20 09:00:00', '2024-02-20 19:10:00'),
(300, '2024-02-21 09:15:00', '2024-02-21 18:20:00'),
(300, '2024-02-22 11:00:00', '2024-02-22 17:00:00'),
(300, '2024-02-23 09:30:00', '2024-02-23 16:30:00');

-- expected output
-- Expected Output:
-- +--------+-----------+
-- | emp_id | criterian |
-- +--------+-----------+
-- |   100  |     1     |
-- |   200  |     2     |
-- |   300  |    both   |
-- +--------+-----------+ 


-- SOLUTION

select * from employee_logins;

-- if we are looking for hourly differences, 
-- TIMESTAMPDIFF with MINUTE (and dividing by 60) or directly using HOUR is necessary. 

with my_cte as(
select
emp_id,
count(case when timestampdiff(HOUR,login,logout) >= 8 then '8+' end) as day_8,
count(case when timestampdiff(HOUR,login,logout) >=10 then '10+' end) as day_10
from employee_logins
where timestampdiff(HOUR,login,logout) >= 8
group by emp_id
)
select
emp_id,
case 
when day_8 >= 3 and day_10 >= 2 then 'both'
when day_8 >= 3 then '1'
when day_10 >= 2 then '2'
end as criterian
from my_cte 
order by emp_id
