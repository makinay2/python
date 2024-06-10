USE BANK;
SHOW TABLES;

/* There are tree set operation:*/
/*1- union(withou duplicate), union all(with duplicate)*/
/*2- intersection(withou duplicate), intersection all(with duplicate)*/
/*3- except(withou duplicate), exept all(with duplicate): A ecxcept B means all alement is A but not in B*/

/*for any set operation: data set must have the same number of columns and sam type of data*/

/* we use compand query which is combination of multiple queries*/
select 1 num, "abc" str
union
select 9 num, "xyz" str;

/*1- union operator*/
/*all individauls and besiness customers*/
select "IND" type_cd, cust_id, lname name
from individual
union all 
select "BUS" type_cd, cust_id, name
from business;

/*to remove duplicate*/
select "IND" type_cd, cust_id, lname name
from individual
union 
select "BUS" type_cd, cust_id, name
from business;

/*2- intersect operator: not active on my server*/
select emp_id, fname, lname
form employee
intersect
select cust_id, fname, lanme
from individual;

/*3- except operator*/
select emp_id
from employee
where assigned_branch_id = 2
and(title = "Teller" OR title = "Head Teller")
except 
select distinct open_emp_id
from account
where open_branch_id = 2;

/*Sorting results*/
/*to sort results add order by after last querry but use column name from first query*/
select emp_id, assigned_branch_id
from employee 
where title = "Teller"
union 
select open_emp_id, open_branch_id
from account
where product_cd = "SAV"
order by emp_id;

/*Set operation precedence*/
/* wIf we have mulitple set operation we have to think about the order of them, because differnt order leads to differnt results*/
/*SQl evaluate querries from top to bottom, if we want to avoid that we can use operator*/
/*Here it first evaluate first two queries and combine them-->then evalute thirs and fourth queries and use except--> finall it use intersection */
(SELECT cust_id
FROM account
WHERE product_cd IN ('SAV', 'MM')
UNION ALL
SELECT a.cust_id
FROM account a INNER JOIN branch b
ON a.open_branch_id = b.branch_id
WHERE b.name = 'Woburn Branch')
INTERSECT
(SELECT cust_id
FROM account
WHERE avail_balance BETWEEN 500 AND 2500
EXCEPT
SELECT cust_id
FROM account
WHERE product_cd = 'CD'
AND avail_balance < 1000);
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
