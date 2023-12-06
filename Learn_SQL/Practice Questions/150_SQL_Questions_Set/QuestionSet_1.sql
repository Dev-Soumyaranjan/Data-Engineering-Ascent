-- I have done question number 1-16 in Hackerrank. So I am starting from the Question number 17


-- Q.17 Write an SQL query that reports the products that were only sold in the first quarter of 2019. 
-- That is, between 2019-01-01 and 2019-03-31 inclusive. Return the result table in any order.


CREATE TABLE product(
        product_id INT,
        product_name VARCHAR(20),
        unit_price INT,
        PRIMARY KEY(product_id)
	);


INSERT INTO product VALUES
        (1,'S8',1000),
        (2,'G4',800),
        (3,'iPhone',1400);


CREATE TABLE sales(
        seller_id INT,
        product_id INT,
        buyer_id INT,
        sales_date DATE,
        quantity INT,
        price INT,
        CONSTRAINT foriegn_key FOREIGN KEY(product_id) REFERENCES product(product_id)       
	);


INSERT INTO sales VALUES
        (1,1,1,'2019-01-21',2,2000),
        (1,2,2,'2019-02-17',1,800),
        (2,2,3,'2019-06-02',1,800),
        (3,3,4,'2019-05-13',2,2800);

--Solutions:

-- Approach:1

SELECT p.product_id,p.product_name FROM product_table p 
JOIN sales s
on p.product_id = s.product_id
where s.product_id not in (SELECT product_id from sales  where sale_date > '2019-03-31' GROUP by product_id having count(product_id) >= 1) and s.sale_date BETWEEN '2019-01-01' and '2019-03-31' 

-- Approach:2

WITH cte1 AS(
  SELECT p.product_id as pid ,p.product_name as pname ,s.sales_date as saleDate
from product_table p 
join sales s 
on p.product_id = s.product_id
WHERE s.sales_date BETWEEN '2019-01-01' and '2019-03-31' 
) 
SELECT pid,pname
from cte1 WHERE saleDate < '2019-01-31'


-- Q.19 Write an SQL query to find the percentage of immediate orders in the table, 
-- rounded to 2 decimal places.


CREATE TABLE delivery(
        delivery_id INT,
        customer_id INT,
        order_date DATE,
        customer_preferred_delivery_date DATE
        
	);


INSERT INTO delivery VALUES
        (1,1,'2019-08-01','2019-08-02'),
        (2,5,'2019-08-02','2019-08-02'),
        (3,1,'2019-08-11','2019-08-11'),
        (4,3,'2019-08-24','2019-08-26'),
        (5,4,'2019-08-21','2019-08-22'),
        (6,2,'2019-07-11','2019-08-13');

--Solution:

with immediate_order AS(
         SELECT count(*) as no_of_immediate_order
         FROM Delivery WHERE order_date = customer_preferred_delivery_date
),
total_order AS(
    SELECT count(*) as total_order
    FROM Delivery
)

SELECT cast(((immediate_order.no_of_immediate_order / total_order.total_order) * 100) as DECIMAL(10,2)) as immediate_percentage FROM immediate_order,total_order



-- Q.20 Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
-- Return the result table ordered by ctr in descending order and by ad_id in 
-- ascending order in case of a tie.

CREATE TABLE Ads(
    ad_id int,
    user_id int,
    action ENUM('Clicked', 'Viewed', 'Ignored'),
    PRIMARY KEY (ad_id, user_id)
)

INSERT INTO Ads(ad_id,user_id,action) VALUES(1,1,'Clicked'),
                                            (2,2,'Clicked'),
                                            (3,3,'Viewed'),
                                            (5,5,'Ignored'),
                                            (1,7,'Ignored'),
                                            (2,7,'Viewed'),
                                            (3,5,'Clicked'),
                                            (1,4,'Viewed'),
                                            (2,11,'Viewed'),
                                            (1,2,'Clicked')


-- Solution:

WITH count_action AS (
    SELECT
        ad_id,
        SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) AS Total_ad_Clicks,
        SUM(CASE WHEN action = 'Viewed' THEN 1 ELSE 0 END) AS Total_ad_views
    FROM
        Ads
    WHERE
        action IN ('Clicked', 'Viewed')
    GROUP BY
        ad_id
)

SELECT
    ad_id,
    CASE
        WHEN Total_ad_Clicks + Total_ad_views = 0 THEN 0
        ELSE ROUND((Total_ad_Clicks * 100.0) / (Total_ad_Clicks + Total_ad_views), 2)
    END AS ctr
FROM
    count_action
ORDER BY
    ctr DESC,
    ad_id;



-- Q.21 Write an SQL query to find the team size of each of the employees.


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

Select e1.employee_id,count(*) as team_size
from employee1 e1 
join employee1 e2
on e1.team_id=e2.team_id
group by e1.employee_id
order by e1.employee_id



-- Q.22 Write an SQL query to find the type of weather in each country for November 2019. The type of weather is:
-- ● Cold if the average weather_state is less than or equal 15,
-- ● Hot if the average weather_state is greater than or equal to 25, and
-- ● Warm otherwise.
-- Return result table in any order.


CREATE TABLE countries(
        country_id INT,
        country_name VARCHAR(20),
        PRIMARY KEY(country_id)
	);


INSERT INTO countries VALUES
        (2, 'USA'),
        (3, 'AUSTRALIA'),
        (7, 'PERU'),
        (5, 'CHINA'),
        (8, 'MOROCCO'),
        (9, 'SPAIN');


CREATE TABLE weather(
        country_id INT,
        weather_state INT,
        day DATE,
        PRIMARY KEY(country_id, day) 
	);


INSERT INTO weather VALUES
        (2,15,'2019-11-01'),
        (2,12,'2019-10-28'),
        (2,12,'2019-10-27'),
        (3,-2,'2019-11-10'),
        (3,0,'2019-11-11'),
        (3,3,'2019-11-12'),
        (5,16,'2019-11-07'),
        (5,18,'2019-10-09'),
        (5,21,'2019-10-23'),
        (7,25,'2019-11-08'),
        (7,22,'2019-12-01'),
        (7,20,'2019-12-02'),
        (8,25,'2019-11-05'),
        (8,27,'2019-11-15'),
        (8,31,'2019-11-25'),
        (9,7,'2019-10-23'),
        (9,3,'2019-12-23');

--Solution:

SELECT c.country_name,
       CASE 
           WHEN avg(w.weather_state) <= 15 THEN 'Cold'
           WHEN avg(w.weather_state) >= 25 THEN 'Hot'
           ELSE 'Warm'
       END AS weather_type
FROM countries c
JOIN weather w ON c.country_id = w.country_id
WHERE MONTH(w.day) = 11
GROUP BY c.country_name
ORDER BY weather_type;



-- Q.23 Write an SQL query to find the average selling price for each product. 
-- average_price should be rounded to 2 decimal places.


CREATE TABLE prices(
        product_id INT,
        start_date DATE,
        end_date DATE,
        price INT,
        PRIMARY KEY(product_id, start_date, end_date)
	);


INSERT INTO prices VALUES
        (1,'2019-02-17','2019-02-28',5),
        (1,'2019-03-01','2019-03-22',20),
        (2,'2019-02-01','2019-02-20',15),
        (2,'2019-02-21','2019-03-31',30);


CREATE TABLE units_sold(
        product_id INT,
        purchase_date DATE,
        units INT
	);


INSERT INTO units_sold VALUES
        (1,'2019-02-25',100),
        (1,'2019-03-01',15),
        (2,'2019-02-10',200),
        (2,'2019-02-22',30);

--Solution:

SELECT
    p.product_id,
    CAST(SUM(p.price * u.units) / SUM(u.units) AS DECIMAL(10, 2)) AS average_price
FROM
    prices p
JOIN
    units_sold u ON p.product_id = u.product_id and purchase_date BETWEEN start_date and end_Date
GROUP BY
    p.product_id;
	


-- Q.24 Write an SQL query to report the first login date for each player. 
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
		
		
--Solution:

SELECT player_id,device_id
FROM(
    SELECT a.*,
    min(event_date) OVER(PARTITION BY player_id) as first_logged_in
    FROM activity_table a
)player_activity
where event_date = first_logged_in




-- Q.26 Write an SQL query to get the names of products that have at least 100 units 
-- ordered in February 2020 and their amount.


CREATE TABLE products(
        product_id INT,
        product_name VARCHAR(30),
        product_category VARCHAR(20),
        PRIMARY KEY(product_id)
	);


INSERT INTO products VALUES
        (1,'LEETCODE SOLUTIONS','BOOK'),
        (2,'JEWELS OF STRINGOLOGY','BOOK'),
        (3,'HP','LAPTOP'),
        (4,'LENOVO','LAPTOP'),
        (5,'LEETCODE KIT','T-SHIRT');


CREATE TABLE orders(
        product_id INT,
        order_date DATE,
        unit INT,
        FOREIGN KEY(product_id) REFERENCES products(product_id)
	);


INSERT INTO orders VALUES
        (1,'2020-02-05',60),
        (1,'2020-02-05',70),
        (2,'2020-01-05',30),
        (2,'2020-02-05',80),
        (3,'2020-02-05',2),
        (3,'2020-02-05',3),
        (4,'2020-03-05',20),
        (4,'2020-03-05',30),
        (4,'2020-03-05',60),
        (5,'2020-02-05',50),
        (5,'2020-02-05',50),
        (5,'2020-03-05',50);

-- Solution:

SELECT product_name,sum(unit) as unit
FROM products p 
JOIN orders o ON p.product_id = o.product_id and MONTH(o.order_date) = 2
GROUP BY product_name
HAVING unit >= 100



-- Q.27 Write an SQL query to find the users who have valid emails.


CREATE TABLE users(
		user_id INT,
		name VARCHAR(25),
		mail VARCHAR(25),
		PRIMARY KEY(user_id)
	);


INSERT INTO users VALUE 
        (1,'WINSTON','winston@leetcode.com'),
        (2,'JONATHAN','jonathonisgreat'),
        (3,'ANNABELLE','bella-@leetcode.com'),
        (4,'SALLY','sally.come@leetcode.com'),
        (5,'MARWAN','quarz-- 2020@leetcode.com'),
        (6,'DAVID','david45@gmail.com'),
        (7,'SHAPIRO','.shapo@leetcode.com');

--Solution(Solved in SQL Server):

SELECT user_id, name, mail
FROM users
WHERE mail LIKE '[a-zA-Z][a-zA-Z0-9_.-]%@leetcode.com' 
    AND mail NOT LIKE '%[#]%@leetcode.com' 



-- Q.28 Write an SQL query to report the customer_id and customer_name of customers who have spent 
-- at least $100 in each month of June and July 2020. Return the result table in any order.


CREATE TABLE customers(
        customer_id INT,
        name VARCHAR(20),
        country VARCHAR(20),
        PRIMARY KEY(customer_id)
	);


CREATE TABLE orders(
        order_id INT,
        customer_id INT,
        product_id INT,
        order_date DATE,
        quantity INT,
        PRIMARY KEY(order_id)
	);


CREATE TABLE products(
        product_id INT,
        description VARCHAR(20),
        price INT,
        PRIMARY KEY(product_id)
	);


INSERT INTO customers VALUES 
        (1,'WINSTON','USA'),
        (2,'JONATHON','PERU'),
        (3,'MOUSTAFA','EGYPT');


INSERT INTO products VALUES 
        (10,'LC PHONE',300),
        (20,'LC T-SHIRT',10),
        (30,'LC BOOK',45),
        (40,'LC KEYCHAIN',2);


INSERT INTO orders VALUES 
        (1,1,10,'2020-06-10',1),
        (2,1,20,'2020-07-01',1),
        (3,1,30,'2020-07-08',2),
        (4,2,10,'2020-06-15',2),
        (5,2,40,'2020-07-01',10),
        (6,3,20,'2020-06-24',2),
        (7,3,30,'2020-06-25',2),
        (9,3,30,'2020-05-08',3);


-- Solution(One of my most time taken Query):

SELECT customer_id,name
FROM(
SELECT c.customer_id, c.name, MONTH(o.order_date) AS order_month,
       SUM(p.price * o.quantity) OVER (PARTITION BY c.customer_id, MONTH(o.order_date)) AS total_spent
       FROM customers c 
       JOIN orders o ON c.customer_id = o.customer_id
       JOIN products p ON o.product_id = p.product_id
       WHERE MONTH(o.order_date) IN (6, 7)
) calculate_total_spent
WHERE total_spent >=100
GROUP BY customer_id,name
HAVING count(distinct order_month) = 2




-- Q.29 Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020. 
-- Return the result table in any order.


CREATE TABLE tv_program(
        program_date DATETIME,
        content_id INT,
        channel VARCHAR(20),
        PRIMARY KEY(program_date, content_id)
);


CREATE TABLE content(
        content_id INT,
        title VARCHAR(20),
        kids_content ENUM('Y','N'),
        content_type VARCHAR(20),
        PRIMARY KEY(content_id)
);


INSERT INTO content VALUES
        (1,'LEETCODE MOVIE', 'N','MOVIES'),
        (2,'ALG. FOR KidS', 'Y','SERIES'),
        (3,'DATABASE SOLS', 'N','SERIES'),
        (4,'ALADDIN', 'Y','MOVIES'),
        (5,'CINDERELLA', 'Y','MOVIES');
        

INSERT INTO tv_program VALUES
		('2020-06-10 18:00',1,'LC-channel'),
        ('2020-05-11 12:00',2,'LC-channel'),
        ('2020-05-12 12:00',3,'LC-channel'),
        ('2020-05-13 14:00',4,'DISNEY-CH'),
        ('2020-06-18 14:00',4,'DISNEY-CH'),
        ('2020-07-15 16:00',5,'DISNEY-CH');
		
-- Solution:

SELECT c.title
FROM content c 
JOIN tv_program t 
ON c.content_id = t.content_id
WHERE content_type = 'MOVIES' and c.kids_content = 'Y' and MONTH(t.program_date) = 6 


-- Q.30 Write an SQL query to find the npv of each query of the Queries table. 
-- Return the result table in any order.


CREATE TABLE npv(
        id INT,
        year INT,
        npv INT,
        PRIMARY KEY(id, year)
	);


CREATE TABLE queries(
        id INT,
        year INT,
        PRIMARY KEY(id, year)
	);


INSERT INTO npv VALUES
        (1,2018,100),
        (7,2020,30),
        (13,2019,40),
        (1,2019,113),
        (2,2008,121),
        (3,2009,12),
        (11,2020,99),
        (7,2019,0);


INSERT INTO queries VALUES
        (1,2019),
        (2,2008),
        (3,2009),
        (7,2018),
        (7,2019),
        (7,2020),
        (13,2019);

-- Solution:

SELECT q.id,q.year,COALESCE(n.npv,0)
FROM queries q 
LEFT JOIN npv n 
ON q.year= n.year and q.id = n.id
GROUP BY q.id,q.year,n.npv


-- Q.31 SAME AS 30


-- Q.32 Write an SQL query to show the unique id of each user, If a user does not have a 
-- unique id replace just show null. Return the result table in any order.


CREATE TABLE employees(
		id INT,
		name VARCHAR(20),
		PRIMARY KEY(id)
	);


CREATE TABLE employees_uni(
		id INT,
		unique_id INT,
		PRIMARY KEY(id, unique_id)
	);


INSERT INTO employees VALUES
		(1,'ALICE'),
		(7,'BOB'),
		(11,'MEIR'),
		(90,'WINSTON'),
		(3,'JONATHAN');


INSERT INTO employees_uni VALUES
		(3,1),
		(11,2),
		(90,3);


-- Solution:

SELECT eu.unique_id,emp.name 
FROM employees_uni eu 
RIGHT JOIN employees emp ON eu.id = emp.id 
ORDER BY emp.name




-- Q.33 Write an SQL query to report the distance travelled by each user. Return the result table ordered by travelled_distance 
-- in descending order, if two or more users travelled the same distance, order them by their name in ascending order.


CREATE TABLE users(
		id INT,
		name VARCHAR(20),
		PRIMARY KEY(id)
	);


INSERT INTO users VALUES
		(1,'ALICE'),
		(2,'BOB'),
		(3,'ALEX'),
		(4,'DONALD'),
		(7,'LEE'),
		(13,'JONATHON'),
		(19,'ELVIS');


CREATE TABLE rides(
        id INT,
        user_id INT,
        distance INT,
        PRIMARY KEY(id)
	);


INSERT INTO rides VALUES
        (1,1,120),
        (2,2,317),
        (3,3,222),
        (4,7,100),
        (5,13,312),
        (6,19,50),
        (7,7,120),
        (8,19,400),
        (9,7,230);


-- Solution:

SELECT u.name,COALESCE(r.travelled_distance,0)
FROM users u 
LEFT JOIN(
SELECT user_id,sum(distance) as travelled_distance
FROM rides
GROUP BY user_id) r 
ON u.id = r.user_id
ORDER BY r.travelled_distance DESC,name ASC


-- Q.34 SAME AS 26



-- Q.35 Write an SQL query to:

-- ● Find the name of the user who has rated the greatest number of movies. In case of a tie,
-- return the lexicographically smaller user name.
-- ● Find the movie name with the highest average rating in February 2020. In case of a tie, 
-- return the lexicographically smaller movie name.


CREATE TABLE users(
		user_id INT,
		name VARCHAR(20),
		PRIMARY KEY(user_id)
	);


INSERT INTO users VALUES
		(1,'DANIEL'),
		(2,'MONICA'),
		(3,'MARIA'),
		(4,'JAMES');


CREATE TABLE movies(
		movie_id INT,
		title VARCHAR(20),
		PRIMARY KEY(movie_id)
	);


INSERT INTO movies VALUES
		(1,'AVENGERS'),
		(2,'FROZEN 2'),
		(3,'JOKER');


CREATE TABLE movie_rating(
		movie_id INT,
		user_id INT,
		rating INT,
		created_at DATE,
		PRIMARY KEY(movie_id, user_id)
	);


INSERT INTO movie_rating VALUES
		(1,1,3,'2020-01-12'),
		(1,2,4,'2020-02-11'),
		(1,3,2,'2020-02-12'),
		(1,4,1,'2020-01-01'),
		(2,1,5,'2020-02-17'),
		(2,2,2,'2020-02-01'),
		(2,3,2,'2020-03-01'),
		(3,1,3,'2020-02-22'),
		(3,2,4,'2020-02-25');


-- Solution: I had skipped this number as table data was not available but I will do it soon 

-- Q.36 SAME AS 33



-- Q.37 SAME AS 32



-- Q.38 Write an SQL query to find the id and the name of all students who are enrolled 
-- in departments that no longer exist. Return the result table in any order.


CREATE TABLE departments(
		id INT,
		name VARCHAR(25),
		PRIMARY KEY(id)
	);


INSERT INTO departments VALUES
		(1,'ELECTRICAL ENGINEERING'),
		(7,'COMPUTER ENGINEERING'),
		(13,'BUSINESS ADMINISTRATION');


CREATE TABLE students(
		id INT,
		name VARCHAR(25),
		department_id INT,
		PRIMARY KEY(id)
	);


INSERT INTO students VALUES
		(23,'ALICE',1),
		(1,'BOB',7),
		(5,'JENNIFER',13),
		(2,'JOHN',14),
		(4,'JASMINE',77),
		(3,'STEVE',74),
		(6,'LUIS',1),
		(8,'JONATHON',7),
		(7,'DAIANA',33),
		(11,'MADELYNN',1);

-- Solution:

SELECT id,name 
FROM students 
where id not IN(
SELECT s.id
FROM students s
JOIN departments d ON s.department_id = d.id
GROUP BY s.id)
ORDER BY name


-- Q.39 Write an SQL query to report the number of calls and the total call duration between 
-- each pair of distinct persons (person1, person2) where person1 < person2.
-- Return the result table in any order.


CREATE TABLE calls(
		from_id INT,
		to_id INT,
		duration INT
	);


INSERT INTO calls VALUES
		(1,2,59),
		(2,1,11),
		(1,3,20),
		(3,4,100),
		(3,4,200),
		(3,4,200),
		(4,3,499);
		
-- Solution:

SELECT
    CASE WHEN form_id < to_id THEN form_id ELSE to_id END AS person1,
    CASE WHEN to_id > form_id THEN to_id ELSE form_id END AS person2,
    count(*) AS call_count,
    SUM(duration) AS total_duration
FROM calls
GROUP BY person1, person2;


-- Q.40 SAME AS 23


-- Q.41 Write an SQL query to report the number of cubic feet of volume the inventory 
-- occupies in each warehouse. Return the result table in any order.


CREATE TABLE warehouse(
		name VARCHAR(25),
		product_id INT,
		units INT,
		PRIMARY KEY(name,product_id)
	);


INSERT INTO warehouse VALUES
		('LCHOUSE1',1,1),
		('LCHOUSE1',2,10),
		('LCHOUSE1',3,5),
		('LCHOUSE2',1,2),
		('LCHOUSE2',2,2),
		('LCHOUSE3',4,1);


CREATE TABLE warehouse_products(
		product_id INT,
		product_name VARCHAR(25),
		width INT,
		length INT,
		height INT,
		PRIMARY KEY(product_id)
	);


INSERT INTO warehouse_products VALUES
		(1,'LC-TV',5,50,40),
		(2,'LC-KEYCHAIN',5,5,5),
		(3,'LC-PHONE',2,10,10),
		(4,'LC-SHIRT',4,10,20);


-- Solution:

SELECT
    warehouse.name as name ,
    SUM(warehouse_products.width * warehouse_products.length * warehouse_products.height * warehouse.units) AS v
FROM
    warehouse
JOIN
    warehouse_products ON warehouse.product_id = warehouse_products.product_id
GROUP BY
    warehouse.name



-- Q.42 Write an SQL query to report the difference between the number of 
-- apples and oranges sold each day. Return the result table ordered by sale_date.


CREATE TABLE sales(
		sale_date DATE,
		fruit ENUM('APPLES','ORANGES'),
		sold_num INT,
		PRIMARY KEY(sale_date,fruit)
	);


INSERT INTO sales VALUES
		('2020-05-01','APPLES',10),
		('2020-05-01','ORANGES',8),
		('2020-05-02','APPLES',15),
		('2020-05-02','ORANGES',15),
		('2020-05-03','APPLES',20),
		('2020-05-03','ORANGES',0),
		('2020-05-04','APPLES',15),
		('2020-05-04','ORANGES',16);
		

-- Solution:

WITH appledata AS (
    SELECT * FROM sales_table
    WHERE fruit = 'APPLES'
),
orangedata AS (
    SELECT * FROM sales_table
    WHERE fruit = 'ORANGES'
)
SELECT appledata.sale_date, (appledata.sold_num - orangedata.sold_num) AS diff
FROM appledata
JOIN orangedata ON appledata.sale_date = orangedata.sale_date;


-- Q.43 Write an SQL query to report the fraction of players that logged in again on the day after the day 
-- they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players 
-- that logged in for at least two consecutive days starting from their first login date, 
-- then divide that number by the total number of players.

CREATE TABLE activity(
    player_id int,
    device_id int,
    event_date date,
    games_played int,
    PRIMARY KEY(player_id,event_date)
);
INSERT INTO activity (player_id, device_id, event_date, games_played)
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-03-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);

-- Solution:

with active_player as (
SELECT player_id as pid FROM activity
GROUP BY player_id
HAVING DATEDIFF(max(event_date),min(event_date)) = 1
),
total_player AS(
SELECT count(distinct player_id) as total_no_of_player
FROM activity
)
SELECT ROUND(count(pid) / total_no_of_player,2) AS fraction FROM 
active_player,total_player
GROUP BY pid,total_no_of_player


-- Q.44 Write an SQL query to report the managers with at least five direct reports.

CREATE TABLE employee(
		id INT,
		name VARCHAR(20),
		department VARCHAR(20),
		manager_id INT,
		PRIMARY KEY(id)
	);


INSERT INTO employee VALUES 
		(101,'JOHN','A',NULL),
		(102,'DAN','A',101),
		(103,'JAMES','A',101),
		(104,'AMY','A',101),
		(105,'ANNE','A',101),
		(106,'RON','A',101),
		(107,'BUTTLER','A',111),
		(108,'JIMMY','A',121),
		(111,'ROOT','A',NULL),
		(121,'POPE','A',NULL);
		

-- Solution:

-- Approache:1

with manager AS(
SELECT manager_id,count(manager_id) as no_of_direct_reports
FROM employee
GROUP BY manager_id
HAVING no_of_direct_reports >=5
)
SELECT name FROM employee
JOIN manager on employee.id = manager.manager_id

-- Approache:2

SELECT a.name
FROM employee a
JOIN employee b on a.id = b.manager_id
GROUP BY b.manager_id
HAVING count(b.manager_id) >=5


-- Q.45 Write an SQL query to report the respective department name and number of students majoring in 
-- each department for all departments in the department table (even ones with no current students). 
-- Return the result table ordered by student_number in descending order. In case of a tie, order 
-- them by dept_name alphabetically


CREATE TABLE department(
		dept_id INT,
		department_name VARCHAR(20),
		PRIMARY KEY(dept_id)
	);


CREATE TABLE student(
		student_id INT,
		student_name VARCHAR(20),
		gender VARCHAR(6),
		dept_id INT,
		PRIMARY KEY(student_id),
		FOREIGN KEY(dept_id) REFERENCES department(dept_id)
	);


INSERT INTO department VALUES 
		(1,'ENGINEERING'),
		(2,'SCIENCE'),
		(3,'LAW');
        
        
INSERT INTO student VALUES 
		(1,'JACK','M',1),
		(2,'JANE','F',1),
		(3,'MARK','M',2);


-- Solution:

SELECT d.department_name,COUNT(s.dept_id) AS no_of_students
FROM department d 
LEFT JOIN student s ON d.dept_id = s.dept_id
GROUP BY d.dept_name
ORDER BY no_of_students DESC;


-- Q.46 Write an SQL query to report the customer ids from the Customer table that bought 
-- all the products in the product table. Return the result table in any order.


CREATE TABLE customer(
		customer_id INT,
		product_key INT
	);


INSERT INTO customer VALUES 
		(1,5),
		(2,6),
		(3,5),
		(3,6),
		(1,6);


CREATE TABLE product(
		product_key INT,
	    PRIMARY KEY(product_key)
	);


INSERT INTO product VALUES 
		(5),
		(6);
		

-- Solution:

SELECT c.customer_id
FROM customer c 
JOIN product p ON  c.product_key = p.product_key
GROUP BY c.customer_id
HAVING count(p.product_key) = (SELECT count(distinct product_key) from product)



-- Q.47 Write an SQL query that reports the most experienced employees in each project. In case of a tie, 
-- report all employees with the maximum number of experience years. Return the result table in any order.


CREATE TABLE employee(
		employee_id INT,
		name VARCHAR(20),
		experience_years INT,
		PRIMARY KEY(employee_id)
	);


CREATE TABLE project(
		project_id INT,
		employee_id INT,
		PRIMARY KEY(project_id, employee_id)
	);


INSERT INTO employee VALUES 
		(1,'KHALED',3),
		(2,'ALI',2),
		(3,'JOHN',3),
		(4,'DOE',2);


INSERT INTO project VALUES 
		(1,1),
		(1,2),
		(1,3),
		(2,1),
		(2,4);
		

-- Solution:

SELECT project_id,employee_id FROM(
SELECT project_id,p.employee_id as employee_id,experience_years,
rank() OVER(PARTITION BY project_id ORDER BY experience_years desc) as rnk
FROM project p 
JOIN employee e ON p.employee_id = e.employee_id
) pdetails
WHERE rnk = 1


-- Q.48 Write an SQL query that reports the books that have sold less than 10 copies in the last year, 
-- excluding books that have been available for less than one month from today. Assume today is 2019-06-23.
-- Return the result table in any order.


CREATE TABLE books(
		book_id INT,
		name VARCHAR(20),
		available_from DATE,
		PRIMARY KEY(book_id)
	);
    
    
CREATE TABLE orders(
		order_id INT,
		book_id INT,
		quantity INT,
		dispatch_date DATE,
		PRIMARY KEY(order_id),
		FOREIGN KEY(book_id) REFERENCES books(book_id)
	);


INSERT INTO books VALUES 
		(1,"Kalila And Demna",'2010-01-01'),
		(2,"28 Letters",'2012-05-12'),
		(3,"The Hobbit",'2019-06-10'),
		(4,"13 Reasons Why",'2019-06-01'),
		(5,"The Hunger Games",'2008-09-21');


INSERT INTO orders VALUES 
		(1,1,2,'2018-07-26'),
		(2,1,1,'2018-11-05'),
		(3,3,8,'2019-06-11'), 
		(4,4,6,'2019-06-05'), 
		(5,4,5,'2019-06-20'), 
		(6,5,9,'2009-02-02'), 
		(7,5,8,'2010-04-13');
		

-- Solution: Skipped(But will do soon)


-- Q.49 Write a SQL query to find the highest grade with its corresponding course for each student. 
-- In case of a tie, you should find the course with the smallest course_id. Return the result table 
-- ordered by student_id in ascending order.


CREATE TABLE enrollments(
		student_id INT,
		course_id INT,
		grade INT,
		PRIMARY KEY(student_id,course_id)
    );


INSERT INTO enrollments VALUES 
		(2,2,95),
		(2,3,95),
		(1,1,90),
		(1,2,99),
		(3,1,80),
		(3,2,75),
		(3,3,82);
        
		
-- Solution:

with sdetails AS(
        SELECT student_id,course_id ,grade,
        row_number() over(partition by student_id order by grade desc,course_id asc) as rn
        FROM enrollments
) 
SELECT student_id,course_id ,grade from sdetails t2 where t2.rn = 1



-- Q.50 Write an SQL query to find the winner in each group. Return the result table in any order.


CREATE TABLE matches(
		match_id INT,
		first_player INT,
		second_player INT,
		first_player_goals INT,
		second_player_goals INT,
		PRIMARY KEY(match_id)
	);


CREATE TABLE players(
		player_id INT,
		group_id INT,
		PRIMARY KEY(player_id)
    );


INSERT INTO matches VALUES 
		(1,15,45,3,0),
		(2,30,25,1,2),
		(3,30,15,2,0),
		(4,40,20,5,2),
		(5,35,50,1,1);


INSERT INTO players VALUES 
		(15,1),
		(25,1),
		(30,1),
		(45,1),
		(10,2),
		(35,2),
		(50,2),
		(20,3),
		(40,3);


-- Solution:

with playerscore as (
SELECT group_id,player_id,first_player,second_player,max(first_player_goals) as host_player_score ,max(second_player_goals) as  guest_player_score,
    sum(CASE WHEN player_id = first_player then first_player_goals ELSE second_player_goals end) as scores,
row_number() OVER(PARTITION BY group_id ORDER BY sum(CASE WHEN player_id = first_player then first_player_goals ELSE second_player_goals end) desc) as rn
FROM players,matches
WHERE players.player_id = matches.first_player or players.player_id = matches.second_player
GROUP BY group_id,player_id,first_player_goals,second_player_goals,first_player,second_player
ORDER BY group_id
)
SELECT distinct group_id,player_id
FROM playerscore 
WHERE rn = 1

