/* 
	PROBLEM STATEMENT(23):
	PRODUCT RECOMMENDATION
JUST THE BASIC TYPE (“CUSTOMERS WHO BOUGHT THIS ALSO BOUGHT…”). THAT, IN ITS
SIMPLEST FORM, IS AN OUTCOME OF BASKET ANALYSIS. WRITE A SQL TO FIND THE PRODUCT
PAIRS WHICH HAVE BEEN PURCHASED TOGETHER IN SAME ORDER ALONG WITH THE PURCHASE
FREQUENCY (COUNT OF TIMES THEY HAVE BEEN PURCHASED TOGETHER). BASED ON THIS DATA
AMAZON CAN RECOMMEND FREQUENTLY BOUGHT TOGETHER PRODUCTS TO OTHER USERS.
ORDER THE OUTPUT BY PURCHASE FREQUENCY IN DESCENDING ORDER. PLEASE MAKE IN THE
OUTPUT FIRST PRODUCT COLUMN HAS ID GREATER THAN SECOND PRODUCT COLUMN.
*/
CREATE TABLE product (
    ORDER_ID INT,
    CUSTOMER_ID INT,
    PRODUCT_ID VARCHAR(10)
);
INSERT INTO product (ORDER_ID, CUSTOMER_ID, PRODUCT_ID) VALUES
(1, 1, 'p1'),
(1, 1, 'p2'),
(1, 1, 'p3'),
(2, 2, 'p1'),
(2, 2, 'p2'),
(2, 2, 'p4'),
(3, 1, 'p5'),
(3, 1, 'p6'),
(4, 3, 'p1'),
(4, 3, 'p3'),
(4, 3, 'p5'),
(5, 4, 'p2'),
(5, 4, 'p4'),
(5, 4, 'p1');

/*
Expected Output
+-----------+-----------+--------------------+
| PRODUCT_1 | PRODUCT_2 | PURCHASE_FREQUENCY |
+-----------+-----------+--------------------+
| p2        | p1        | 3                  |
| p3        | p1        | 2                  |
| p4        | p1        | 2                  |
| p4        | p2        | 2                  |
| p3        | p2        | 1                  |
| p6        | p5        | 1                  |
| p5        | p1        | 1                  |
| p5        | p3        | 1                  |
+-----------+-----------+--------------------+
*/

-- SOLUTION
-- Select pairs of products and their purchase frequency
select
p1.product_id as PRODUCT_1,
p2.product_id as PRODUCT_2,
count(*) as PURCHASE_FREQUENCY
from product p1 join product p2
using(order_id)			-- Join on the order_id to find pairs in the same order
where p1.product_id > p2.product_id		 -- Ensure each pair is unique (p1 > p2)
group by p1.product_id,p2.product_id	-- Group by product pairs
order by PURCHASE_FREQUENCY desc
 