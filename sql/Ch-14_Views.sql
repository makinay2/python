USE BANK;
SHOW TABLES;
/*A view is simply a mechanism for querying data.*/
/*views do not involve data storage; you won’t need to worry about views filling up your disk space.*/
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


/*want to know what columns are available in a view*/
describe customer_vw;

/*use view like a table*/
SELECT cust_id, fed_id, cust_type_cd
FROM customer_vw;

/*use any clauses of the select statement when querying through a view, including group by, having, and order by*/
SELECT cust_type_cd, count(*)
FROM customer_vw
WHERE state = 'MA'
GROUP BY cust_type_cd
ORDER BY 1;

/*join views to other tables*/
SELECT cst.cust_id, cst.fed_id, bus.name
FROM customer_vw cst INNER JOIN business bus
ON cst.cust_id = bus.cust_id;

/*-----------------Why Use Views?*/
/*Data Security: to keep the table private or hide sensitive columns from final users while allowing use of some other columns*/
/*Data Aggregation: views are a great way to make it appear as though data is being pre-aggregated and stored in the database.*/
/*Hiding Complexity: shiel end users from complexity.*/
/*Joining Partitioned Data: By creating a view that queries some tables and combines the results together, and make it look like all data is stored in a single
table.*/

/*----------------Updatable Views*/
/*SQL Server all allow you to modify data through a view, as long as you abide by certain restrictions*/
/*-No aggregate functions are used (max(), min(), avg(), etc.).*/
/*-The view does not employ group by or having clauses.*/
/*-No subqueries exist in the select or from clause, and any subqueries in the where clause do not refer to tables in the from clause.*/
/*-The view does not utilize union, union all, or distinct.*/
/*-The from clause includes at least one table or updatable view.*/
/*-The from clause uses only inner joins if there is more than one table or view.*/

/*----------------Updating Simple Views*/
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
