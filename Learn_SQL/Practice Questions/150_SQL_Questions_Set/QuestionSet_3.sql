-- Q.101 Write an SQL query to show the second most recent activity of each user.
-- If the user only hAS one activity, return that one. A user cannot perform more than one activity at the same time.
-- Return the result table in any order.


CREATE TABLE user_activity(
		username VARCHAR(20),
		activity VARCHAR(20),
		start_date DATE,
		end_date DATE
	);


INSERT INTO user_activity VALUES
		('ALICE','TRAVEL','2020-02-12','2020-02-20'),
		('ALICE','DANCING','2020-02-21','2020-02-23'),
		('ALICE','TRAVEL','2020-02-24','2020-02-28'),
		('BOB','TRAVEL','2020-02-11','2020-02-18'); 



-- Solution:

with cte AS (SELECT username,activity,start_date,end_date,
CASE WHEN count(username) OVER(PARTITION BY username) > 1 then 'multiple' ELSE 'single' END AS flag,
row_number() OVER(PARTITION BY username ORDER BY start_date) as rn
FROM user_activity
GROUP BY username,activity,start_date,end_date)
SELECT username,activity,start_date,end_date FROM cte where (rn = 2 and flag = 'multiple') or (rn=1 and flag = 'single')



-- Q.102 SAME AS 101


-- Q.103 Query the name of any student in students who scored higher than 75 Marks. Order your output 
-- by the last three characters of each name. If two or more students both have names ending in the same 
-- last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending id.


CREATE TABLE students(
		id INT,
		name VARCHAR(20),
		marks INT
	);


INSERT INTO students VALUES
		(1,'ASHLEY',81),
		(2,'SAMANTHA',75),
		(3,'JULIA',76),
		(4,'BELVET',84);


-- Solution:

SELECT name 
FROM students
WHERE marks > 75
ORDER BY RIGHT(name,3)



-- Q.104 Write a Query that prints a list of employee names (i.e.: the name attribute) 
-- for employees in employee HAVING a salary greater than $2000 per month who have 
-- been employees for less than 10 months. Sort your result by ascending employee_id.


CREATE TABLE employee(
		employee_id INT,
		name VARCHAR(20),
		month INT,
		salary INT
	);


INSERT INTO employee VALUES
		(12228,'ROSE',15,1968),
		(33645,'ANGELA',1,3443),
		(45692,'FRANK',17,1608),
		(56118,'PATRICK',7,1345),
		(59725,'LISA',11,2330),
		(74197,'KIMBERLY',16,4372),
		(78454,'BONNIE',8,1771),
		(83565,'MICHAEL',6,2017),
		(98607,"TODD",5,3396),
		(99989,'JOE',9,3573);


-- Solution:

SELECT name 
FROM employee
WHERE salary > 2000 and month < 10
ORDER BY employee_id 


-- Q.105 Write a Query identifying the type of each record in the TRIANGLES table using its three side lengths.


CREATE TABLE triangles(
		a INT,
		b INT,
		c INT
	);


INSERT INTO triangles VALUES
		(20,20,23),
		(20,20,20),
		(20,21,22),
		(13,14,30);


-- Solution:

SELECT 
    CASE 
        WHEN a = b AND b = c AND a = c THEN 'Equilateral' 
        WHEN a+b <= c OR b+c <= a OR a+c <= b THEN 'Not A Triangle'
        WHEN a != b AND b != c AND a != c THEN 'Scalene'     
    ELSE 'Isosceles'
    END AS 'Type'
FROM triangles


-- Q.106 Write a query calculating the amount of error (i.e.: actual - miscalculated average monthly salaries), 
-- and round it up to the next integer.


CREATE TABLE employees(
		id INT,
		name VARCHAR(20),
		salary INT
	);

INSERT INTO employees VALUES
		(1,'KRISTEEN',1420),
		(2,'ASHLEY',2006),
		(3,'JULIA',2210),
		(4,'MARIA',3000);


-- Solution:

SELECT CAST(AVG(salary) - AVG(REPLACE(salary, 0, '')) AS SIGNED INTEGER) as diff FROM employees;


-- Q.107 Write a query to find the maximum total earnings for all employees as
-- well as the total number of employees who have maximum total earnings. 
-- Then print these values as 2 space-separated integers.


CREATE TABLE employee(
		employee_id INT,
		name VARCHAR(20),
		months INT,
		salary INT
	);


INSERT INTO employee VALUES
		(12228,'ROSE',15,1968),
		(33645,'ANGELA',1,3443),
		(45692,'FRANK',17,1608),
		(56118,'PATRICK',7,1345),
		(59725,'LISA',11,2330),
		(74197,'KIMBERLY',16,4372),
		(78454,'BONNIE',8,1771),
		(83565,'MICHAEL',6,2017),
		(98607,"TODD",5,3396),
		(99989,'JOE',9,3573);


-- Solution:

SELECT CONCAT_WS(' ',MAX(salary * months), count(*)) as SampleOutput
FROM
employee
WHERE (salary * months) = (SELECT MAX(salary * months) FROM employee)



-- Q.108
-- a. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed 
-- by the first letter of each profession AS a parenthetical (i.e.: enclosed in parentheses). 


-- b. WHERE [occupation_COUNT] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] 
-- is the lowerCASE occupation name. If more than one Occupation hAS the same [occupation_COUNT], 
-- they should be ordered alphabetically.


CREATE TABLE occupations(
		name VARCHAR(20),
		occupation VARCHAR(20)
	);


INSERT INTO occupations VALUES
		('SAMNATHA','DOCTOR'),
		('JULIA','ACTOR'),
		('MARIA','ACTOR'),
		('MEERA','SINGER'),
		('ASHLEY','PROFESSOR'),
		('KETTY','PROFESSOR'),
		('CHRISTEEN','PROFESSOR'),
		('JANE','ACTOR'),
		('JENNY','DOCTOR'),
		('PRIYA','SINGER');


-- Solution:

--a.
SELECT concat(name,'(',LEFT(occupation,1),')') as name_with_occupation 
FROM occupations
ORDER BY name;
--b.
SELECT concat('There are total of ', count(occupation),' ',lower(occupation),'s') as no_of_professional
FROM occupations
GROUP BY occupation
ORDER BY count(occupation)



-- Q.109 Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically 
-- and displayed underneath its corresponding Occupation. The output column headers should be 
-- Doctor, Professor, Singer, and Actor, respectively.


CREATE TABLE occupations(
		name VARCHAR(20),
		occupation VARCHAR(20)
	);


INSERT INTO occupations VALUES
		('SAMNATHA','DOCTOR'),
		('JULIA','ACTOR'),
		('MARIA','ACTOR'),
		('MEERA','SINGER'),
		('ASHLEY','PROFESSOR'),
		('KETTY','PROFESSOR'),
		('CHRISTEEN','PROFESSOR'),
		('JANE','ACTOR'),
		('JENNY','DOCTOR'),
		('PRIYA','SINGER');

-- Solution:

WITH base AS (
SELECT 
    CASE WHEN occupation = 'DOCTOR' THEN name ELSE NULL  END AS 'DOCTOR',
    CASE WHEN occupation = 'PROFESSOR' THEN name END AS 'PROFESSOR',
    CASE WHEN occupation = 'ACTOR' THEN name END AS 'ACTOR',
    CASE WHEN occupation = 'SINGER' THEN name ELSE NULL END AS 'SINGER',
    ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY name) as rn
FROM occupations
)
SELECT max(DOCTOR),max(PROFESSOR),max(ACTOR),max(SINGER) FROM base GROUP BY rn


-- Q.110 Write a query to find the node type of Binary Tree ordered by the value of the node. 
-- Output one of the following for each node:
-- ● Root: If node is root node.
-- ● Leaf: If node is leaf node.
-- ● Inner: If node is neither root nor leaf node.


CREATE TABLE bst(
		n INT,
		p INT
	);


INSERT INTO bst VALUES
		(1,2),
		(3,2),
		(6,8),
		(9,8),
		(2,5),
		(8,5),
		(5,NULL);


-- Solution:

SELECT n,
    CASE WHEN n not IN(SELECT p FROM bst WHERE p is not null GROUP BY p ) THEN 'leaf'
         WHEN p IS NULL THEN 'root'
         WHEN n IN(SELECT p FROM bst WHERE p is not null GROUP BY p ) THEN 'inner'
     END as 'node_type'
FROM bst
ORDER BY n



-- Q.111 Given the table schemas below, write a query to print the company_code, 
-- founder name, total number of lead managers, total number of senior managers, 
-- total number of managers, and total number of employees. Order your output by 
-- ascending company_code.


CREATE TABLE company(
		company_code VARCHAR(20),
		founder VARCHAR(20)
	);


CREATE TABLE lead_manager(
		lead_manager_code VARCHAR(20),
		company_code VARCHAR(20)
	);


CREATE TABLE senior_manager(
		senior_manager_code VARCHAR(20),
		lead_manager_code VARCHAR(20),
		company_code VARCHAR(20)
	);


CREATE TABLE manager(
		manager_code VARCHAR(20),
		senior_manager_code VARCHAR(20),
		lead_manager_code VARCHAR(20),
		company_code VARCHAR(20)
	);


CREATE TABLE employee(
		employee_code VARCHAR(20),
		manager_code VARCHAR(20),
		senior_manager_code VARCHAR(20),
		lead_manager_code VARCHAR(20),
		company_code VARCHAR(20)
	);


INSERT INTO company VALUES
		('C1','MONIKA'),
		('C2','SAMANTHA');


INSERT INTO lead_manager VALUES
		('LM1','C1'),
		('LM2','C2');


INSERT INTO senior_manager VALUES
		('SM1','LM1','C1'),
		('SM2','LM1','C1'),
		('SM3','LM2','C2');    


INSERT INTO manager VALUES
		('M1','SM1','LM1','C1'),
		('M2','SM3','LM2','C2'),
		('M3','SM3','LM2','C2');  


INSERT INTO employee VALUES
		('E1','M1','SM1','LM1','C1'),
		('E2','M1','SM1','LM1','C1'),
		('E3','M2','SM3','LM2','C2'),
		('E4','M3','SM3','LM2','C2');



-- Solution:

SELECT c.company_code,count(distinct lm.lead_manager_code) as no_of_lead_manager,count(distinct sm.senior_manager_code) as no_of_senior_manager,
        count(distinct m.manager_code) as no_of_manager,count(DISTINCT e.employee_code) as no_of_employee_code
FROM company c LEFT JOIN lead_manager lm ON c.company_code = lm.company_code
LEFT JOIN senior_manager sm ON  lm.lead_manager_code = sm.lead_manager_code
LEFT JOIN manager m ON sm.senior_manager_code = m.senior_manager_code
LEFT JOIN employee e ON  m.manager_code = e.manager_code
GROUP BY c.company_code


-- Q.112 Write a query to print all prime numbers less than or equal to 1000. 
-- Print your result on a single line, and use the ampersand () character as 
-- your separator (instead of a space).


-- Solution: [Skipped]:[Will do it soon]





-- Q.113 Write a query to print the pattern P(20).
-- Pattern is:
-- *
-- **
-- ***
-- ****
-- ***** (Upto 20)

-- Solution: [Skipped]:[Will do it soon]


-- Q.114 Write a query to print the pattern P(20).
-- Pattern is:
-- ***** (Upto 20)
-- ****
-- ***
-- **
-- *
Solution: [Skipped]:[Will do it soon]



-- Q.115 SAME AS Q.103



-- Q.116 SAME AS Q.79



-- Q.117 SAME AS Q.104



-- Q.118 SAME AS Q.105



-- Q.119 SAME AS Q.80



-- Q.120 SAME AS Q.81



-- Q.121 SAME AS Q.82



-- Q.122 SAME AS Q.83



-- Q.123 SAME AS Q.84



-- Q.124 SAME AS Q.85



-- Q.125 SAME AS Q.86



-- Q.126 SAME AS Q.87



-- Q.127 SAME AS Q.68



-- Q.128 SAME AS Q.55



-- Q.129 SAME AS Q.90



-- Q.130 SAME AS Q.91



-- Q.131 SAME AS Q.92



-- Q.132 SAME AS Q.50



-- Q.133 SAME AS Q.94



-- Q.134 SAME AS Q.94



-- Q.135 SAME AS Q.101



-- Q.136 SAME AS Q.101



-- Q.137 SAME AS Q.106



-- Q.138 SAME AS Q.105



-- Q.139 SAME AS Q.105



-- Q.140 SAME AS Q.105



-- Q.141 SAME AS Q.110



-- Q.142 SAME AS Q.111



-- Q.143 Write a query to output all such symmetric pairs in ascENDing order by the value of X. 
-- List the rows such that X1 ≤ Y1.


CREATE TABLE functions(
		x INT,
		y INT
	);


INSERT INTO functions VALUES
		(20,20),
		(20,20),
		(20,21),
		(23,22),
		(22,23),
		(21,20);


-- Solution:[Although it's generating correct output but still need more analysis to make it perfect]:[Will do it soon]


WITH base AS(
SELECT x,
 LEAD(x) OVER() AS lead_x,
 y,
 LEAD(y) OVER() AS lead_y
FROM functions
 ORDER BY x,y)

SELECT 
 x ,y
FROM base 
WHERE x = lead_y and y = lead_x and x<=y
ORDER BY x


-- Q.144 Write a query to output the names of those students whose best friends got offered a higher
-- salary than them. Names must be ordered by the salary amount offered to the best friENDs. 
-- It is guaranteed that no two students get the same salary offer.


CREATE TABLE students(
		id INT,
		name VARCHAR(20)
	);


CREATE TABLE friends(
		id INT,
		friend_id INT
	);


CREATE TABLE packages(
		id INT,
		salary FLOAT
	);


INSERT INTO students VALUES
		(1,'ASHLEY'),
		(2,'SAMANTHA'),
		(3,'JULIA'),
		(4,'SCARLET');


INSERT INTO friends VALUES
		(1,2),
		(2,3),
		(3,4),
		(4,1);


INSERT INTO packages VALUES
		(1,15.20),
		(2,10.06),
		(3,11.55),
		(4,12.12);


-- Solution:

SELECT name FROM(
SELECT student_id, max(student_salary) as student_salary, max(friend_id) as friend_id, max(friend_salary) as friend_salary
FROM
(
    SELECT f.id as student_id, pck.salary as student_salary, NULL as friend_id, NULL as friend_salary
    FROM friends f
    JOIN packages pck ON f.id = pck.id

    UNION ALL

    SELECT f1.id as student_id, NULL as student_salary, f1.friend_id as friend_id, pck2.salary as friend_salary
    FROM friends f1
    LEFT JOIN packages pck2 ON f1.friend_id = pck2.id
) AS salary
GROUP BY student_id
HAVING student_salary < friend_salary) s JOIN students stndt ON s.student_id = stndt.id



-- Q.145 Write a query to print the respective hacker_id and name of hackers who achieved full scores for 
-- more than one challenge. Order your output in descENDing order by the total number of challenges in 
-- which the hacker earned a full score. If more than one hacker received full scores in the same number 
-- of challenges, then sort them by ascending hacker_id.


CREATE TABLE hackers(
		hacker_id INT,
		name VARCHAR(20)
	);


CREATE TABLE difficulty(
		difficulty_level INT,
		score INT
	);


CREATE TABLE challenges(
		challenge_id INT,
		hacker_id INT,
		difficulty_level INT
	);


CREATE TABLE submissions(
		submission_id INT,
		hacker_id INT,
		challenge_id INT,
		score INT
	);


INSERT INTO hackers VALUES
		(5580,'ROSE'),
		(8439,'ANGELA'),
		(27205,'FRANK'),
		(52243,'PATRICK'),
		(52348,'LISA'),
		(57645,'KIMBERLY'),
		(77726,'BONNIE'),
		(83082,'MICHAEL'),
		(86870,'TODD'),
		(90411,'JOE');


INSERT INTO difficulty VALUES
		(1,20),
		(2,30),
		(3,40),
		(4,60),
		(5,80),
		(6,100),
		(7,120);


INSERT INTO challenges VALUES
		(4810,77726,4),
		(21089,27205,1),
		(36566,5580,7),
		(66730,52243,6),
		(71055,52243,2);
 

INSERT INTO submissions (submission_id, hacker_id, challenge_id, score)
VALUES
(68628, 77726, 36566, 30),
(65300, 77726, 21089, 10),
(40326, 52243, 36566, 77),
(8941, 27205, 4810, 4),
(83554, 77726, 66730, 30),
(43353, 52243, 66730, 0),
(55385, 52348, 71055, 20),
(39784, 27205, 71055, 23),
(94613, 86870, 71055, 30),
(45788, 52348, 36566, 0),
(93058, 86870, 36566, 30),
(7344, 8439, 66730, 92),
(2721, 8439, 4810, 36),
(523, 5580, 71055, 4),
(49105, 52348, 66730, 0),
(55877, 57645, 66730, 80),
(38355, 27205, 66730, 35),
(3924, 8439, 36566, 80),
(97397, 90411, 66730, 100),
(84162, 83082, 4810, 40),
(97431, 90411, 71055, 30);



-- Solution:

with hacker_details AS(
SELECT s.submission_id,s.hacker_id as hacker_id,s.challenge_id,c.difficulty_level,s.score as secured_score,d.score as total_score
FROM submissions s 
JOIN challenges c ON s.challenge_id = c.challenge_id
JOIN difficulty d ON c.difficulty_level = d.difficulty_level
)
SELECT h.hacker_id,name FROM hackers h JOIN (
SELECT hacker_id,count(*) FROM hacker_details WHERE secured_score = total_score
GROUP BY hacker_id
having count(*)>1) f ON h.hacker_id = f.hacker_id



-- Q.146 Write a query to output the start and END dates of projects listed by the number of days it took 
-- to complete the project in ascending order. If there is more than one project that have the same number 
-- of completion days, then order by the start date of the project.



CREATE TABLE projects(
		task_id INT,
		start_date DATE,
		end_date DATE
	);


INSERT INTO projects VALUES
		(1,'2015-10-01','2015-10-02'),
		(2,'2015-10-02','2015-10-03'),
		(3,'2015-10-03','2015-10-04'),
		(4,'2015-10-13','2015-10-14'),
		(5,'2015-10-14','2015-10-15'),
		(6,'2015-10-28','2015-10-29'),
		(7,'2015-10-30','2015-10-31');


-- Solution: Solution: [Skipped]:[Will do it soon]


-- Q.147 In an effort to identify high-value customers, Amazon asked for your help to obtain data 
-- about users who go on shopping sprees. A shopping spree occurs when a user makes purchASes on 3 
-- or more consecutive days. List the user IDs who have gone on at leASt 1 shopping spree in ascending order.


CREATE TABLE transactions(
		user_id INT,
		amount FLOAT,
		transaction_date DATETIME
	);


INSERT INTO transactions VALUES
    	    (1, 9.99, '2022-08-01 10:00:00'),
   			(1, 55, '2022-08-17 10:00:00'),
   			(2, 149.5, '2022-08-05 10:00:00'),
   			(2, 4.89, '2022-08-06 10:00:00'),
  			(2, 34, '2022-08-07 10:00:00');


-- Solution:

WITH user_details AS(
SELECT user_id, SUM(diff)
FROM (
    SELECT user_id, transaction_date, next_day, DATEDIFF(next_day, transaction_date) AS diff
    FROM (
        SELECT user_id, transaction_date,
            LEAD(transaction_date) OVER(PARTITION BY user_id) AS next_day
        FROM transactions
    ) AS subquery
) AS x
WHERE diff = 1
GROUP BY user_id
HAVING SUM(diff) >= 2)
SELECT user_id FROM user_details;



-- Q.148 You are given a table of PayPal payments showing the payer, the recipient, and the amount paid. 
-- A two-way unique relationship is established WHEN two people sEND money back and forth. Write a query 
-- to find the number of two-way unique relationships in this data.


CREATE TABLE payments(
		payer_id INT,
		recipient_id INT,
		amount INT
	);


INSERT INTO payments VALUES
		(101,201,30),
		(201,101,10),
		(101,301,20),
		(301,101,80),
		(201,301,70);


-- Solution: 

SELECT count(*) FROM payments p1 JOIN payments p2 ON p1.recipient_id= p2.payer_id and p1.payer_id= p2.recipient_id
and p1.payer_id > p1.recipient_id
WHERE p2.payer_id is not null



-- Q.149 Write a query to obtain the list of customers whose first transaction was valued at $50 or more.
-- Output the number of users.


CREATE TABLE user_transactions(
		transaction_id INT,
		user_id INT,
		spend FLOAT,
		transaction_date VARCHAR(30)
	);


INSERT INTO user_transactions VALUES
    			 (759274, 111, 49.50, '2022-02-03 00:00:00'),
   			     (850371, 111, 51.00, '2022-03-15 00:00:00'),
  			     (615348, 145, 36.30, '2022-03-22 00:00:00'),
 			     (137424, 156, 151.00, '2022-04-04 00:00:00'),
  			     (248475, 156, 87.00, '2022-04-16 00:00:00');

-- Solution:

SELECT count(*) as users_count
FROM(
SELECT *,
min(transaction_date) OVER(PARTITION BY user_id) as first_transaction_date
FROM user_transactions
)u
WHERE spend >=50 and transaction_date = first_transaction_date


-- Q.150 Write a query to obtain the SUM of the odd-numbered and even-numbered meASurements on a particular day, 
-- in two different columns.


CREATE TABLE measurments(
		measurment_id INT,
		measurment_value FLOAT,
		measurment_time DATETIME
	);


INSERT INTO measurments VALUES
  			   (131233, 1109.51, '2022-07-10 09:00:00'),
  			   (135211, 1662.74, '2022-07-10 11:00:00'),
 			   (523542, 1246.24, '2022-07-10 13:15:00'),
			   (143562, 1124.50, '2022-07-11 15:00:00'),
			   (346462, 1234.14, '2022-07-11 16:45:00');



-- Solution:

SELECT 
        DATE(measurment_time) AS measurment_day,
        ROUND(SUM(CASE WHEN rn % 2 = 0 THEN measurment_value END),1) AS even_sum,
        ROUND(SUM(CASE WHEN rn % 2 != 0 THEN measurment_value END),1) AS odd_sum
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY DATE(measurment_time)) AS rn
    FROM measurements1
) AS m
GROUP BY measurment_day


-- Q.151 SAME AS Q.147


-- Q.152 The Airbnb Booking Recommendations team is trying to understand the "substitutability" of two rentals 
-- and whether one rental is a good substitute for another. They want you to write a query to find the unique 
-- combination of two Airbnb rentals WITH the same exact amenities offered. Output the COUNT of the unique 
-- combination of Airbnb rentals.


CREATE TABLE rental_amenities(
		rental_id INT,
		amenity VARCHAR(20)
	);


INSERT INTO rental_amenities VALUES
		(123,'POOL'),
		(123,'KITCHEN'),
		(234,'HOT TUB'),
		(234,'FIREPLACE'),
		(345,'KITCHEN'),
		(345,'POOL'),
		(456,'POOL');

-- Solution:

WITH cte AS(
SELECT rental_id,
GROUP_CONCAT(amenity ORDER BY amenity) as amenities,
ROW_NUMBER() OVER() as rn
FROM  rental_amenities
GROUP BY rental_id
ORDER BY amenities
)
SELECT count(*) as matching_airbnb FROM cte c JOIN cte c1 ON c.amenities = c1.amenities and c.rn < c1.rn



-- Q.153 Write a query to calculate the return on ad spend (ROAS) for each advertiser 
-- across all ad campaigns. Round your answer to 2 decimal places, and order your 
-- output by the advertiser_id.


CREATE TABLE ad_campaigns(
		campaign_id INT,
		spend INT,
		revenue FLOAT,
		advertiser_id INT
	);


INSERT INTO ad_campaigns VALUES
		(1,5000,7500,3),
		(2,1000,900,1),
		(3,3000,12000,2),
		(4,500,2000,4),
		(5,100,400,4);


-- Solution:

SELECT advertiser_id,ROUND( ad_revenue/ad_spend,2) as ROAS
FROM(
    SELECT advertiser_id,sum(spend) as ad_spend,sum(revenue) as ad_revenue 
    FROM ad_campaigns
    GROUP BY advertiser_id
    ORDER BY advertiser_id
)x


-- Q.154 Write a query that shows the following data for each compensation outlier: 
-- employee ID, salary, and whether they are potentially overpaid or potentially underpaid


CREATE TABLE employee_pay(
		employee_id INT,
		salary INT,
		title VARCHAR(20)
	);


INSERT INTO employee_pay VALUES
		(101,80000,'DATA ANALYST'),
		(102,90000,'DATA ANALYST'),
		(103,100000,'DATA ANALYST'),
		(104,30000,'DATA ANALYST'),
		(105,120000,'DATA SCIENTIST'),
		(106,100000,'DATA SCIENTIST'),
		(107,80000,'DATA SCIENTIST'),
		(108,310000,'DATA SCIENTIST');


-- Solution:

WITH employee AS(
SELECT employee_id,salary,
CASE WHEN salary > (avg_title_salary * 2) THEN 'Overpaid'
    WHEN salary <  (avg_title_salary / 2) THEN 'Underpaid'
END AS 'status'
FROM(
SELECT *,
AVG(salary) OVER(PARTITION BY title) as avg_title_salary
FROM employee_pay
)e
)
SELECT * FROM employee WHERE status IS NOT NULL



-- Q.155 SAME AS 148



-- Q.156 Assume you are given the table below containing information on user
-- purchASes. Write a query to obtain the number of users who purchASed the 
-- same product on two or more different days. Output the number of unique users.


CREATE TABLE purchases(
		user_id INT,
		product_id INT,
		quantity INT,
		purchase_date DATETIME
	);


INSERT INTO purchases VALUES
		(536,3223,6,'2022-01-11 12:33:44'),
		(827,3585,35,'2022-02-20 14:05:26'),
		(536,3223,5,'2022-03-02 09:33:28'),
		(536,1435,10,'2022-03-02 08:40:00'),
		(827,2452,45,'2022-04-09 00:00:00');


-- Solution:

SELECT
     count(distinct user_id) as repeat_purchasers
FROM(
SELECT *,
count(product_id) OVER(PARTITION BY user_id,product_id) as no_of_product_purchased,
count(purchase_date) OVER(PARTITION BY user_id,product_id) as date_diff
FROM  purchases
)p 
WHERE no_of_product_purchased>1 and date_diff >1


-- Q.157 Say you have access to all the transactions for a given merchant acCOUNT. 
-- Write a query to print the cumulative balance of the merchant acCOUNT at the END 
-- of each day, WITH the total balance reset back to zero at the END of the month. 
-- Output the transaction date and cumulative balance.


CREATE TABLE transactions(
		transaction_id INT,
		type ENUM('DEPOSIT','WITHDRAWL'),
		amount FLOAT,
		transaction_date DATETIME
	);


INSERT INTO transactions VALUES
    		(19153, 'DEPOSIT', 65.90, '2022-07-10 10:00:00'),
  		    (53151, 'DEPOSIT', 178.55, '2022-07-08 10:00:00'),
  		    (29776, 'WITHDRAWL', 25.90, '2022-07-08 10:00:00'),
   		    (16461, 'WITHDRAWL', 45.99, '2022-07-08 10:00:00'),
   		    (77134, 'DEPOSIT', 32.60, '2022-07-10 10:00:00');



-- Solution:

SELECT DISTINCT DATE(transaction_date) as transaction_date,
    ROUND(SUM(CASE WHEN type = 'DEPOSIT' THEN amount ELSE -amount END)  OVER(PARTITION BY EXTRACT(MONTH FROM transaction_date) ORDER BY transaction_date),2) AS cumulative_balance
FROM  transactions


-- Q.158 Assume you are given the table below containing information on 
-- Amazon customers and their spend on products belonging to various 
-- categories. Identify the top two highest-grossing products within each 
-- category in 2022. Output the category, product, and total spend.


CREATE TABLE product_spend(
		category VARCHAR(20),
		product VARCHAR(20),
		user_id INT,
		spend FLOAT,
		transaction_date DATETIME
	);


INSERT INTO product_spend VALUES
		 ('APPLIANCE', 'REFRIGERATOR', 165, 246.00, '2021-12-26 12:00:00'),
  		 ('APPLIANCE', 'REFRIGERATOR', 123, 299.99, '2022-03-02 12:00:00'),
   		 ('APPLIANCE', 'WASHING MACHINE', 123, 219.80, '2022-03-02 12:00:00'),
   		 ('ELECTRONICS', 'VACUUM', 178, 152.00, '2022-04-05 12:00:00'),
 		 ('ELECTRONICS', 'WIRELESS HEADSET', 156, 249.90, '2022-07-08 12:00:00'),
		 ('ELECTRONICS', 'REFRIGERATOR', 145, 189.00, '2022-07-15 12:00:00');

-- Solution:

SELECT category,product,total_spend_on_product
FROM(
SELECT *,
ROUND(SUM(spend) OVER(PARTITION BY category,product),2) as total_spend_on_product
 FROM product_spend
WHERE YEAR(transaction_date) = 2022
)p 
GROUP BY category,product,total_spend_on_product



-- Q.159 Facebook is analysing its user signup data for June 2022. 
-- Write a query to generate the churn rate by week in June 2022. 
-- Output the week number (1, 2, 3, 4, ...) and the corresponding 
-- churn rate rounded to 2 decimal places.


CREATE TABLE users(
		user_id INT,
		signup_date DATETIME,
		last_login DATETIME
	);


INSERT INTO users VALUES
		(1001,'2022-06-01 12:00:00','2022-07-05 12:00:00'),
		(1002,'2022-06-03 12:00:00','2022-06-15 12:00:00'),
		(1004,'2022-06-02 12:00:00','2022-06-15 12:00:00'),
		(1006,'2022-06-15 12:00:00','2022-06-27 12:00:00'),
		(1012,'2022-06-16 12:00:00','2022-07-22 12:00:00');


-- Solution:

WITH cte_user_details AS(
SELECT *,CEIL(DAY(signup_date) / 7) as week_number,
    IF(DATEDIFF(last_login, signup_date) > 28, 'not_churn','churn') AS churn_status,
    COUNT(*) OVER (PARTITION BY CEIL(DAY(signup_date) / 7)) AS no_of_signup_week_wise
FROM users
)
,churn_count AS(
    SELECT *,
    count(churn_status) OVER(PARTITION BY week_number) as no_of_churn
    FROM cte_user_details
    WHERE churn_status='churn'
)
SELECT  churn_count.week_number,ROUND((no_of_churn/churn_count.no_of_signup_week_wise)*100,2) as churn_rate
FROM churn_count,cte_user_details
GROUP BY churn_count.week_number
ORDER BY churn_count.week_number
