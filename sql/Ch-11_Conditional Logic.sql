USE BANK;
SHOW TABLES;
/*Conditional logic is simply the ability to take one of several paths during program execution.*/

/*-----------Searched Case Expressions*/
/*when querying customer information, you might want to retrieve either the fname/lname columns from the individual table or the name column
from the business table*/
SELECT c.cust_id, c.fed_id,
CASE
WHEN c.cust_type_cd = 'I'
THEN CONCAT(i.fname, ' ', i.lname)
WHEN c.cust_type_cd = 'B'
THEN b.name
ELSE 'Unknown'
END name
FROM customer c LEFT OUTER JOIN individual i
ON c.cust_id = i.cust_id
LEFT OUTER JOIN business b
ON c.cust_id = b.cust_id;


/*case expressions may return any type of expression, including subqueries*/
/*individual/business name query from that uses subqueries instead of outer joins to retrieve data from the individual and business*/
SELECT c.cust_id, c.fed_id,
CASE
WHEN c.cust_type_cd = 'I' THEN
(SELECT CONCAT(i.fname, ' ', i.lname)
FROM individual i
WHERE i.cust_id = c.cust_id)
WHEN c.cust_type_cd = 'B' THEN
(SELECT b.name
FROM business b
WHERE b.cust_id = c.cust_id)
ELSE 'Unknown'
END name
FROM customer c;

/*---------------------Simple Case Expressions*/
/*similar to the searched case expression but is a bit less flexible.*/
/*Compare all when condition with value in case condition*/
SELECT c.cust_id, c.fed_id,
CASE c.cust_type_cd
WHEN 'I' THEN
(SELECT CONCAT(i.fname, ' ', i.lname)
FROM individual I
WHERE i.cust_id = c.cust_id)
WHEN 'B' THEN
(SELECT b.name
FROM business b
WHERE b.cust_id = c.cust_id)
ELSE 'Unknown Customer Type'
END
FROM customer c LEFT OUTER JOIN individual i
ON c.cust_id = i.cust_id
LEFT OUTER JOIN business b
ON c.cust_id = b.cust_id;

/*--------------------Result Set Transformations*/
/*when performing aggregations over a finite set of values, such as days of the week, but you want the result set to contain a single
row with one column per value instead of one row per value.*/
SELECT YEAR(open_date) year, COUNT(*) how_many
FROM account
WHERE open_date > '1999-12-31'
AND open_date < '2006-01-01'
GROUP BY YEAR(open_date);

/*To transform this result set into a single row, you will need to create six columns and, within each column, sum only those rows pertaining
to the year*/
SELECT
SUM(CASE
WHEN EXTRACT(YEAR FROM open_date) = 2000 THEN 1
ELSE 0
END) year_2000,
SUM(CASE
WHEN EXTRACT(YEAR FROM open_date) = 2001 THEN 1
ELSE 0
END) year_2001,
SUM(CASE
WHEN EXTRACT(YEAR FROM open_date) = 2002 THEN 1
ELSE 0
END) year_2002,
SUM(CASE
WHEN EXTRACT(YEAR FROM open_date) = 2003 THEN 1
ELSE 0
END) year_2003,
SUM(CASE
WHEN EXTRACT(YEAR FROM open_date) = 2004 THEN 1
ELSE 0
END) year_2004,
SUM(CASE
WHEN EXTRACT(YEAR FROM open_date) = 2005 THEN 1
ELSE 0
END) year_2005
FROM account
WHERE open_date > '1999-12-31' AND open_date < '2006-01-01';

/*--------------------Selective Aggregation*/
/*find accounts whose account balances don’t agree with the raw data in the transaction table*/
SELECT CONCAT('ALERT! : Account #', a.account_id,
' Has Incorrect Balance!')
FROM account a
WHERE (a.avail_balance, a.pending_balance) <>
(SELECT
SUM(CASE
WHEN t.funds_avail_date > CURRENT_TIMESTAMP()
THEN 0
WHEN t.txn_type_cd = 'DBT'
THEN t.amount * (-1)
ELSE t.amount
END),
SUM(CASE
WHEN t.txn_type_cd = 'DBT'
THEN t.amount * (−1)
ELSE t.amount
END)
FROM transaction t
WHERE t.account_id = a.account_id);


/*-------------------------Checking for Existence*/
/*determine whether a relationship exists between two entities without regard for the quantity*/
/*whether the customer has any checking accounts and the other to show whether the customer has any savings
accounts*/

SELECT c.cust_id, c.fed_id, c.cust_type_cd,
CASE
WHEN EXISTS (SELECT 1 FROM account a
WHERE a.cust_id = c.cust_id
AND a.product_cd = 'CHK') THEN 'Y'
ELSE 'N'
END has_checking,
CASE
WHEN EXISTS (SELECT 1 FROM account a
WHERE a.cust_id = c.cust_id
AND a.product_cd = 'SAV') THEN 'Y'
ELSE 'N'
END has_savings
FROM customer c;


/*----------------------Division-by-Zero Errors*/
/*When performing calculations that include division, you should always take care to ensure that the denominators are never equal to zero*/
/*us conditional logic to safeguard your calculations from encountering errors*/
SELECT a.cust_id, a.product_cd, a.avail_balance /
CASE
WHEN prod_tots.tot_balance = 0 THEN 1
ELSE prod_tots.tot_balance
END percent_of_total
FROM account a INNER JOIN
(SELECT a.product_cd, SUM(a.avail_balance) tot_balance
FROM account a
GROUP BY a.product_cd) prod_tots
ON a.product_cd = prod_tots.product_cd;


/*-----------------------Conditional Updates*/
/*When updating rows in a table, you sometimes need to decide what values to set certain columns to.*/
/*For example, after inserting a new transaction, you need to modify the
avail_balance, pending_balance, and last_activity_date columns in the account table.
Although the last two columns are easily updated, to correctly modify the
avail_balance column you need to know whether the funds from the transaction are immediately available by checking the funds_avail_date column in the transaction
table.*/
UPDATE account
SET last_activity_date = CURRENT_TIMESTAMP(),
pending_balance = pending_balance +
(SELECT t.amount *
CASE t.txn_type_cd WHEN 'DBT' THEN −1 ELSE 1 END
FROM transaction t
WHERE t.txn_id = 999),
avail_balance = avail_balance +
(SELECT
CASE
WHEN t.funds_avail_date > CURRENT_TIMESTAMP() THEN 0
ELSE t.amount *
CASE t.txn_type_cd WHEN 'DBT' THEN −1 ELSE 1 END
END
FROM transaction t
WHERE t.txn_id = 999)
WHERE account.account_id =
(SELECT t.account_id
FROM transaction t
WHERE t.txn_id = 999);

/*-----------------------Handling Null Values*/
/*it is not always appropriate to retrieve null values for display or to take part in expressions.*/
/*want to display the word unknown on a data entry screen rather than leaving a field blank.*/
SELECT emp_id, fname, lname,
CASE
WHEN title IS NULL THEN 'Unknown'
ELSE title
END
FROM employee;

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
