/* 
	PROBLEM STATEMENT(10):
    THE LITTLE MASTER
SACHIN TENDULKAR - ALSO KNOWN AS LITTLE
MASTER. YOU ARE GIVEN RUNS SCORED BY SACHIN
IN HIS FIRST 10 MATCHES.
YOU NEED TO WRITE AN SQL TO GET MATCH
NUMBER WHEN HE COMPLETED 500 RUNS AND HIS
BATTING AVERAGE AT THE END OF 10 MATCHES.
BATTING AVERAGE = (TOTAL RUNS SCORED) / (NO
OF TIMES BATSMAN GOT OUT)
ROUND THE RESULT TO 2 DECIMAL PLACES.
*/
CREATE TABLE MatchStatistics (
    MATCH_NO INT PRIMARY KEY,
    RUNS_SCORED INT,
    STATUS VARCHAR(10)
);
INSERT INTO MatchStatistics (MATCH_NO, RUNS_SCORED, STATUS) VALUES
(1, 53, 'out'),
(2, 59, 'not-out'),
(3, 113, 'out'),
(4, 29, 'out'),
(5, 0, 'out'),
(6, 39, 'out'),
(7, 73, 'out'),
(8, 149, 'out'),
(9, 93, 'out'),
(10, 25, 'out');

/*
EXPECTED OUTPUT:
-------------------------------
| MATCH_NO | BATTING_AVERAGE |
|----------|------------------|
| 8        | 70.33            |
--------------------------------
*/

select * from MatchStatistics;

with my_cte as (
select *,
round(sum(runs_scored) over() / (select count(*) from MatchStatistics where status = 'out'),2) as BATTING_AVERAGE,
sum(runs_scored) over(order by match_no) as run_sum
from MatchStatistics
)
select 
MATCH_NO,
BATTING_AVERAGE
from my_cte 
where run_sum>=500 
order by run_sum 
limit 1