USE BANK;
SHOW TABLES;
 /* where in all clause (select, update, delete) except insert*/
 /* for AND both condition should be ture to return true, for OR only one of them should be true*/
/* use () if where include both AND and OR*/
/* we could also use AND NOT alone or with OR*/
/* Comparison operator are: =,!= or <>,<,>,LIKE,IN,BETWEEN */

/* condition types: Equality, Inequality, Range,membership, matching*/

/* 1-Equality conditions*/
SELECT pt.name product_type, p.name product
FROM product p INNER JOIN product_type pt
ON p.product_type_cd = pt.product_type_cd
WHERE pt.name ="Customer Accounts";

/* 2-Inequality conditions */
SELECT pt.name product_type, p.name product
FROM product p INNER JOIN product_type pt
ON p.product_type_cd = pt.product_type_cd
WHERE pt.name <>"Customer Accounts";

/* Inequality conditions are used alot to modify the data*/
DELETE FROM account
WHERE status = "CLOSED" AND YEAR(open_date) =1990;

/* 3-Inequality conditions*/
/* commonn for numeric or temporal data*/
SELECT emp_id, fname, lname, start_date
FROM employee
WHERE start_date BETWEEN "2000-01-01" AND "2005-01-01";
/* when using between lower limit should come first*/

/* use betweenn for string range*/
SELECT cust_id, fed_id
FROM customer
WHERE  cust_id = "I" AND fed_id BETWEEN "500-00-0000" AND "999-99-9999";

/* 4-Membership conditions*/
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd IN ("CHK","SAV","CD","MM"); 

/* use subquery to create a membership set*/
SELECT product_cd FROM product
WHERE prodUCt_type_cd = "ACCOUNT";

SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd IN (SELECT product_cd
                     FROM product
					 WHERE prodUCt_type_cd = "ACCOUNT"); 

/* Using Not for NO membership*/
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd NOT IN ("CHK","SAV","CD","MM"); 

/* 5- Matching conditions*/
/* partially equal like last name start with T*/
SELECT emp_id, fname,lname
FROM employee
WHERE LEFT(lname,1)= "T";

/* find a match using wild cards*/
/* _ means exact one character, % means any character, F% means start with F, %t means end with t */
/* %abc% means contains abc, _ _t_ means 4 character with t in third place, _ _ _-_ _-_ _ _ _  means 11 character with dashes in 4 and 7 places */

/* find last name with a as second and e in the rest of name*/
SELECT emp_id, fname,lname
FROM employee
WHERE lname LIKE "_a%e%";

SELECT cust_id, fed_id
FROM customer
WHERE fed_id LIKE "___-__-____";

SELECT emp_id, fname,lname
FROM employee
WHERE lname LIKE "F%" OR lname LIKE "G%";

/* Using regular expression to search for more complex pattern*/
/* Last name start with F or G*/
SELECT emp_id, fname,lname
FROM employee
WHERE lname REGEXP "^[FG]";

/* NULL is the absence of value */
/*expression can be NULL but not eqaull to NULL. Null are not equal anythinn even itself*/

/*People don't have boos*/
SELECT emp_id, fname,lname, superior_emp_id
FROM employee
WHERE superior_emp_id IS NULL;

/*people have boos*/
SELECT emp_id, fname,lname, superior_emp_id
FROM employee
WHERE superior_emp_id IS NOT NULL;

/*people are not managed by helen*/
SELECT emp_id, fname,lname, superior_emp_id
FROM employee
WHERE superior_emp_id != 6 OR superior_emp_id IS NULL;
