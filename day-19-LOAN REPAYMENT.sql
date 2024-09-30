/* 
	PROBLEM STATEMENT(52):
	- LOAN REPAYMENT
You're working for a large financial institution that
provides various types of loans to customers. Your task is
to analyze loan repayment data to assess credit risk and
improve risk management strategies.
Write an SQL to create 2 flags for each loan as per below
rules. Display loan id, loan amount , due date and the 2
flags.
1- fully_paid_flag: 1 if the loan was fully repaid irrespective
of payment date else it should be 0.
2- on_time_flag : 1 if the loan was fully repaid on or before
due date else 0.
*/
CREATE TABLE loans (
    LOAN_ID INT PRIMARY KEY,
    CUSTOMER_ID INT,
    LOAN_AMOUNT DECIMAL(10, 2),
    DUE_DATE DATE
);
CREATE TABLE payments (
    PAYMENT_ID INT PRIMARY KEY,
    LOAN_ID INT,
    PAYMENT_DATE DATE,
    AMOUNT_PAID DECIMAL(10, 2),
    FOREIGN KEY (LOAN_ID) REFERENCES loans(LOAN_ID)
);

INSERT INTO loans (LOAN_ID, CUSTOMER_ID, LOAN_AMOUNT, DUE_DATE) VALUES
(1, 1, 5000, '2023-01-15'),
(2, 2, 8000, '2023-02-20'),
(3, 3, 10000, '2023-03-10'),
(4, 4, 6000, '2023-04-05'),
(5, 5, 7000, '2023-05-01');

INSERT INTO payments (PAYMENT_ID, LOAN_ID, PAYMENT_DATE, AMOUNT_PAID) VALUES
(1, 1, '2023-01-10', 2000),
(2, 1, '2023-02-10', 1500),
(3, 2, '2023-02-20', 8000),
(4, 3, '2023-04-20', 5000),
(5, 4, '2023-03-15', 2000),
(6, 4, '2023-04-02', 4000),
(7, 5, '2023-04-02', 4000),
(8, 5, '2023-05-02', 3000);

/*
-------------------------------------------------------------------------
| LOAN_ID | LOAN_AMOUNT |    DUE_DATE   | FULLY_PAID_FLAG | ON_TIME_FLAG |
--------------------------------------------------------------------------
|    1    |   5000     |   2023-01-15  |        0        |      0       |
|    3    |  10000     |   2023-03-10  |        0        |      0       |
|    4    |   6000     |   2023-04-05  |        1        |      0       |
|    5    |   7000     |   2023-05-01  |        1        |      1       |
|    2    |   8000     |   2023-02-20  |        1        |      1       |
-------------------------------------------------------------------------
*/

select * from loans;
select * from payments;

with cte as (
select l.loan_id,loan_amount,due_date,
sum(amount_paid) as total_amount,
max(payment_date) as last_pay_date
from loans l join payments p
on l.loan_id = p.loan_id
group by l.loan_id,loan_amount,due_date
)
select loan_id, loan_amount,due_date,
case when loan_amount = total_amount then 1 else 0 end as fully_paid_flag,
case when loan_amount = total_amount and due_date <= last_pay_date then 1 else 0 end as on_time_flag
from cte
