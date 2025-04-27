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

SELECT p.product_id,p.product_name,s.price,s.sales_date FROM product p
inner join sales s
on p.product_id = s.product_id
where s.sales_date between '2019-01-01' and '2019-03-31' and p.product_id not in(select product_id from sales where sales_date > '2019-03-31');
