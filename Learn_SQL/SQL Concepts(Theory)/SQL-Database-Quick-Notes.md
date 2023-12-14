> [!NOTE]
> This is a handy SQL guide I created for my project interviews. It gives a quick rundown of key SQL concepts that often come up in interviews. Feel free to tweak and expand it with more general concepts for a fast reference.

### Database

A **database** is a collection of data that is organized and stored in a way that makes it easy to access, manage, and update.

### DBMS (Database Management System)

A **DBMS** is a software tool that allows users to manage a database. It acts as an interface between the user and the database.

### RDBMS (Relational Database Management System)

An **RDBMS** is a software system that manages and organizes data in a relational database. RDBMS is a common type of database that stores data in tables.

## Operator

*SQL EXISTS Operator*

The `EXISTS` operator is used to test for the existence of any record in a subquery. It returns `TRUE` if the subquery returns one or more records.

#### Difference between IN and EXISTS

- **IN**: Preferred when there is a small list of static values or the inner query returns very few rows.
  
- **EXISTS**: Preferred when checking the existence of values in another table or when checking against more than one column.

#### Difference between ANY and EXISTS

- **ANY**: Similar to EXISTS, but the query execution time may be longer.

- **EXISTS**: Typically faster, as it first checks throughout the table for all records that match and then executes.

## Join

The `JOIN` clause is used to combine/retrieve data from multiple tables based on a related column between them.

#### **Types of Join**

1. **Inner Join (Default Join)**
2. **Outer Join**
   - Left Outer Join (Left Join)
   - Right Outer Join (Right Join)
   - Full Outer Join
3. **Self Join**
4. **Cross Join**
5. **Natural Join**

#### **Explanation**

1. **Inner Join**: Retrieves data from both tables based on a common column, fetching only records with matching values in both tables.

2. **Left Join**: Returns all records from the left table and matched records from the right table. When no match is found, columns from the right table contain `NULL`.

3. **Right Join**: Similar to the left join but returns all rows from the right table. Columns from the left table contain `NULL` when no match is found.

4. **Full Outer Join**: Combines results of both left and right outer joins, returning all rows from both tables.

5. **Self Join**: Joins a table to itself, useful for comparing two columns within the same table.

## Sub-query

In simplest terms, a subquery is a SQL query placed inside another query. It breaks down complex problems into smaller, more manageable parts. There are four types of subqueries: scalar subquery, multi-row subquery, correlated subquery, and nested subquery.

#### **Scalar Subquery**

A scalar subquery returns a single value, often used for calculations or comparisons.

*Example:*

```sql
SELECT *
FROM emp
WHERE sal > (
    SELECT AVG(sal)
    FROM emp
);
```

#### Multi-row Subquery

A **multi-row subquery** is a type of subquery that returns either multiple rows and multiple columns or a single column with multiple rows.

**Example of Multiple Rows and Multiple Columns**
Find the employees who earn the highest salary in each department

> Suppose we want to find the employees who earn the highest salary 
> in each department. We can use a multi-row subquery for this.

```sql
SELECT * 
FROM emp
WHERE (dept_name,sal) IN( SELECT dept_name,max(sal)
			FROM emp
			GROUP BY dept_name)
```

**Examples of Single Column and Multiple Rows**
Find the department which doesn't have any any employees

>Suppose we want to find the department that doesn't have any  
> employees. We can use a subquery with the `NOT EXISTS` clause.

```sql
SELECT *
FROM dept d
WHERE NOT EXISTS (
    SELECT dept_name 
    FROM emp e 
    WHERE d.dept_name = e.dept_name
);

```
#### Correlated Subquery

A **correlated subquery** is related to the outer query, and the inner query is executed for each row of the outer query. It uses values from the outer query in its search conditions.

**Example 1: Find Employees Earning More Than the Average Salary in Each Department**

```sql
SELECT *
FROM emp e1
WHERE sal > (
    SELECT AVG(sal)
    FROM emp e2
    WHERE e1.dept_id = e2.dept_id
);
```
**Example_2: Find the department which doesn't have any employees**
```sql
SELECT *
FROM dept d
WHERE NOT EXISTS(SELECT dept_name 
		FROM emp e 
		WHERE d.dept_name = e.dept_name)
```
#### Nested Subquery

A **nested subquery** is a subquery that is placed within another subquery.

**Example: Find Stores Whose Sales Are Better Than the Average Sales Across All Stores**

To find stores whose sales are better than the average sales across all stores, we can use a nested subquery with the following steps:

1. Find the total sales for each store.
2. Find the average sales from all the stores.
3. Compare the total sales for each store with the average sales.

```sql
SELECT *
FROM (
    SELECT store_name, SUM(price) as total_sales
    FROM sales
    GROUP BY store_name
) sales
JOIN (
    SELECT AVG(total_sales) as sales_avg
    FROM (
        SELECT store_name, SUM(price) as total_sales
        FROM sales
        GROUP BY store_name
    ) x
) avg_sales
ON sales.total_sales > avg_sales.sales_avg;
```
## UNION & UNION ALL

The `UNION` and `UNION ALL` operators in SQL are used to combine the result sets of two or more SELECT statements into a single result set. However, there is a key difference between them:

- **UNION**: Returns only distinct or unique rows and removes all duplicate rows from the result set.

- **UNION ALL**: Returns all rows and does not remove any duplicate values. It includes all rows from each SELECT statement.

## ACID

**ACID** properties are set of properties that guarantuees a reliable and consistent transaction processing in database system.And it stands for ATOMICITY,CONSISTENCY,ISOLATION AND DURABILITY.


- **ATOMICITY**
Atomicity ensures that a transaction is treated as a single,indivisible unit of work. It guarantees that either all the operations within a transaction are successfully completed and applied to the database or none of them are. If any part of the transactions fails the entire transanction will get fail and the database will be unchanged. Atomicity basically maintains data integrity and consistency.

- **CONSISTENCY**
Consistency ensures that the data is in consistent state when a transaction starts and when it ends. Suppose a person A wants to transfer some funds to the account of the person B then the consistency property ensures that the total value of funds in both the account is the same at the start and end of each transaction. It is not possible to leave the database in an inconsistent state.

- **ISOLATION**
	Isolation ensures that the changes made by one transaction are not visible to other transactions until the first transaction is completed(committed). It prevents the interference and ensures that the transactions operate independently, maintaining the integrity and reliability of the data.


- **DURABILITY**
Durability ensures that once a transaction is committed, it's changes are permanent and will survive any subsequent failutres, such as power outages or system crashes.

## NORMALIZATION

**Normalization** is a process in database design that helps to eliminates data redudancy and improve the data integrity by organizing the data into well structured and efficient relational database tables.The normalization process follows a set of rules known as normal forms.

#### 1. First Normal Form (1NF):
In **1NF**, data is organized into tables with rows and columns and each column contains only atomic values. It eliminates duplicate rows and ensures that each row uniquely indentifies an entity.

**Example**
Consider having a separate table for customer information and orders with each row representing a single customer or order.

#### 2. Second Normal Form (2NF)

**2NF** builds on 1NF, and in this form, a table must satisfy 1NF, and all non-key attributes (columns) must depend fully on the entire primary key.

**Example**
Splitting a table with customer details and their respective orders into separate tables for customers and orders.

## PRIMARY KEY
- Primary key constraint is used to uniquely identify a row in a table. And it ensures that there are now duplicate rows. It can be created on single column or on multiple column.

- Where as foreign key establishes the connection between two tables based on the values of a column or set of columns. It defines a column or set of columns in a table that refers to the primary key of another table.


## STORED PROCEDURE
- A stored procedure is a set of sql statements that we can save,so the code can be reused over and over again. 
- It is like a reusable script or a program within the database that performs a specific task or set of tasks.

## VIEW
- View is one of the database object and it is like a virtual table that represents the result set of a stored query and it doesn't store the output of a particular query — it stores the query itself.
- view can be queried like a regular database table.

## CTE (Common Table Expression)
- A Common Table Expression (CTE) in SQL is a temporary result set.And it's life span is only during the execution of the query. 
- It helps to make our query more readable and enhance the code reusability.

## Stored Procedure vs Functions:
1. Stored Procedures are compiled once and stored in executable form, but functions are compiled and executed every time whenever they are called.

2. The function must return a value, but in Stored Procedure, it is optional. Even a procedure can return zero or n values.

3. Functions can have only input parameters, whereas Procedures can have input or output parameters.

4. Functions can be called from Procedure, whereas Procedures cannot be called from a Function.

### Window Function:
In SQL, a window function is a function that performs calculations over a particular window (set of rows).

#### Frame Clause:
- In SQL, the frame clause is used with window and analytic functions. 
- The frame clause defines a subset of rows in the current partition to which the window function is applied.
- This subset of rows is called a frame.

#### First_Value:
The `FIRST_VALUE()` function is a window function that returns the first value in an ordered partition of a result set.

#### Last_Value:
The `LAST_VALUE()` function is a window function that returns the last value in an ordered partition of a result set.

#### Difference between `RANK()` and `DENSE_RANK()`:
- `RANK()` assigns the same rank to rows with equal values, leaving gaps.
- `DENSE_RANK()` assigns the same rank to equal values without gaps, resulting in consecutive ranks.

#### NTILE():
The `NTILE()` function is a window function that divides sorted rows of a partition into a specified number of equal size buckets or groups.

#### Percent_Rank():
- In SQL, the `PERCENT_RANK()` function is a window function that calculates the percentile ranking of rows in a result set.
- The function returns a percentile ranking number that ranges from zero to one.
  
## Indexing
Index is a powerful technique in database system which helps to improve the query performance. It retrieves the data from the table more quickly than otherwise. It acts as a pointer or reference to the actual data stored in database table.

- Suppose there is a table called as "Employee". And in that table we frequently access the department column. So we can create an index on department column so that the index will store the sorted values of the department column and the corresponding pointers to the actual data rows,in future if we want to retrieve any data based on a particular department then instead of scanning all the table database will access the relevant rows using the index which results faster query execution.

## Case When Statement
- The CASE statement in SQL is used to handle if/then logic. 
- It's similar to the IF-THEN statement in any other programming language.
- The case statement in SQL returns a value on a specified condition. 
- We can use a Case statement in select queries along with Where, Order By, and Group By clause. 

#### Find the Nth Highest Salary:(N is the required rank which you want)

*1st Method*
```sql
SELECT * 
FROM Emp e1
WHERE N - 1 = (SELECT COUNT(DISTINCT sal)
	       FROM Emp e2
	       WHERE e2.sal > e1.sal)
```
*2nd Method*
```sql
SELECT * 
FROM Emp 
WHERE sal = (
SELECT DISTINCT(sal) as salary
FROM Emp
ORDER BY sal DESC
LIMIT 1 OFFSET N-1
)
```
*3rd Method*
```sql
SELECT emp_id,emp_name,sal
FROM(
SELECT *,
 DENSE_RANK() OVER(ORDER BY sal DESC) as rnk
FROM emp
)e 
WHERE rnk = N
```

***Question: Query to find out employees that earn more than their managers***
```sql
SELECT emp.*
FROM employees emp
JOIN employees mgr ON emp.manager_id = mgr.employee_id
WHERE emp.salary > mgr.salary;
```