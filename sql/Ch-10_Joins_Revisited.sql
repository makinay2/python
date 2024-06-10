USE BANK;
SHOW TABLES;
/*-------------------------------------Outer Joins*/
/*In an inner joins soe of the rows in tables would be left*/
/*If we want all the rows in a specific table we need to use outer join*/

/* the keywords left and right indicates that the table in the join which is responsible for determining the number of rows in the result set*/
SELECT c.cust_id, b.name
FROM customer c LEFT OUTER JOIN business b
ON c.cust_id = b.cust_id;

SELECT c.cust_id, b.name
FROM customer c RIGHT OUTER JOIN business b
ON c.cust_id = b.cust_id;

/*----------------------Three-Way Outer Joins*/
/*want to outer-join one table with two other tables*/
/*a list of all accounts showing either the customer’s first and last names for individuals or the business name for business customers*/
SELECT a.account_id, a.product_cd,
CONCAT(i.fname, ' ', i.lname) person_name,
b.name business_name
FROM account a LEFT OUTER JOIN individual i
ON a.cust_id = i.cust_id
LEFT OUTER JOIN business b
ON a.cust_id = b.cust_id;

/*the same table, but with subqueries to limit the number of joins in your query*/
SELECT account_ind.account_id, account_ind.product_cd,
account_ind.person_name,
b.name business_name
FROM
(SELECT a.account_id, a.product_cd, a.cust_id,
CONCAT(i.fname, ' ', i.lname) person_name
FROM account a LEFT OUTER JOIN individual i
ON a.cust_id = i.cust_id) account_ind
LEFT OUTER JOIN business b
ON account_ind.cust_id = b.cust_id;

/*-----------------Self Outer Joins*/
/*joins the employee table to itself to generate a list of employees and their supervisors*/
SELECT e.fname, e.lname,
e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
FROM employee e LEFT OUTER JOIN employee e_mgr
ON e.superior_emp_id = e_mgr.emp_id;

/*change to right outer join */
SELECT e.fname, e.lname,
e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
FROM employee e RIGHT OUTER JOIN employee e_mgr
ON e.superior_emp_id = e_mgr.emp_id;

/*-------------Cross Joins*/
/*use concept of a Cartesian product, which is essentially the result of joining multiple tables without specifying any join conditions*/
/*are not so common*/
SELECT pt.name, p.product_cd, p.name
FROM product p CROSS JOIN product_type pt;

/*---------------Natural Joins*/
/*you are lazy lets the database server determine what the join conditions need to be*/
/*relies on identical column names across multiple tables to infer the proper join conditions*/
SELECT a.account_id, a.cust_id, c.cust_type_cd, c.fed_id
FROM account a NATURAL JOIN customer c;

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
