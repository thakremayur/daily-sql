/* 
	PROBLEM STATEMENT(9):
	NEW AND REPEAT CUSTOMERS
Flipkart wants to build a very important business
metrics where they want to track on daily basis how
many new and repeat customers are purchasing
products from their website. A new customer is
defined when he purchased anything for the first
time from the website and repeat customer is
someone who has done at least one purchase in the
past.
Display order date , new customers , repeat
customers in ascending order of repeat customers.
*/
CREATE TABLE ps_9_Orders (
    ORDER_ID INT PRIMARY KEY,
    CUSTOMER_ID INT,
    ORDER_DATE DATE,
    ORDER_AMOUNT DECIMAL(10, 2)
);
INSERT INTO ps_9_Orders (ORDER_ID, CUSTOMER_ID, ORDER_DATE, ORDER_AMOUNT) VALUES
(1, 100, '2022-01-01', 2000.00),
(2, 200, '2022-01-01', 2500.00),
(3, 300, '2022-01-01', 2100.00),
(4, 100, '2022-01-02', 2000.00),
(5, 400, '2022-01-02', 2200.00),
(6, 500, '2022-01-02', 2700.00),
(7, 100, '2022-01-03', 3000.00),
(8, 400, '2022-01-03', 1000.00),
(9, 600, '2022-01-03', 3000.00);

/*
EXPECTED OUTPUT:
+-------------+---------------+------------------+
| ORDER_DATE  | NEW_CUSTOMERS | REPEAT_CUSTOMERS |
+-------------+---------------+------------------+
| 2022-01-01  | 3             | 0                |
| 2022-01-02  | 2             | 1                |
| 2022-01-03  | 1             | 2                |
+-------------+---------------+------------------+

*/

select * from ps_9_Orders;

with my_cte as (
select *,
min(order_date) over(partition by customer_id order by order_date) as first_order 
from ps_9_Orders
)
select
order_date,
sum(case when order_date = first_order then 1 else 0 end) as new_customer,
sum(case when order_date > first_order then 1 else 0 end) as repeat_customer
from my_cte
group by order_date
