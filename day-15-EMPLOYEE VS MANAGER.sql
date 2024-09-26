/* 
	PROBLEM STATEMENT(34):
	EMPLOYEE VS MANAGER
You are given the table of employee details. Write an SQL
to find details of employee with salary more than their
manager salary but they joined the company after the
manager joined.
Display employee name, salary and joining date along with
their manager's salary and joining date, sort the output in
ascending order of employee name.
Please note that manager id in the employee table referring
to emp id of the same table.
*/
CREATE TABLE Employees (
    EMP_ID INT PRIMARY KEY,
    EMP_NAME VARCHAR(50),
    JOINING_DATE DATE,
    SALARY DECIMAL(10, 2),
    MANAGER_ID INT
);
INSERT INTO Employees (EMP_ID, EMP_NAME, JOINING_DATE, SALARY, MANAGER_ID) VALUES
(1, 'Ankit', '2021-01-01', 10000.00, 4),
(2, 'Mohit', '2022-05-01', 15000.00, 5),
(3, 'Vikas', '2023-06-01', 10000.00, 4),
(4, 'Rohit', '2022-02-01', 5000.00, 2),
(5, 'Mudit', '2021-03-01', 12000.00, 6),
(6, 'Agam', '2024-02-01', 12000.00, 2),
(7, 'Sanjay', '2024-02-21', 9000.00, 2),
(8, 'Ashish', '2023-01-05', 5000.00, 2),
(9, 'Mukesh', '2020-02-03', 6000.00, 6),
(10, 'Rakesh', '2022-08-01', 7000.00, 6);

/*
EXPECTED OUTPUT:
-------------------------------------------------------------------------
| EMP_NAME | SALARY | JOINING_DATE | MANAGER_SALARY | MANAGER_JOIN_DATE |
-------------------------------------------------------------------------
| Mohit    | 15000  | 2022-05-01   | 12000          | 2021-03-01        |
| Vikas    | 10000  | 2023-06-01   | 5000           | 2022-02-01        |
-------------------------------------------------------------------------

*/
select * from Employees;

select e.emp_name, e.salary,e.joining_date,
m.salary as manager_salary,
m.joining_date as manager_join_date
from Employees e join Employees m
on e.manager_id = m.emp_id 
where e.salary > m.salary and e.joining_date > m.joining_date
order by e.emp_name