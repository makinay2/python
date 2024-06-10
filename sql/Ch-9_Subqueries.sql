USE BANK;
SHOW TABLES;
/*A subquery is a query contained within another SQL statement*/
/*always enclosedwithin parentheses*/
/*usually executed prior to the containing statement*/
/*subquery returns: A single row with a single column /Multiple rows with a single column /Multiple rows and columns*/
/*type of result set the subquery returns determines how it may be used*/

/*Subquery Types: 1- completely selfcontained or noncorrelated 2- correlated subqueries) */
/*update or delete statements ususally use correlated subqueries*/

/*------------------A single row with a single column*/
/*known as a scalar subquery and used whit (=, <>, <,>, <=, >=).*/
/*all accounts that were not opened by the head teller at the Woburn branch*/
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE open_emp_id <> (SELECT e.emp_id
FROM employee e INNER JOIN branch b
ON e.assigned_branch_id = b.branch_id
WHERE e.title = 'Head Teller' AND b.city = 'Woburn');

/*--------------------------Multiple-Row, Single-Column Subqueries*/
/*used with in and not in operators*/
/*returns the IDs of all employees who supervise other employees*/
SELECT emp_id, fname, lname, title
FROM employee
WHERE emp_id IN (SELECT superior_emp_id
FROM employee);

/*all employees who do not supervise other people*/
SELECT emp_id, fname, lname, title
FROM employee
WHERE emp_id NOT IN (SELECT superior_emp_id
FROM employee
WHERE superior_emp_id IS NOT NULL);

/*--------------The all operator*/
/*all operator compare a single value with every value in a set and then return True if all comparision true*/
/*finds all employees whose employee IDs are not equal to any of the supervisor employee IDs*/
SELECT emp_id, fname, lname, title
FROM employee
WHERE emp_id <> ALL (SELECT superior_emp_id
FROM employee
WHERE superior_emp_id IS NOT NULL);

/*------------------The any operator*/
/*any operator evaluates to true as soon as a single comparison is favorable*/
/*find all accounts having an available balance greater than any of Frank Tucker’s*/
SELECT account_id, cust_id, product_cd, avail_balance
FROM account
WHERE avail_balance > ANY (SELECT a.avail_balance
FROM account a INNER JOIN individual i
ON a.cust_id = i.cust_id
WHERE i.fname = 'Frank' AND i.lname = 'Tucker');


/*-----------------Multicolumn Subqueries*/
/*subqueries identify the ID of the Woburn branch and the IDs of all bank tellers*/
/*useful for mulitple condition on different values*/
SELECT account_id, product_cd, cust_id
FROM account
WHERE (open_branch_id, open_emp_id) IN
(SELECT b.branch_id, e.emp_id
FROM branch b INNER JOIN employee e
ON b.branch_id = e.assigned_branch_id
WHERE b.name = 'Woburn Branch'
AND (e.title = 'Teller' OR e.title = 'Head Teller'));

SELECT b.branch_id, e.emp_id
FROM branch b INNER JOIN employee e
ON b.branch_id = e.assigned_branch_id
WHERE b.name = 'Woburn Branch'
AND (e.title = 'Teller' OR e.title = 'Head Teller');


/*Correlated Subqueries*/
/*a correlated subquery is not executed once prior to execution of the containing statement*/
/*to correlated subquery is executed once for each candidate row (rows that might be included in the final results).*/
/*In the follwoing example, a correlated subquery count the number of accounts for each customer, and the containing query then retrieves those customers having exactly two accounts*/
SELECT c.cust_id, c.cust_type_cd, c.city
FROM customer c
WHERE 2 = (SELECT COUNT(*)
FROM account a
WHERE a.cust_id = c.cust_id);

/*finds all customers whose total available balance across all accounts lies between $5,000 and $10,000*/
SELECT c.cust_id, c.cust_type_cd, c.city
FROM customer c
WHERE (SELECT SUM(a.avail_balance)
FROM account a
WHERE a.cust_id = c.cust_id)
BETWEEN 5000 AND 10000;

/*-----------------------The exists Operator*/
/*to identify that a relationship exists without regard for the quantity*/
/*the convention is to specify either select 1 or select * when using exists*/

/*finds all customers whose customer ID does not appear in the business table*/
SELECT a.account_id, a.product_cd, a.cust_id
FROM account a
WHERE NOT EXISTS (SELECT 1
FROM business b
WHERE b.cust_id = a.cust_id);

/*----------------Data Manipulation Using Correlated Subqueries*/
/*Uncorreated Subqueries are used heavily in update, delete, and insert statements*/
/*correlated subqueries appearing frequently in update and delete statements*/

/*modifies every row in the account table by finding the latest transaction date for each account*/
UPDATE account a
SET a.last_activity_date =
(SELECT MAX(t.txn_date)
FROM transaction t
WHERE t.account_id = a.account_id);


/*update statement, employing a where clause with a second correlated subquery*/
UPDATE account a
SET a.last_activity_date =
(SELECT MAX(t.txn_date)
FROM transaction t
WHERE t.account_id = a.account_id)
WHERE EXISTS (SELECT 1
FROM transaction t
WHERE t.account_id = a.account_id);

/*removes data from the department table that has no child rows in the employee table:*/
DELETE FROM department
WHERE NOT EXISTS (SELECT 1
FROM employee
WHERE employee.dept_id = department.dept_id);

/*-------------------------When to Use Subqueries: 1- As Data Sources 2- build conditions, 3- generate column values in result sets */

/*------------Subqueries As Data Sources*/
/*Subqueries used in the from clause to create a table that doesn't exist in the data*/
/*a subquery generates a list of department IDs along with the number of employees assigned to each department*/
SELECT d.dept_id, d.name, e_cnt.how_many num_employees
FROM department d INNER JOIN
(SELECT dept_id, COUNT(*) how_many
FROM employee
GROUP BY dept_id) e_cnt
ON d.dept_id = e_cnt.dept_id;


/*--------------------Data fabrication*/
/*use subqueries to generate data that doesn’t exist in any form within your database*/
/*group your customers by the amount of money held in deposit accounts, but you want to use group definitions that are not stored in your database.*/
SELECT 'Small Fry' name, 0 low_limit, 4999.99 high_limit
UNION ALL
SELECT 'Average Joes' name, 5000 low_limit, 9999.99 high_limit
UNION ALL
SELECT 'Heavy Hitters' name, 10000 low_limit, 9999999.99 high_limit;


/*----------------------Subqueries in Filter Conditions*/
/* we can use a subquery in both where and having clauses*/
/*find the employee responsible for opening the most accounts*/
SELECT open_emp_id, COUNT(*) how_many
FROM account
GROUP BY open_emp_id
HAVING COUNT(*) = (SELECT MAX(emp_cnt.how_many)
FROM (SELECT COUNT(*) how_many
FROM account
GROUP BY open_emp_id) emp_cnt);


/*--------------------------------Subqueries As Expression Generators*/
/*subqueries may be used as an expression*/
/*retrieves employee data sorted by the last name of each employee’s boss, and then by the employee’s last name*/
SELECT emp.emp_id, CONCAT(emp.fname, ' ', emp.lname) emp_name,
(SELECT CONCAT(boss.fname, ' ', boss.lname)
FROM employee boss
WHERE boss.emp_id = emp.superior_emp_id) boss_name
FROM employee emp
WHERE emp.superior_emp_id IS NOT NULL
ORDER BY (SELECT boss.lname FROM employee boss
WHERE boss.emp_id = emp.superior_emp_id), emp.lname;
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
