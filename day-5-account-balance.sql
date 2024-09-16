/* 
	PROBLEM STATEMENT(24):
	ACCOUNT BALANCE
YOU ARE GIVEN A LIST OF USERS AND THEIR OPENING
ACCOUNT BALANCE ALONG WITH THE TRANSACTIONS
DONE BY THEM. WRITE A SQL TO CALCULATE THEIR
ACCOUNT BALANCE AT THE END OF ALL THE
TRANSACTIONS. PLEASE NOTE THAT USERS CAN DO
TRANSACTIONS AMONG THEMSELVES AS WELL,
DISPLAY THE OUTPUT IN ASCENDING ORDER OF THE
FINAL BALANCE
*/

-- Create the users table
CREATE TABLE users (
    USER_ID INT PRIMARY KEY,
    USERNAME VARCHAR(50),
    OPENING_BALANCE DECIMAL(10, 2)
);
-- Insert data into the users table
INSERT INTO users (USER_ID, USERNAME, OPENING_BALANCE) VALUES
(100, 'Ankit', 1000.00),
(101, 'Rahul', 9000.00),
(102, 'Amit', 5000.00),
(103, 'Agam', 7500.00);

-- Create the transactions table
CREATE TABLE transactions (
    ID INT PRIMARY KEY,
    FROM_USERID INT,
    TO_USERID INT,
    AMOUNT DECIMAL(10, 2)
);
-- Insert data into the transactions table
INSERT INTO transactions (ID, FROM_USERID, TO_USERID, AMOUNT) VALUES
(1, 100, 102, 500.00),
(2, 102, 101, 700.00),
(3, 101, 102, 600.00),
(4, 102, 100, 1500.00),
(5, 102, 101, 800.00),
(6, 102, 101, 300.00);

/*
Expected output:
+----------+--------------+
| USERNAME | FINAL_BALANCE|
+----------+--------------+
| Ankit    | 2000.00         |
| Amit     | 2800.00         |
| Agam     | 7500.00         |
| Rahul    | 10200.00        |
+----------+--------------+
*/

-- Solution

with all_user as(
select user_id as id, opening_balance as amount from users
UNION ALL
select from_userid as id, -1*amount from transactions
UNION ALL
select to_userid as id, amount from transactions
),
total_amount as (
select id, sum(amount) as total_balance from all_user group by id
)
select username,total_balance
from total_amount t join users u on t.id = u.user_id order by total_balance