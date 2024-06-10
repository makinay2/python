USE BANK;
SHOW TABLES;
/*Querying Multiple tables usin JOIN*/
/*There are different type of JOIN: 1- Cartesian product or cross join, 2- INNER JOIN, 3-*/
/*1- Cartesian product or cross join:  use every possible combinations of the table, we rarely use it*/
/*without common column or ON in join*/
SELECT e.fname, e.lname, d.name 
FROM employee e JOIN department d;

/*2- INNER JOIN: specify how table are related, most common type of join,if value of commen column doesn't exist in one of the tables the row will be remove from join*/
/*the column used for join should not neccessarily be in the results set*/
SELECT e.fname, e.lname, d.name 
FROM employee e JOIN department d 
ON e.dept_id = d.dept_id;

/*The defaul type of join is INNER. We can add INNER and get the same results*/
SELECT e.fname, e.lname, d.name 
FROM employee e INNER JOIN department d 
ON e.dept_id = d.dept_id;

/*If the name of columns used in the join is same we can use USING instead of ON*/
SELECT e.fname, e.lname, d.name 
FROM employee e INNER JOIN department d 
USING (dept_id);

/*There are old version of JOIN statments, BUT they are less clean and used in practice*/
SELECT e.fname, e.lname, d.name 
FROM employee e, department d 
WHERE e.dept_id = d.dept_id;

/*JOINING more than two tables*/
SELECT a.account_id, c.fed_id, e.fname, e.lname 
FROM account a INNER JOIN customer c
ON a.cust_id = c.cust_id 
INNER JOIN employee e
ON a.open_emp_id = e.emp_id
WHERE c.cust_type_cd = "B";
/*the order of which table appear in FROM doesn't matter sicnce SQL optimizer decide how to excute the querry*/

/*To ask SQL to use specific order use STRAIGHT_JOIN*/
SELECT STRAIGHT_JOIN a.account_id, c.fed_id, e.fname, e.lname 
FROM account a INNER JOIN customer c
ON a.cust_id = c.cust_id 
INNER JOIN employee e
ON a.open_emp_id = e.emp_id
WHERE c.cust_type_cd = "B";

/*Using subqueries as a table*/
/*info on customers, whose accont be opened by specific employee*/
SELECT a.account_id, a.cust_id, a.open_date, a.product_cd
FROM account a INNER JOIN
(SELECT emp_id, assigned_branch_id
FROM employee 
WHERE start_date < "2007-01-01" AND (title = "Teller" OR title ="Head Teller")) e
ON a.open_emp_id = e.emp_id
INNER JOIN 
(SELECT branch_id FROM branch WHERE name = "Woburn Branch") b
ON e.assigned_branch_id = b.branch_id; 

/*Using same table twice: to join same table more than once*/
/*Branch is report twice one for customer and one for employee who open the account*/
SELECT a.account_id, e.emp_id, b_a.name opne_branch, b_e.name emp_branch
FROM account a INNER JOIN branch b_a
ON a.open_branch_id = b_a.branch_id
INNER JOIN employee e
ON a.opeN_emp_id = e.emp_id
INNER JOIN branch b_e
ON e.assigned_branch_id = b_e.branch_id
WHERE a.product_cd = "CHK";

/*Self-join: to join a table with it-slefs*/
/* use employee two times one for employee nane and one for superviser names, because they are both employees we need to INNER JOIN*/
SELECT e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
FROM employee e INNER JOIN employee e_mgr
ON e.superior_emp_id = e_mgr.emp_id;

/*Equi-Joins V.S. Non-Equi-Jions: Equi-Joins use = for join, but Non-Equi-Joins use range of values*/
/*find employee stared workin while no-fee checking was being  offered*/
SELECT e.emp_id, e.fname, e.lname, e.start_date
FROM employee e INNER JOIN product p
ON e.start_date >= p.date_offered AND e.start_date <= p.date_retired
WHERE p.name = "no-fee checking";
  
/*Self-non-equi-join*/
/*find possible macth employee for chess tournament*/
SELECT e1.fname, e1.lname, "VS" vs, e2.fname, e2.lname
FROM employee e1 INNER JOIN employee e2
ON e1.emp_id != e2.emp_id 
WHERE e1.title = "Teller" AND e2.title = "Teller"; 

/*the problem with above is we get the rverse pairs as well, to solve we use non-uqui*/
SELECT e1.fname, e1.lname, "VS" vs, e2.fname, e2.lname
FROM employee e1 INNER JOIN employee e2
ON e1.emp_id < e2.emp_id 
WHERE e1.title = "Teller" AND e2.title = "Teller"; 

/*JOIN conditions VS filter conditions*/
/*SQL optimzer are flexible with the cndition location and turn same resuls, but for clarifcation we hae to use clean order*/
/*Best one with ON and WHERE*/
SELECT a.account_id, a.product_cd, c.fed_id
FROM account a INNER JOIN customer c
ON a.cust_id = c.cust_id
WHERE c.cust_type_cd = "B";

/*Just ON and Not WHERE*/
SELECT a.account_id, a.product_cd, c.fed_id
FROM account a INNER JOIN customer c
ON a.cust_id = c.cust_id AND c.cust_type_cd = "B";

/*Just WHERE and not ON*/
SELECT a.account_id, a.product_cd, c.fed_id
FROM account a INNER JOIN customer c
WHERE a.cust_id = c.cust_id AND c.cust_type_cd = "B";
/**/

