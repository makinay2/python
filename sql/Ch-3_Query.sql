USE BANK;
SHOW TABLES;

/*# Select*/
/*it's last clause evaluated*/
/*It could include numbers, strings, expressions, build-in functions, user defined functions*/

SELECT emp_id,
 "ACTIVE", 
 emp_id * 3.14,
 UPPER(lname)
FROM employee; 

 /* if select only include build in function or evaluate simple expression, we can skip FROM */ 
SELECT VERSION(), 
 USER(),
 DATABASE();

/* Rename columns using aliases(with or without AS) */
SELECT emp_id,
 "ACTIVE" status,
 emp_id * 3.14 empid_x_pi,
 UPPER(lname) last_name_upper
FROM employee;

SELECT emp_id,
 "ACTIVE" AS status,
 emp_id * 3.14 AS empid_x_pi,
 UPPER(lname) AS last_name_upper
 FROM employee;

 /*  Rmove duplicate using distinct */ 
SELECT DISTINCT cust_id
        FROM account;

/* From clause could include different tables: */
 /* 1-permanent table */
 /* 2- temporary table created by subquerries */
 /* 3- virtual tables created by views */ 
 /* 4- linked tables by join */
 
 /* subquerry */
 SELECT e.emp_id, e.fname, e.lname
    FROM (SELECT emp_id, fname, lname, start_date, title
	FROM employee) e; 
    
 /* virtual tables  */ 
CREATE VIEW employee_vw AS
SELECT emp_id, fname, lname, YEAR(start_date) start_year
FROM employee;

SELECT emp_id, start_year
 FROM employee_vw;   
 
/*  table links--> to reference tables we can use whole name or alias */ 
SELECT employee.emp_id, employee.fname, employee.lname, department.name dept_name
    FROM employee INNER JOIN department
    ON employee.dept_id = department.dept_id;
    
SELECT e.emp_id, e.fname, e.lname, d.name dept_name
    FROM employee e INNER JOIN department d
    ON e.dept_id = d.dept_id;    
    
SELECT e.emp_id, e.fname, e.lname, d.name dept_name
    FROM employee AS e INNER JOIN department AS d
    ON e.dept_id = d.dept_id;  

/* WHERE clause to filter out unwanted rows */ 
SELECT emp_id, fname, lname, start_date, title
FROM employee
WHERE title = "Head Teller";

SELECT emp_id, fname, start_date, lname, title
FROM employee
WHERE title = "Head Teller" AND start_date > '2002-01-01';

/* use () if we have both AND and OR */ 
SELECT emp_id, fname, start_date, lname, title
FROM employee
WHERE (title = "Head Teller" AND start_date > '2002-01-01')
OR  (title = "Teller" AND start_date > '2005-01-01');

/* Group by to aggregate and Having to filter out the aggregate values (same as where form rows) */
SELECT d.name, count(e.emp_id) num_employees
FROM department d INNER JOIN employee e
ON d.dept_id = e.dept_id
GROUP BY d.name
HAVING count(e.emp_id) >2 ;

 /* oerder by to sort valuse-->  defult assending*/
 SELECT open_emp_id, product_cd
 FROM account 
 ORDER BY open_emp_id;

 /* order by two columns */ 
 SELECT open_emp_id, product_cd
 FROM account 
 ORDER BY open_emp_id, product_Cd;
 
  /* sescending order */
  SELECT account_id, product_cd, open_date, avail_balance
  FROM account
  ORDER BY avail_balance DESC;
  
  /* order by experssions--> exp sort by last three digit of id */
  SELECT cust_id, cust_type_cd, city, state, fed_id
  FROM customer
  ORDER BY RIGHT(fed_id,3);
  
/* order by numebr of column in select clause*/
SELECT emp_id, title, start_date, fname, lname
FROM employee
 ORDER BY 2, 4;   
  