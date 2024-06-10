USE BANK;
SHOW TABLES;
/*A view is simply a mechanism for querying data*/
/*views do not involve data storage*/ 
/*create a view by assigning a name to a select statement, and then storing the query for others
to use.*/
/*create view statement is executed, the database server simply stores the view definition for future use; the query is not executed, and no data is retrieved or stored.*/
CREATE VIEW customer_vw
(cust_id,
fed_id,
cust_type_cd,
address,
city,
state,
zipcode
)
AS
SELECT cust_id,
concat('ends in ', substr(fed_id, 8, 4)) fed_id,
cust_type_cd,
address,
city,
state,
postal_code
FROM customer;

/*------------- use view like any other tables*/
SELECT cust_id, fed_id, cust_type_cd
FROM customer_vw;

/*want to know what columns are available in a view*/
describe customer_vw;

/*we can use any clauses of the select statement when querying through a view, including group by, having, and order by*/
SELECT cust_type_cd, count(*)
FROM customer_vw
WHERE state = 'MA'
GROUP BY cust_type_cd
ORDER BY 1;

/*we can join views to other tables*/
SELECT cst.cust_id, cst.fed_id, bus.name
FROM customer_vw cst INNER JOIN business bus
ON cst.cust_id = bus.cust_id;

/*--------------Why Use Views?*/
/*Data Security: let users use some piece of infomation but create one or more views that either omit or obscure*/
/*Data Aggregation: views are a great way to make it appear as though data is being pre-aggregated and stored in the database.*/
/*Hiding Complexity: shield end users from complexity*/
/*Joining Partitioned Data: By creating a view that queries multiple tables and combines the results together, we can make it look like all data is stored in a single
table*/

/*-------------Updatable Views*/
/*allow you to modify data through a view, as long as you abide by certain restrictions*/

/*--------------Updating Simple Views*/
CREATE VIEW customer_vw
(cust_id,
fed_id,
cust_type_cd,
address,
city,
state,
zipcode
)
AS
SELECT cust_id,
concat('ends in ', substr(fed_id, 8, 4)) fed_id,
cust_type_cd,
address,
city,
state,
postal_code
FROM customer;

UPDATE customer_vw
SET city = 'Woooburn'
WHERE city = 'Woburn';

SELECT DISTINCT city FROM customer;
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/

/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/

/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/

/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/


