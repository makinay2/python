USE BANK;
SHOW TABLES;
/*------------------------------------------------------------------------Grouping Concepts----------------------------------------------------------------------*/
/*group the account data by employee ID*/
SELECT open_emp_id
FROM account
GROUP BY open_emp_id;

/*count the number of rows in each group*/
SELECT open_emp_id, COUNT(*) how_many
FROM account
GROUP BY open_emp_id;

/*add filter conditions*/
SELECT open_emp_id, COUNT(*) how_many
FROM account
GROUP BY open_emp_id
HAVING COUNT(*) > 4;

/*--------------Aggregate Functions:max(),min(),avg(),sum(),count()*/
/*-----Implicit Versus Explicit Groups*/

/*-----Implicit Groups: no group by like below, but there is a where condition */
/*analyze the available balances for all checking accounts*/
SELECT MAX(avail_balance) max_balance,
MIN(avail_balance) min_balance,
AVG(avail_balance) avg_balance,
SUM(avail_balance) tot_balance,
COUNT(*) num_accounts
FROM account
WHERE product_cd = 'CHK';

/*Explicit Groups: must have group by statement*/
SELECT product_cd,
MAX(avail_balance) max_balance,
MIN(avail_balance) min_balance,
AVG(avail_balance) avg_balance,
SUM(avail_balance) tot_balance,
COUNT(*) num_accts
FROM account
GROUP BY product_cd;

/*----------------Counting Distinct Values*/
SELECT COUNT(DISTINCT open_emp_id)
FROM account;

/*----------------------Using Expressions*/
/*maximum value pending deposits: calculated by subtracting the available balance from the pending balance.*/
SELECT MAX(pending_balance - avail_balance) max_uncleared
FROM account;

/*-------------How Nulls Are Handled*/
/*aggregate functions ignore NAs*/

/*------------------Generating Groups*/
/*----------Single-Column Grouping*/
SELECT product_cd, SUM(avail_balance) prod_balance
FROM account
GROUP BY product_cd;

/*------Multicolumn Grouping*/
/*generates total account balances for each product and branch*/
SELECT product_cd, open_branch_id,
SUM(avail_balance) tot_balance
FROM account
GROUP BY product_cd, open_branch_id;

/*-------Grouping via Expressions*/
/*groups employees by the year they began working for the bank*/
SELECT EXTRACT(YEAR FROM start_date) year,
COUNT(*) how_many
FROM employee
GROUP BY EXTRACT(YEAR FROM start_date);

/*----------Generating Rollups*/
/*with rollup: account balances for each product and branch and total balances for each product/branch combination*/
SELECT product_cd, open_branch_id,
SUM(avail_balance) tot_balance
FROM account
GROUP BY product_cd, open_branch_id WITH ROLLUP;

/*a null value is provided for the open_branch_id column, since the rollup is being performed across all branches*/

/*----------------Group Filter Conditions*/
/**/
SELECT product_cd, SUM(avail_balance) prod_balance
FROM account
WHERE status = 'ACTIVE'
GROUP BY product_cd
HAVING SUM(avail_balance) >= 10000;

/*----------aggregate functions in the having clause*/
SELECT product_cd, SUM(avail_balance) prod_balance
FROM account
WHERE status = 'ACTIVE'
GROUP BY product_cd
HAVING MIN(avail_balance) >= 1000
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
