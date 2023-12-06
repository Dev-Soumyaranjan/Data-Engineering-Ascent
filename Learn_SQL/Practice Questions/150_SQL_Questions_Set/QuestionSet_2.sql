-- Q.51 Write an SQL Query to report the name, population, and area of the big countries. 
-- Return the result table in any order . 


CREATE TABLE world(
	name VARCHAR(20) NOT NULL,
	continent VARCHAR(15) NOT NULL,
	area INT NOT NULL,
	population BIGINT NOT NULL,
	gdp BIGINT NOT NULL,
	PRIMARY KEY(name)
	);


INSERT INTO world VALUES 
	    ('Afghanistan', 'Asia', 652230, 25500100, 203430000000),
        ('Albania', 'Europe', 28748, 2831741, 12960000000),
        ('Algeria', 'Africa', 2381741, 37100000, 188681000000),
        ('Andorra', 'Europe', 468, 78115, 3712000000),
        ('Angola', 'Africa', 1246700, 20609294, 100990000000),
        ('Dominican Republic', 'Caribbean', 48671, 9445281, 58898000000),
        ('China', 'Asia', 652230, 1365370000, 8358400000000),
        ('Colombia', 'South America', 1141748, 47662000, 369813000000),
        ('Comoros', 'Africa', 1862, 743798, 616000000),
        ('Denmark', 'Europe', 43094, 5634437, 314889000000),
        ('Djibouti', 'Africa', 23200, 886000, 1361000000),
        ('Dominica', 'Caribbean', 751, 71293, 499000000),
	('SriLanka', 'Asia', 652230, 25500100, 203430000000);
        
 
-- Solution:

SELECT name,population,area
FROM world
WHERE area >= 3000000 or population >= 25000000


-- Q.52 Write an SQL Query to report the names of the customer that are not referred by the customer with id = 2.
-- Return the result table in any order.


CREATE TABLE customer(
	id INT,
	name VARCHAR(10),
	refree_id INT,
	PRIMARY KEY(id)
	);
    

INSERT INTO customer VALUES 
	(1,'Will',NULL),
	(2,'Jane',NULL),
	(3,'Alex',2),
	(4,'Bill',NULL),
	(5,'Zack',1),
	(6,'Mark',2);

-- Solution:

SELECT name FROM customer
WHERE referee_id != 2 or referee_id is NULL



-- Q.53 Write an SQL Query to report all customers who never order anything. 
-- Return the result table in any order .


CREATE TABLE orders(
        id INT,
        customer_id INT,
        PRIMARY KEY(id)
    );


INSERT INTO orders VALUES 
        (1,3),
        (2,1);


CREATE TABLE customers(
        id INT,
        name VARCHAR(20),
        PRIMARY KEY(id)
    );


INSERT INTO customers VALUES 
        (1,'JOE'),
        (2,'HENRY'),
        (3,'SAM'),
        (4,'MAX');


-- Solution:

SELECT name
FROM customers c 
LEFT JOIN orders o ON c.id = o.customerId
WHERE o.customerId is NULL

-- Q.54 Write an SQL Query to find the team size of each of the employees. 
-- Return result table in any order .


CREATE TABLE employee(
        employee_id INT,
        team_id INT,
        PRIMARY KEY(employee_id)
    );


INSERT INTO employee VALUES 
        (1,8),
        (2,8),
        (3,8),
        (4,7),
        (5,9),
        (6,9);


-- Solution:

SELECT employee_id,
count(team_id) over(PARTITION BY team_id) as group_gize
FROM employee
ORDER BY employee_id


-- Q.55 Write an SQL Query to find the countries where this company can invest .
-- Return the result table in any order .


CREATE TABLE person(
        id INT,
        name VARCHAR(20),
        phone_number VARCHAR(20),
        PRIMARY KEY(id)
    );


CREATE TABLE country(
        name VARCHAR(20),
        country_code VARCHAR(20),
        PRIMARY KEY(country_code)
    );


CREATE TABLE calls(
        caller_id INT,
        callee_id INT,
        duration INT
    );


INSERT INTO person VALUES 
        (3,'JONATHON','051-1234567'),
        (21,'ELVIS','051-7654321'),
        (1,'MONCEF','212-1234567'),
        (2,'MAROUA','212-6523651'),
        (7,'MEIR','972-1234567'),
        (9,'RACHEL','972-0011100');


INSERT INTO calls VALUES 
        (1,9,33),
        (1,2,59),
        (3,12,102),
        (3,12,330),
        (12,3,5),
        (7,9,13),
        (7,1,3),
        (9,7,1),
        (1,7,7),
        (2,9,4);


INSERT INTO country VALUES 
        ('PERU','51'),
        ('ISRAEL','972'),
        ('MOROCCO','212'),
        ('GERMANY','49'),
        ('ETHIOPIA','251');


-- Solution:

WITH person_details AS (
  SELECT p.id AS person_id, p.name AS person_name, c.name AS country_name
  FROM person p
  LEFT JOIN country c ON LEFT(p.phone_number, 3) = RIGHT(CONCAT('000', country_code), 3)
)
SELECT Country_Name FROM(
SELECT person_details.country_name as Country_Name, AVG(calls.duration) AS avg_duration
FROM person_details 
JOIN calls ON person_details.person_id = calls.caller_id OR person_details.person_id = calls.callee_id
GROUP BY person_details.country_name
)x
WHERE avg_duration > (SELECT avg(duration) from calls)


-- Q.56 Write an SQL Query to report the device that is first logged in for each player. 
-- Return the result table in any order.


CREATE TABLE activity(
        player_id INT,
        device_id INT,
        event_date DATE,
        games_played INT,
        PRIMARY KEY(player_id, event_date)
	);


INSERT INTO activity VALUES 
        (1,2,'2016-03-01',5),
        (1,2,'2016-03-02',6),
        (2,3,'2017-06-25',1),
        (3,1,'2016-03-02',0),
        (3,4,'2018-07-03',5);
        


-- Solution:

WITH act_table AS(
SELECT *,
    row_number() OVER(PARTITION BY player_id ORDER BY event_date ASC) as rn
    FROM activity 
)
SELECT player_id,device_id
FROM act_table WHERE rn = 1



-- Q.57 Write an SQL Query to find the customer_number for the customer who has placed the largest number of orders.


CREATE TABLE orders(
        order_number INT,
        customer_number INT,
        PRIMARY KEY(order_number)
    );


INSERT INTO orders VALUES
        (1,1),
        (2,2),
        (3,3),
        (4,3);


-- Solution:

SELECT customer_number FROM(
SELECT customer_number,count(*) as no_of_customer
FROM orders1
GROUP BY customer_number
HAVING no_of_customer >1
) c



-- Q.58 Write an SQL Query to report all the consecutive available seats in the cinema.
-- Return the result table ordered by seat_id in ascending order.


CREATE TABLE cinema(
        seat_id INT AUTO_INCREMENT,
        free BOOLEAN,
        PRIMARY KEY(seat_id)
    );


INSERT INTO cinema (free) VALUES 
        (1),(0),(1),(1),(1),(1),(0),(1),
        (1),(0),(1),(1),(1),(0),(1),(1);


-- Solution:

SELECT DISTINCT c1.seat_id  FROM cinema c1 JOIN cinema c2 ON  abs(c1.seat_id - c2.seat_id)= 1
and (c1.free = 1 and c2.free = 1)
ORDER BY c1.seat_id;



-- Q.59 Write an SQL Query to report the names of all the salespersons who did not have any 
-- orders related to the company with the name "RED".


CREATE TABLE sales_person(
        sales_id INT,
        name VARCHAR(20),
        salary INT,
        commission_rate INT,
        hire_date VARCHAR(25),
        PRIMARY KEY(sales_id)
    );


INSERT INTO sales_person VALUES
        (1,'JOHN',100000,6,'4-1-2006'),
        (2,'AMY',12000,5,'5-1-2010'),
        (3,'MARK',65000,12,'12-25-2008'),
        (4,'PAM',25000,25,'1-1-2005'),
        (5,'ALEX',5000,10,'2-3-2007');


CREATE TABLE company(
        company_id INT,
        name VARCHAR(20),
        city VARCHAR(10),
        PRIMARY KEY(company_id)
    );


INSERT INTO company VALUES
        (1,'RED','BOSTON'),
        (2,'ORANGE','NEW YORK'),
        (3,'YELLOW','BOSTON'),
        (4,'GREEN','AUSTIN');


CREATE TABLE orders(
        order_id INT,
        order_date VARCHAR(30),
        company_id INT,
        sales_id INT,
        amount INT,
        PRIMARY KEY(order_id),
        CONSTRAINT company_foreign_key FOREIGN KEY (company_id) REFERENCES company(company_id),
        CONSTRAINT sales_foreign_key FOREIGN KEY (sales_id) REFERENCES sales_person(sales_id)
    );


INSERT INTO orders VALUES
        (1,'1-1-2014',3,4,10000),
        (2,'2-1-2014',4,5,5000),
        (3,'3-1-2014',1,1,50000),
        (4,'4-1-2014',1,4,25000);


-- Solution:

SELECT name FROM salesperson
WHERE sales_id NOT IN(
SELECT sp.sales_id
FROM salesperson sp LEFT JOIN  orders2 o on sp.sales_id = o.sales_id 
LEFT JOIN company c ON o.com_id = c.com_id
WHERE o.com_id =1 
GROUP BY sp.sales_id)



-- Q.60 Write an SQL Query to report for every three line segments whether they can form a triangle. 
-- Return the result table in any order.


CREATE TABLE triangle(
        x INT,
        y INT,
        z INT,
        PRIMARY KEY(x,y,z)
    );


INSERT INTO triangle VALUES
        (13,15,30),
        (10,20,15);


-- Solution:

SELECT x,y,z,
    CASE
        WHEN x+y > z and y+z > x and x+z > y THEN 'YES' ELSE 'NO'
    END AS triangle
FROM triangle


-- Q.61 Write an SQL Query to report the shortest distance between any two points from the Point table.


CREATE TABLE point(
        x INT,
        PRIMARY KEY(x)
    );


INSERT INTO point VALUES
        (-1),
        (0),
        (2);


-- Solution:

SELECT ABS(p1.x - p2.x) AS shortest
FROM point p1
CROSS JOIN point p2
WHERE ABS(p1.x - p2.x) !=0
ORDER BY shortest
LIMIT 1;




-- Q.62 Write a SQL Query for a report that provides the pairs (actor_id, director_id) where the actor has 
-- cooperated with the director at least three times. Return the result table in any order.


CREATE TABLE actor_director(
        actor_id INT,
        director_id INT,
        timestamp INT,
        PRIMARY KEY(timestamp)
    );


INSERT INTO actor_director VALUES 
        (1,1,0),
        (1,1,1),
        (1,1,2),
        (1,2,3),
        (1,2,4),
        (2,1,5),
        (2,1,6);

-- Solution:


SELECT actor_id,director_id FROM(
SELECT actor_id,director_id,count(*)
FROM actor_director
WHERE actor_id = director_id
GROUP BY actor_id,director_id
HAVING count(*) >=3
)a



-- Q.63 Write an SQL Query that reports the product_name, year, and price for each sale_id in
-- the sales table. Return the resulting table in any order.


CREATE TABLE sales(
        sale_id INT,
        product_id INT,
        year INT,
        Quantity INT,
        price INT,
        PRIMARY KEY(sale_id, year)
    );


CREATE TABLE product(
        product_id INT,
        product_name VARCHAR(20),
        PRIMARY KEY(product_id)
    );


INSERT INTO sales VALUES 
        (1,100,2008,10,5000),
        (2,100,2009,12,5000),
        (7,200,2011,15,9000);


INSERT INTO product VALUES
        (100,'NOKIA'),
        (200,'APPLE'),
        (300,'SAMSUNG');



-- Solution:

SELECT p.product_name,s.year,s.price
FROM sale s
JOIN sale_product p ON s.product_id = p.product_id
ORDER BY s.year


-- Q.64 Write an SQL Query that reports the average experience years of all the employees for each project, 
-- rounded to 2 digits. Return the result table in any order.


CREATE TABLE project(
        project_id INT,
        employee_id INT,
        PRIMARY KEY(project_id, employee_id)
    );


INSERT INTO project VALUES 
        (1,1),
        (1,2),
        (1,3),
        (2,1),
        (2,4);


CREATE TABLE employee(
        employee_id INT,
        name VARCHAR(20),
        experience_years INT,
        PRIMARY KEY(employee_id)
    );


INSERT INTO employee VALUES 
        (1,'KHALED',3),
        (2,'ALI',2),
        (3,'JOHN',1),
        (4,'DOE',2);


-- Solution:

SELECT project_id,ROUND(sum(experience_years)/count(*),2)
FROM project p 
JOIN project_employee pe  ON p.employee_id = pe.employee_id
GROUP BY project_id



-- Q.65 Write an SQL Query that reports the best seller by total sales price, If there is a tie, 
-- report them all. Return the result table in any order.


CREATE TABLE product(
        product_id INT,
        product_name VARCHAR(20),
        unit_price INT,
        PRIMARY KEY(product_id)
    );


INSERT INTO product VALUES 
        (1,'S8',1000),
        (2,'G4',800),
        (3,'Iphone',1400);


CREATE TABLE sales(
        seller_id INT,
        product_id INT,
        buyer_id INT,
        sale_date DATE,
        quantity INT,
        price INT,
        CONSTRAINT FOREIGN_KEY FOREIGN KEY(product_id) REFERENCES product(product_id)
    );


INSERT INTO sales VALUES 
        (1,1,1,'2019-01-21',2,2000),
        (1,2,2,'2019-01-21',1,800),
        (2,2,3,'2019-01-21',1,800),
        (3,3,4,'2019-01-21',2,2800);


-- Solution:

select seller_id from(
select seller_id as seller_id,sum(price),
	dense_rank() over(order by sum(price) desc) as rnk
 from sales
 group by seller_id
 )s where rnk = 1;


-- Q.66 Write an SQL Query that reports the buyers who have bought S8 but not iphone. Note that S8 and iphone 
-- are products present in the product table. Return the result table in any order.


-- Same input table as for previous question i.e. 65

-- Solution:

SELECT s.buyer_id FROM sales s JOIN product p on s.product_id = p.product_id
WHERE p.product_name = 'S8' and p.product_name != 'iPhone'


-- Q.67 Write an SQL Query to compute the moving average of how much the customer paid in a seven days window 
-- (i.e., current day + 6 days before). average_amount should be rounded to two decimal places. 
-- Return result table ordered by visited_on in ascending order.


CREATE TABLE customer(
	customer_id INT,
	name VARCHAR(20),
	visited_on DATE,
	amount INT,
	CONSTRAINT PRIMARY_KEY PRIMARY KEY(customer_id,visited_on)
	);


INSERT INTO customer VALUES 
	(1,'JOHN','2019-01-01',100),
	(2,'DANIEL','2019-01-02',110),
	(3,'JADE','2019-01-03',120),
	(4,'KHALED','2019-01-04',130),
	(5,'WINSTON','2019-01-05',110),
	(6,'ELVIS','2019-01-06',140),
	(7,'ANNA','2019-01-07',150),
	(8,'MARIA','2019-01-08',80),
	(9,'JAZE','2019-01-09',110),
	(1,'JOHN','2019-01-10',130),
	(3,'JADE','2019-01-10',150);


-- Solution:

SELECT visited_on,moving_sum as amount,moving_avg as average_amount FROM(
WITH cstmr AS (
    SELECT visited_on, SUM(amount) AS amount_sum
    FROM customer_table
    GROUP BY visited_on
)
SELECT visited_on,
    SUM(amount_sum) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_sum,
    ROUND(AVG(amount_sum) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS moving_avg,
    ROW_NUMBER() OVER(ORDER BY visited_on) AS rn
FROM cstmr
)v
WHERE rn>6
ORDER BY visited_on



-- Q.68 Write an SQL Query to find the total score for each gender on each day.
-- Return the result table ordered by gender and day in ascending order.


CREATE TABLE scores(
        player_name VARCHAR(20),
        gender VARCHAR(20),
        day DATE,
        score_points INT,
        PRIMARY KEY(gender,day)
    );


INSERT INTO scores VALUES
        ('ARON','F','2020-01-01',17),
        ('ALICE','F','2020-01-07',23),
        ('BAJRANG','M','2020-01-07',7),
        ('KHALI','M','2019-12-25',11),
        ('SLAMAN','M','2019-12-30',13),
        ('JOE','M','2019-12-31',3),
        ('JOSE','M','2019-12-18',2),
        ('PRIYA','F','2019-12-31',23),
        ('PRIYANKA','F','2019-12-30',17);


-- Solution:

SELECT gender,day,sum(score_points) over(PARTITION BY gender ORDER BY day) as total_score from scores


-- Q.69 Write an SQL Query to find the start and end number of continuous ranges in the table logs. 
--  Return the result table ordered by start_id.


CREATE TABLE logs(
        log_id INT,
        PRIMARY KEY(log_id)
    );


INSERT INTO logs VALUES
        (1),
        (2),
        (3),
        (7),
        (8),
        (10);


-- Solution:

SELECT min(log_id) as start_id,max(log_id) as end_id
FROM(
    SELECT 
    log_id, 
    ROW_NUMBER() OVER (ORDER BY log_id) AS rn,
    (log_id - ROW_NUMBER() OVER (ORDER BY log_id)) AS diff 
    FROM 
    logs
)l
GROUP BY diff



-- Q.70 Write an SQL Query to find the number of times each student attended each exam. 
-- Return the result table ordered by student_id and subject_name.


CREATE TABLE students(
        student_id INT,
        student_name VARCHAR(20),
        PRIMARY KEY(student_id)
    );


CREATE TABLE subjects(
        subject_name VARCHAR(20),
        PRIMARY KEY(subject_name)
    );


CREATE TABLE exams(
        student_id INT,
        subject_name VARCHAR(20)
    );


INSERT INTO students VALUES
        (1,'ALICE'),
        (2,'BOB'),
        (13,'JOHN'),
        (6,'ALEX');


INSERT INTO subjects VALUES
        ('MATHS'),
        ('PHYSICS'),
        ('PROGRAMMING');


INSERT INTO exams VALUES    
        (1,'MATHS'),
        (1,'PHYSICS'),
        (1,'PROGRAMMING'),
        (2,'PROGRAMMING'),
        (1,'PHYSICS'),
        (1,'MATHS'),
        (13,'MATHS'),
        (13,'PROGRAMMING'),
        (13,'PHYSICS'),
        (2,'MATHS'),
        (1,'MATHS');
    


-- Solution:

SELECT t1.student_name,t1.subject_name,COALESCE(e.attempt,0) as attended_exams FROM(
SELECT * FROM students
CROSS JOIN subjects
)t1
LEFT JOIN 
(
    SELECT student_id,subject_name,count(subject_name) as attempt FROM examinations GROUP BY student_id,subject_name
) e
ON t1.student_id = e.student_id and t1.subject_name = e.subject_name
ORDER BY t1.student_id,t1.subject_name



-- Q.71 Write an SQL Query to find employee_id of all employees that directly or indirectly 
-- report their work to the head of the company. The indirect relation between managers will not exceed 
-- three managers as the company is small. Return the result table in any order.


CREATE TABLE employees(
        employee_id INT,
        employee_name VARCHAR(20),
        manager_id INT,
        PRIMARY KEY(employee_id)
    );


INSERT INTO employees VALUES    
        (1,'BOSS',1),
        (3,'ALICE',3),
        (2,'BOB',1),
        (4,'DANIEL',2),
        (7,'LUIS',4),
        (8,'JHON',3),
        (9,'ANGELA',8),
        (77,'ROBERT',1);



-- Solution:


SELECT employee_id from employees
WHERE manager_id IN(
    SELECT employee_id from employees
    WHERE manager_id IN(
        
        SELECT employee_id from employees WHERE manager_id = 1
    )
) AND employee_id != 1



-- Q.72 Write an SQL Query to find for each month and country, the number of transactions and their total amount, 
-- the number of approved transactions and their total amount. Return the result table in any order.


CREATE TABLE transactions(
        id INT,
        country VARCHAR(20),
        state ENUM ('APPROVED','DECLINED'),
        amount INT,
        trans_date DATE,
        PRIMARY KEY(id)
    );


INSERT INTO transactions VALUES 
        (121,'US','APPROVED',1000,'2018-12-18'),
        (122,'US','DECLINED',2000,'2018-12-19'),
        (123,'US','APPROVED',2000,'2019-01-01'),
        (124,'DE','APPROVED',2000,'2019-01-07');

  

-- Solution:



SELECT MONTH(trans_date) as month ,country,sum(amount) as trans_total_amount,count(*) as trans_count,sum(CASE WHEN state='approved' then amount else 0 end) as approved_amount
FROM transactions
GROUP BY MONTH(trans_date),country



-- Q.73 Write an SQL Query to find the average daily percentage of posts that got 
-- removed after being reported as spam, rounded to 2 decimal places.


CREATE TABLE actions(
        user_id INT,
        post_id INT,
        action_date DATE,
        action ENUM ('VIEW','LIKE','REACTION','COMMENT','REPORT','SHARE'),
        extra VARCHAR(20)
    );


CREATE TABLE removals(
        post_id INT,
        remove_date DATE,
        PRIMARY KEY(post_id)
    );


INSERT INTO actions VALUES
        (1,1,'2019-07-01','VIEW','NULL'),
        (1,1,'2019-07-01','LIKE','NULL'),
        (1,1,'2019-07-01','SHARE','NULL'),
        (2,2,'2019-07-04','VIEW','NULL'),
        (2,2,'2019-07-04','REPORT','SPAM'),
        (3,4,'2019-07-04','VIEW','NULL'),
        (3,4,'2019-07-04','REPORT','SPAM'),
        (4,3,'2019-07-02','VIEW','NULL'),
        (4,3,'2019-07-02','REPORT','SPAM'),
        (5,2,'2019-07-03','VIEW','NULL'),
        (5,2,'2019-07-03','REPORT','RACISM'),
        (5,5,'2019-07-03','VIEW','NULL'),
        (5,5,'2019-07-03','REPORT','RACISM');


INSERT INTO removals VALUES
        (2,'2019-07-20'),
        (3,'2019-07-18');


-- Solution:

SELECT ROUND(AVG(daily_count),2) as average_daily_percent
FROM(
SELECT COUNT(b.post_id)/count(a.post_id) * 100 as daily_count
FROM actions a 
LEFT JOIN removals b
ON a.post_id = b.post_id 
WHERE extra = 'spam'
GROUP BY action_date
)r


 -- Q.74 SAME AS Q.43 

 -- Q.75 SAME AS Q.43

 -- Q.76 Write an SQL Query to find the salaries of the employees after applying taxes. 
 -- Round the salary to the nearest integer.


 CREATE TABLE salaries(
        company_id INT,
        employee_id INT,
        employee_name VARCHAR(20),
        salary INT,
        PRIMARY KEY(company_id, employee_id)
    );


INSERT INTO salaries VALUES    
        (1,1,'TONY',2000),
        (1,2,'PRONUB',21300),
        (1,3,'TYRROX',10800),
        (2,1,'PAM',300),
        (2,7,'BASSEM',450),
        (2,9,'HERMIONE',700),
        (3,7,'BOCABEN',100),
        (3,2,'OGNJEN',2200),
        (3,13,'NYAN CAT',3300),
        (3,15,'MORNING CAT',7777);



-- Solution:

WITH max_sal AS (
    SELECT *,
           max(salary) OVER(PARTITION BY company_id) as max_salary_in_company
    FROM salaries
)
SELECT company_id,employee_id,employee_name,
       CASE   
           WHEN max_salary_in_company < 1000 THEN salary
           WHEN max_salary_in_company > 100 AND max_salary_in_company <= 10000 THEN ROUND(salary- salary *.24)
           WHEN max_salary_in_company > 10000 THEN ROUND(salary-salary * .49)
       END AS salary
FROM max_sal;



-- Q.77 Write an SQL Query to evaluate the boolean expressions in Expressions table. 
-- Return the result table in any order.


CREATE TABLE variables(
        name VARCHAR(2),
        value INT,
        PRIMARY KEY(name)
    );


INSERT INTO variables VALUES    
        ('x',66),
        ('y',77);
       
       
CREATE TABLE expressions(
        left_operand VARCHAR(2),
        operator ENUM('<','=','>'),
        right_operand VARCHAR(2),
        PRIMARY KEY(left_operand, operator, right_operand)
    );


INSERT INTO expressions VALUES    
        ('x','>','y'),
        ('x','<','y'),
        ('x','=','y'),
        ('y','>','x'),
        ('y','<','x'),
        ('x','=','x');


-- Solution:

WITH te AS(
SELECT t.left_operand as lo ,t.operator as op,t.right_operand as ro ,l.value xv,r.value as yv FROM table_expressions t LEFT JOIN table_variable l ON t.left_operand = l.name
LEFT JOIN table_variable r ON t.right_operand = r.name
)
SELECT lo,op,ro,
    CASE
        WHEN op = '<' then if(xv < yv, 'true','false')
        WHEN op = '>' then if(xv > yv, 'true','false')
        WHEN op = '=' then if(xv = yv, 'true','false')
    END AS v 
FROM te 



-- Q.78 SAME AS Q.55



-- Q.79 Write a Query that prints a list of employee names (i.e.: the name attribute) 
-- from the employee table in alphabetical order.


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
        (56118,'PATRIK',7,1345),
        (74197,'KINBERLY',16,4372),
        (78454,'BONNIE',8,1771),
        (83565,'MICHAEL',6,2017),
        (98607,'TODD',5,3396),
        (99989,'JOE',9,3573);


-- Solution:

SELECT name from employee ORDER BY name


-- Q.80 Write a Query to obtain the year-on-year growth rate for the total spend of each product for each year.


CREATE TABLE user_transactions(
        transaction_id INT,
        product_id INT,
        spend FLOAT,
        transaction_date VARCHAR(30)
    );


INSERT INTO user_transactions VALUES
        (1341,123424,1500.60,'12-31-2019 12:00:00'),
        (1423,123424,1000.20,'12-31-2020 12:00:00'),
        (1623,123424,1246.44,'12-31-2021 12:00:00'),
        (1322,123424,2145.32,'12-31-2022 12:00:00');
    

-- Solution:

(Solved in SQL Server):~

SELECT *,
       CASE
           WHEN previous_year_spend = 0 THEN NULL
           ELSE ROUND(((spend - previous_year_spend) / previous_year_spend)*100, 2)
       END AS year_on_year_growth
FROM (
    SELECT *,
           YEAR(transaction_date) AS year,
           COALESCE(LAG(spend) OVER (ORDER BY transaction_date ), 0) AS previous_year_spend
    FROM user_transactions
) AS t
ORDER BY t.year 



-- Q.81 Write a SQL Query to find the number of prime and non-prime items that can be stored 
-- in the 500,000 square feet warehouse. Output the item type and number of items to be stocked.


CREATE TABLE inventory(
        item_id INT,
        item_type VARCHAR(20),
        item_category VARCHAR(20),
        square_foot FLOAT
    );


INSERT INTO inventory VALUES
        (1374,'PRIME_ELIGIBLE','MINI FRidGE',68.00),
        (4245,'NOT_PRIME','STANDING LAMP',26.40),
        (2452,'PRIME_ELIGIBLE','TELEVISION',85.00),
        (3255,'NOT_PRIME','SidE TABLE',22.60),
        (1672,'PRIME_ELIGIBLE','LAPTOP',8.50);


-- Solution:

WITH total_area AS (
    SELECT item_type, SUM(square_foot) AS total_square_foot, COUNT(*) AS total_items
    FROM inventory
    GROUP BY item_type
),
left_area AS (
    SELECT item_type,
           CASE
               WHEN item_type = 'PRIME_ELIGIBLE' THEN (500000 - total_square_foot * FLOOR(500000 / total_square_foot))
           END AS area_left
    FROM total_area
)
SELECT total_area.item_type,
CASE
    WHEN total_area.item_type = 'PRIME_ELIGIBLE' THEN FLOOR(500000 / total_area.total_square_foot) * total_area.total_items
    WHEN total_area.item_type = 'NOT_PRIME' THEN FLOOR((SELECT area_left from left_area WHERE item_type = 'PRIME_ELIGIBLE') / total_area.total_square_foot) * total_area.total_items
END AS item_count
FROM total_area
LEFT JOIN left_area ON total_area.item_type = left_area.item_type;



-- Q.82 Write a Query to obtain the active user retention in July 2022. 
-- Output the month (in numerical format 1, 2, 3) and the number of monthly active users (MAUs).


CREATE TABLE user_actions(
        user_id INT,
        event_id INT,
        event_type ENUM('SIGN-IN','LIKE','COMMENT'),
        event_date DATETIME
    );


INSERT INTO user_actions VALUES
        (445,7765,'SIGN-IN','2022-05-31 12:00:00'),
        (742,6458,'SIGN-IN','2022-06-03 12:00:00'),
        (445,3634,'LIKE','2022-06-05 12:00:00'),
        (742,1374,'COMMENT','2022-06-05 12:00:00'),
        (648,3124,'LIKE','2022-06-18 12:00:00');


-- Solution:[Skipped]:[Will do it soon]


-- Q.83 Write a Query to report the median of searches made by a user. 
-- Round the median to one decimal point.


CREATE TABLE search_frequency(
        searches INT,
        num_users INT
    );


INSERT INTO search_frequency VALUES
        (1,2),
        (2,2),
        (3,3),
        (4,1);


 -- Solution:[Skipped]:[Will do it soon]


-- Q.84 Write a Query to update the Facebook advertisers status using the daily_pay table. 
-- Advertiser is a two-column table containing the user id and their payment status based 
-- on the last payment and daily_pay table has current information about their payment. 
-- Only advertisers who paid will show up in this table.
-- Output the user id and current payment status sorted by the user id.


CREATE TABLE advertiser(
        user_id VARCHAR(20),
        status ENUM('NEW','EXISTING','CHURN','RESURRECT')
    );


CREATE TABLE daily_pay(
        user_id VARCHAR(20),
        paid DECIMAL
    );


INSERT INTO advertiser VALUES
        ('BING','NEW'),
        ('YAHOO','NEW'),
        ('ALIBABA','EXISTING');


INSERT INTO daily_pay VALUES
        ('YAHOO',45.00),
        ('ALIBABA',100.00),
        ('TARGET',13.00);

-- Solution:

--TODO:[Need small changes to get the exact output and I will modify it soon]

SELECT coalesce(a.user_id, d.user_id) as user_id,
    CASE 
        WHEN a.status = 'NEW' AND d.paid IS NOT NULL THEN 'EXISTING'
        WHEN a.status = 'NEW' AND d.paid IS NULL THEN 'CHURN' 
        WHEN a.status = 'EXISTING' AND d.paid IS NOT NULL THEN 'EXISTING'
        WHEN a.status = 'EXISTING' AND d.paid IS NULL THEN 'CHURN'
        WHEN a.status = 'CHURN' AND d.paid IS NOT NULL THEN 'RESURRECT'
        WHEN a.status = 'CHURN' AND d.paid IS NULL THEN 'CHURN'
        WHEN a.status = 'RESURRECT' AND d.paid IS NOT NULL THEN 'EXISTING'
        WHEN a.status = 'RESURRECT' AND d.paid IS NULL THEN 'CHURN'
        WHEN a.status is NULL AND d.paid IS NOT NULL THEN 'NEW'
    END AS "new_status"
FROM
advertiser a FULL OUTER JOIN daily_pay d ON a.user_id = d.user_id
ORDER BY coalesce(a.user_id, d.user_id)



-- Q.85 Write a SQL Query that calculates the total time that the fleet of 
-- servers was running. The output should be in units of full days.


CREATE TABLE server_utilization(
        server_id INT,
        session_status VARCHAR(20),
        status_time VARCHAR(25)
    );


INSERT INTO server_utilization VALUES
        (1,'start','08-02-2022 10:00:00'),
        (1,'stop','08-04-2022 10:00:00'),
        (2,'stop','08-24-2022 10:00:00'),
        (2,'start','08-17-2022 10:00:00');


-- Solution:

SELECT sum((DATEDIFF(day,end_duration,status_time))) as total_up_time_days
FROM(
    SELECT server_id,status_time,session_status,
    LAG(status_time) OVER(PARTITION BY server_id ORDER BY status_time) as end_duration
 FROM server_utilization
)x
WHERE session_status = 'stop'



-- Q.86 Sometimes, payment transactions are repeated by accident; it could be due to user error, 
-- API failure or a retry error that causes a credit card to be charged twice.
-- Using the transactions table, identify any payments made at the same merchant with the 
-- same credit card for the same amount within 10 minutes of each other. Count such repeated payments.


CREATE TABLE transactions(
        transaction_id INT,
        merchant_id INT,
        credit_card_id INT,
        amount INT,
        transaction_timestamp DATETIME
    );


INSERT INTO transactions VALUES
        (1,101,1,100,'2022-09-25 12:00:00'),
        (2,101,1,100,'2022-09-25 12:08:00'),
        (3,101,1,100,'2022-09-25 12:28:00'),
        (4,102,2,300,'2022-09-25 12:00:00'),
        (5,102,2,400,'2022-09-25 14:00:00');


-- Solution:

SELECT COUNT(DATEDIFF(MINUTE,transaction_timestamp,repeated_transaction)) as payment_count
FROM(
SELECT *,
    LEAD(transaction_timestamp) OVER(PARTITION BY merchant_id,credit_card_id ORDER BY transaction_timestamp) as repeated_transaction
 FROM transactions
)x
WHERE DATEDIFF(MINUTE,transaction_timestamp,repeated_transaction) <= 10 AND repeated_transaction IS NOT NULL



-- Q.87 Write a SQL Query to find the bad experience rate in the first 14 days for new users who signed 
-- up in June 2022. Output the percentage of bad experience rounded to 2 decimal places.


CREATE TABLE orders(
        order_id INT,
        customer_id INT,
        trip_id INT,
        status ENUM('COMPLETED SUCCESSFULLY','COMPLETED INCORRECTLY','NEVER_RECEIVED'),
        order_timestamp VARCHAR(30)
    );


INSERT INTO orders VALUES  
        (727424,8472,100463,'COMPLETED SUCCESSFULLY','06-05-2022 09:12:00'),
        (242513,2341,100482,'COMPLETED INCORRECTLY','06-05-2022 14:40:00'),
        (141367,1314,100362,'COMPLETED INCORRECTLY','06-07-2022 15:03:00'),
        (582193,5421,100657,'NEVER_RECEIVED','07-07-2022 15:22:00'),
        (253613,1314,100213,'COMPLETED SUCCESSFULLY','06-12-2022 13:43:00');


CREATE TABLE trips(
        dasher_id INT,
        trip_id INT,
        estimated_delivery_timestamp VARCHAR(25),
        actual_delivery_timestamp VARCHAR(25)
    );


INSERT INTO TRIPS VALUES 
        (101,100463,'06-05-2022 09:42:00','06-05-2022 09:38:00'),
        (102,100482,'06-05-2022 15:10:00','06-05-2022 15:46:00'),
        (101,100362,'06-07-2022 15:33:00','06-07-2022 16:45:00'),
        (102,100657,'07-07-2022 15:52:00',NULL),
        (103,100213,'06-12-2022 14:13:00','06-12-2022 14:10:00');


CREATE TABLE customers(
        customer_id INT,
        signup_timestamp VARCHAR(30)
    );


INSERT INTO customers VALUES    
        (8472,'05-30-2022 00:00:00'),
        (2341,'06-01-2022 00:00:00'),
        (1314,'06-03-2022 00:00:00'),
        (1435,'06-05-2022 00:00:00'),
        (5421,'06-07-2022 00:00:00');


-- Solution(Required modification to get the exact output and I will modify it soon):

WITH total_order AS(
SELECT COUNT(*) as t
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
JOIN trips t ON o.trip_id = t.trip_id
WHERE MONTH(c.signup_timestamp) = 6
),
bad_experience AS(
SELECT COUNT(*) as b
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
JOIN trips t ON o.trip_id = t.trip_id
WHERE MONTH(c.signup_timestamp) = 6 AND o.[status] IN ('COMPLETED INCORRECTLY','NEVER_RECEIVED')
)
SELECT ROUND((b/t) * 100,2) AS per
FROM total_order,bad_experience


-- Q.88 SAME AS 68

-- Q.89 SAME AS 55

-- Q.90 Write an SQL Query to report the median of all the numbers in the database 
-- after decompressing the numbers table. Round the median to one decimal point.


CREATE TABLE numbers(
        num INT,
        frequency INT
    );


INSERT INTO numbers VALUES  
        (0,7),
        (1,1),
        (2,3),
        (3,1);


-- Solution:[Skipped]:[Will do it soon]


-- Q.91 Write an SQL Query to report the comparison result (higher/lower/same) of the average salary of 
-- employees in a department to the companys average salary. Return the result table in any order.


CREATE TABLE salary(
        id INT,
        employee_id INT,
        amount INT,
        paydate DATE,
        PRIMARY KEY(id)
    );


CREATE TABLE employee(
        employee_id INT,
        department_id INT,
        PRIMARY KEY(employee_id)
    );


INSERT INTO salary VALUES
        (1,1,9000,'2017-03-31'),
        (2,2,6000,'2017-03-31'),
        (3,3,10000,'2017-03-31'),
        (4,1,7000,'2017-02-28'),
        (5,2,6000,'2017-02-28'),
        (6,3,8000,'2017-02-28');


INSERT INTO employee VALUES
        (1,1),
        (2,2),
        (3,2);
        


-- Solution:

with cte AS(
SELECT  department_id,pay_month,
    row_number() OVER(PARTITION BY pay_month,department_id) as rn,
    CASE
        WHEN average_department_salary > average_salary THEN 'HIGHER'
        WHEN average_department_salary < average_salary THEN 'LOWER'
        WHEN average_department_salary = average_salary THEN 'SAME'
    END AS comparison
FROM (
    SELECT e.department_id AS department_id, s.paydate AS pay_month,
        AVG(s.amount) OVER (PARTITION BY MONTH(s.paydate), e.department_id) AS average_department_salary,
        AVG(s.amount) OVER (PARTITION BY MONTH(s.paydate)) AS average_salary
    FROM salary s
    JOIN employee3 e ON s.employee_id = e.employee_id
) x
)
SELECT department_id,pay_month,comparison FROM cte WHERE rn=1
ORDER BY pay_month ;



-- Q.92 Write an SQL Query to report for each install date, the number of players 
-- that installed the game on that day, and the day one retention.


CREATE TABLE activity(
        player_id INT,
        device_id INT,
        event_date DATE,
        games_played INT,
        PRIMARY KEY(player_id, event_date)
    );


INSERT INTO activity VALUES 
        (1,2,'2016-03-01',5),
        (1,2,'2016-03-02',6),
        (2,3,'2017-06-25',1),
        (3,1,'2016-03-01',0),
        (3,4,'2018-07-03',5);


-- Solution:

SELECT DISTINCT event_date as install_dt,total_login as installs,round(log_back/total_login,2) as Day1_retention
 FROM(
SELECT
   DISTINCT player_id,
    event_date,
    COALESCE(CASE
        WHEN LEAD(event_date) OVER (PARTITION BY player_id) - event_date = 1 THEN 1 END,0) AS log_back,
    COUNT(*) OVER (PARTITION BY event_date) AS total_login,
    row_number() OVER(PARTITION BY player_id) as rn
FROM activity1
)x WHERE rn = 1
GROUP BY event_date,total_login


-- Q.93 SAME AS 50

-- Q.94 Write an SQL Query to report the students (student_id, student_name) being -- Quiet in all exams. 
-- Do not return the student who has never taken any exam.


CREATE TABLE student(
        student_id INT,
        student_name VARCHAR(20),
        PRIMARY KEY(student_id)
    );


CREATE TABLE exam(
        exam_id INT,
        student_id INT,
        score INT,
        PRIMARY KEY(exam_id,student_id)
    );


INSERT INTO student VALUES 
        (1,'DANIEL'),
        (2,'JADE'),
        (3,'STELLA'),
        (4,'JONATHAN'),
        (5,'WILL');


INSERT INTO exam VALUES
        (10,1,70),
        (10,2,80),
        (10,3,90),
        (20,1,80),
        (30,1,70),
        (30,3,80),
        (30,4,90),
        (40,1,60),
        (40,2,70),
        (40,4,80);

-- Solution:

WITH cte AS(
SELECT student_id
FROM(
SELECT *,
    max(score) OVER(PARTITION BY exam_id) as max_score,
    min(score) OVER(PARTITION BY exam_id) as min_score
FROM exam
)x 
WHERE score !=max_score and score !=min_score
),
cte1 AS(
    SELECT
     case when score = max(score) OVER(PARTITION BY exam_id) or score = min(score) OVER(PARTITION BY exam_id) then student_id end as max_or_min
    FROM exam
)
SELECT c.student_id,s.student_name FROM cte c JOIN student1 s ON c.student_id = s.student_id
WHERE c.student_id NOT in(SELECT max_or_min from cte1 where max_or_min  is not null)
GROUP BY c.student_id



-- Q.95 SAME AS 94



-- Q.96 Write a query to output the user id, song id, and cumulative count of song plays as of 4 August 2022 
-- sorted in descending order.


CREATE TABLE songs_history(
	history_id INT,
	user_id INT,
	song_id INT,
	song_plays INT
	);


INSERT INTO songs_history VALUES
	(10011,777,1238,11),
	(12452,695,4520,1);


CREATE TABLE songs_weekly(
	user_id INT,
	song_id INT,
	listen_time VARCHAR(25)
	);


INSERT INTO songs_weekly VALUES
        (777,1238,'08-01-2022 12:00:00'),
	(695,4520,'08-04-2022 08:00:00'),
	(125,9630,'08-04-2022 16:00:00'),
	(695,9852,'08-07-2022 12:00:00');


-- Solution:

SELECT sw.user_id,sw.song_id,COALESCE(sh.song_plays,0) + count(sw.user_id) as song_plays
FROM songs_history sh RIGHT JOIN songs_weekly sw ON sh.user_id = sw.user_id
WHERE DATE_FORMAT(STR_TO_DATE(sw.listen_time,'%m/%d/%Y'),'%m/%d/%Y') <= '08/04/2022'
GROUP BY sw.user_id,sw.song_id,sh.song_plays
ORDER BY song_plays DESC



-- Q.97 Write a query to find the confirmation rate of users who confirmed their signups with text messages. 
-- Round the result to 2 decimal places.


CREATE TABLE emails(
	email_id INT,
	user_id INT,
	signup_date DATETIME
	);


INSERT INTO emails VALUES
	(125,7771,'2022-06-14 00:00:00'),
	(236,6950,'2022-07-01 00:00:00'),
	(433,1052,'2022-07-09 00:00:00');


CREATE TABLE texts(
	text_id INT,
	email_id INT,
	signup_action VARCHAR(20)
	);


INSERT INTO texts VALUES
	(6878,125,'CONFIRMED'),
	(6920,236,'NOT CONFIRMED'),
	(6994,236,'CONFIRMED');


-- Solution:

SELECT ROUND(sum(IF(t.signup_action = 'CONFIRMED',1,0)) / count(distinct e.email_id),2) AS confirmation_rate
FROM emails e left JOIN texts t ON e.email_id = t.email_id


-- Q.98 Calculate the 3-day rolling average of tweets published by each user for each date 
-- that a tweet was posted. Output the user id, tweet date, and rolling averages rounded to 2 decimal places.


CREATE TABLE tweets(
	tweet_id INT,
	user_id INT,
	tweet_date DATETIME
	);


INSERT INTO TWEETS VALUES
	(214252,111,'2022-06-01 12:00:00'),
	(739252,111,'2022-06-01 12:00:00'),
	(846402,111,'2022-06-02 12:00:00'),
	(241425,254,'2022-06-02 12:00:00'),
	(137374,111,'2022-06-04 12:00:00');


-- Solution:

SELECT    
  user_id,    
  tweet_date,   
  ROUND(AVG(tweet_count) OVER (PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS rolling_avg_3d
FROM(
SELECT *,
    count(tweet_date) OVER(PARTITION BY tweet_date,user_id) as tweet_count
FROM tweets
)t
GROUP BY user_id,tweet_date;



-- Q.99 Write a query to obtain a breakdown of the time spent sending vs. opening snaps 
-- (as a percentage of total time spent on these activities) for each age group.


CREATE TABLE activities(
	activity_id INT,
	user_id INT,
	activity_type ENUM('SEND','OPEN','CHAT'),
	time_spent FLOAT,
	activity_date varchar(25)
	);


INSERT INTO activities VALUES
	(7274,123,'OPEN',4.50,'06-22-2022 12:00:00'),
	(2425,123,'SEND',3.50,'06-22-2022 12:00:00'),
	(1413,456,'SEND',5.67,'06-23-2022 12:00:00'),
	(1414,789,'CHAT',11.00,'06-25-2022 12:00:00'),
	(2536,456,'OPEN',3.00,'06-25-2022 12:00:00');


CREATE TABLE age_breakdown(
        user_id INT,
        age_bucket ENUM('21-25','26-30','31-35')
	);


INSERT INTO age_breakdown VALUES
        (123,'31-35'),
        (456,'26-30'),
        (789,'21-25');
        


-- Solution:

WITH cte AS (
    SELECT 
        act.user_id AS user_id,
        act.activity_type AS activity_type,
        ab.age_bucket AS age_bucket,
        act.time_spent AS time_spent,
        SUM(time_spent) OVER (PARTITION BY act.user_id) AS total_time_spent
    FROM 
        activities act
    JOIN 
        age_breakdown ab ON act.user_id = ab.user_id
    WHERE 
        act.activity_type IN ('OPEN', 'SEND')
)
SELECT age_bucket,
    max(CASE
        WHEN activity_type = 'SEND' THEN ROUND((time_spent / total_time_spent) * 100, 2)
    END )AS send_perc,
    max(CASE
        WHEN activity_type = 'OPEN' THEN ROUND((time_spent / total_time_spent) * 100, 2)
    END )AS open_perc
FROM cte
GROUP BY age_bucket;



-- Q.100 Write a query to return the IDs of these LinkedIn power creators in ascending order.


CREATE TABLE personal_profiles(
	profile_id INT,
	name VARCHAR(20),
	followers INT
	);


INSERT INTO personal_profiles VALUES
	(1,'NICK SINGH',92000),
	(2,'ZACH WILSON',199000),
	(3,'DALIANA LIU',171000),
	(4,'RAVIT JAIN',107000),
	(5,'VIN VASHISHTA',139000),
	(6,'SUSAN WOJCICKI',39000);


CREATE TABLE employee_company(
	personal_profile_id INT,
	company_id INT
	);


INSERT INTO employee_company VALUES
	(1,4),
	(1,9),
	(2,2),
	(3,1),
	(4,3),
	(5,6),
	(6,5);


CREATE TABLE company_pages(
	company_id INT,
	name VARCHAR(30),
	followers INT
	);


INSERT INTO company_pages VALUES
	(1,'THE DATA SCIENCE PODCAST',8000),
        (2,'AIRBNB',700000),
	(3,'THE RAVIT SHOW',6000),
	(4,'DATA LEMUR',200),
	(5,'YOUTUBE',16000000),
	(6,'DATASCIENCE.VIN',4500),
	(9,'ACE THE DATA SCIENCE INTERVIEW',4479);


-- Solution:

SELECT profile_id
FROM (
    SELECT
        p.profile_id AS profile_id,
        p.followers AS profile_followers,
        MAX(c.followers) OVER (PARTITION BY p.profile_id) AS max_company_followers
    FROM
        personal_profiles p
    JOIN
        employee_company e ON p.profile_id = e.personal_profile_id
    JOIN
        company_pages c ON e.company_id = c.company_id
) AS pec
WHERE profile_followers > max_company_followers
GROUP BY profile_id;
