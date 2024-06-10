 /* check create database, show databases, drop database, use , create table, desc, ,alter table, insert into, update... set, seletct, delete, drop table  */ 

 
 /* check date and time */ 
SELECT NOW();

 /* check CHARACTER SET */ 
SHOW CHARACTER SET;

 /* Set a character set  for a database*/ 
CREATE DATABASE MAJID CHARACTER SET utf8;

/* Delet database*/
 DROP DATABASE MAJID;
 
 /*  Create a database */
 CREATE DATABASE IF NOT EXISTS ch2;
   
 /* check databases */ 
 SHOW DATABASES;
 
 /*select a datbase*/
 use ch2;
 
 /* Create a tables */
  CREATE TABLE IF NOT EXISTS person(
    person_id SMALLINT UNSIGNED,
    fname VARCHAR(20),
    lname VARCHAR(20),
    gender ENUM("M", "F"), ## make sure that value is form this two
    birth_date DATE,
    street VARCHAR(30),
    city VARCHAR(20),
    state VARCHAR(20),
    country VARCHAR(20),
    postal_code VARCHAR(20),
    CONSTRAINT pk_person PRIMARY KEY (person_id)          
    );

    
/* Change the persn id to auto increment */ 
ALTER TABLE person MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;    
    
  CREATE TABLE IF NOT EXISTS food(
    person_id SMALLINT UNSIGNED,
    food VARCHAR(20),  
    CONSTRAINT pk_food PRIMARY KEY (person_id, food),
    CONSTRAINT fk_food FOREIGN KEY (person_id) 
      REFERENCES person (person_id)  
    );
    
/*Check table */ 
DESC person;

/* insert valuse */
INSERT INTO person (person_id, fname, lname, gender, birth_date)
VALUES (null, "William", "Turner", "M", "1972-05-27");     
  
INSERT INTO food (person_id, food)
VALUES (1, "pizza");

INSERT INTO food (person_id, food)
VALUES (1, "nachos");      

INSERT INTO food (person_id, food)
VALUES (1, "cookies");
      
/* Select form table with where*/ 
SELECT person_id, fname, lname, birth_date 
FROM person 
WHERE person_id = 1;

/* select with where and order */ 
SELECT food 
FROM food
WHERE person_id = 1
ORDER BY food;

/* Upadet Data */ 
UPDATE person
SET street = "1225 Tremont St",
city = "Boston",
state = "MA",
country = "USA",
postal_code = "02138"
WHERE person_id = 1;

SELECT * FROM person;

/* Update date by specifying the date format */
UPDATE person
SET birth_date = str_to_date("DEC-21-1980", "%b-%d-%Y")
WHERE person_id = 1;

SELECT * FROM person;

 /* Delete row */ 
 DELETE FROM food
WHERE food = "pizza";
 
 SELECT * FROM food;
 
 /* delete tables */ 
 DROP TABLE food;
 DROP TABLE person;
 
 SHOW TABLES;
 /* symbol */ /* symbol */ 
            /* symbol */ /* symbol */ /* symbol */ 