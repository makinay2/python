USE BANK;
SHOW TABLES;
/*----------------------------------------------------------------------------Working with string-------------------------------------------------------*/
/*There are three type of string CHAR,VARCHAR, TEXT*/
/*Generate table with string*/
CREATE TABLE string_tbl
(char_fld CHAR(30),
vchar_fld VARCHAR(30),
text_fld TEXT
);

INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES ('This is char data',
'This is varchar data',
'This is text data');
select * from  string_tbl;

/*in strig include ' we need to use escape character befor that which is another '*/
UPDATE string_tbl
SET text_fld = 'This string didn''t work, but it does now';

/*function for string return numbers*/
/*len() return lenght of each string*/
INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES ('This string is 28 characters',
'This string is 28 characters',
'This string is 28 characters');

SELECT LENGTH(char_fld) char_length,
LENGTH(vchar_fld) varchar_length,
LENGTH(text_fld) text_length
FROM string_tbl;

/*position() return for postion of a substring look from start of string*/
SELECT POSITION('characters' IN vchar_fld)
FROM string_tbl;

/*locate() return for postion of a substring look from a selected postion*/
SELECT LOCATE('is', vchar_fld, 5)
FROM string_tbl;

/*strcmp(): compare postion of two string and return -1,0,1*/
SELECT STRCMP("string","characters") vchar_fld,
STRCMP("characters","string") vchar_fld,
STRCMP("string","string") vchar_fld;

/*use like in select*/
SELECT name, name LIKE '%ns' ends_in_ns
FROM department;

/*use the regexp operator*/
SELECT cust_id, cust_type_cd, fed_id,
fed_id REGEXP '.{3}-.{2}-.{4}' is_ss_no_format
FROM customer;

/*Functions for string that return numbers*/
INSERT INTO string_tbl (text_fld)
VALUES ('This string was 29 characters');

/*concat(): add string to the stored string*/
DELETE FROM string_tbl;
INSERT INTO string_tbl (text_fld)
VALUES ('This string was 29 characters');

UPDATE string_tbl
SET text_fld = CONCAT(text_fld, ', but now it is longer');

SELECT text_fld
FROM string_tbl;
/*conact() use to build new string using all coulmns*/
SELECT CONCAT(fname, ' ', lname, ' has been a ',
title, ' since ', start_date) emp_narrative
FROM employee
WHERE title = 'Teller' OR title = 'Head Teller';

/*insert(): to replace an string*/
SELECT INSERT('goodbye world', 9, 0, 'cruel ') string;

/*substring(): to extarct a substring*/
SELECT SUBSTRING('goodbye cruel world', 9, 5);

/*--------------------------------------------------------------------------------working with the numbers------------------------------------------------------------*/
/*performing arthmetic functions*/
/*mod(): returnn reminder*/
SELECT MOD(10,4);

/*pow(): return power of a number*/
select pow(2,8);
SELECT POW(2,10) kilobyte, POW(2,20) megabyte,
POW(2,30) gigabyte, POW(2,40) terabyte;

/*ceil() and floor() functions are used to round either up or down to the closest integer*/
SELECT CEIL(72.445), FLOOR(72.445);

/*round(), any number whose decimal portion is halfway or more between two integers will be rounded up*/
/*round():allows an optional second argument to specify the number of digits*/
SELECT ROUND(72.0909, 1), ROUND(72.0909, 2), ROUND(72.0909, 3);

/*truncate() simply discards the unwanted digits without rounding.*/
/*allows an optional second argument to specify the number of digits*/
SELECT TRUNCATE(72.0909, 1), TRUNCATE(72.0909, 2),TRUNCATE(72.0909, 3);

/*truncate() and round() also allow a negative value for the second argument, meaning that numbers to the left of the decimal place are truncated or rounded*/
SELECT ROUND(17, −1), TRUNCATE(17, −1);

/*-------------------Handling Signed Data*/
/*sign() function to return −1 if negative, 0 if zero, and 1 if positive.*/
SELECT account_id, SIGN(avail_balance), ABS(avail_balance)
FROM account;

/*----------------------------------------------------------------------Working with Temporal Data------------------------------------------------*/
/*-------------------------Dealing with Time Zones*/
/*sheck timezone*/
SELECT @@global.time_zone, @@session.time_zone;

/*set timezone*/
SET time_zone = 'Europe/Zurich';

/*----------------------------Generating Temporal Data*/
/*There way to generate temporal data*/
/*1- Copying data from an existing date, datetime, or time column*/
/*2- Executing a built-in function that returns a date, datetime, or time */
/*3- Building a string representation of the temporal data to be evaluated*/

/*String-to-date conversions*/
/*cast() generate a date value and a time value from string when format is in date*/
/*convert other type of data as well*/
SELECT CAST('2008-09-17' AS DATE) date_field,
 CAST('108:17:57' AS TIME) time_field;

/*Functions for generating dates*/
/*str_to_date(): when the format of string is not in date format to be used in cast()*/
UPDATE individual
SET birth_date = STR_TO_DATE('September 17, 2008', '%M %d, %Y')
WHERE cust_id = 9999;

/*generate the current date/time*/
SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();

/*--------------------------Manipulating Temporal Data*/
/*date_add(): add any interval (e.g., days, months, years) to a specified date*/
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY);

UPDATE transaction
SET txn_date = DATE_ADD(txn_date, INTERVAL '3:27:11' HOUR_SECOND)
WHERE txn_id = 9999;

UPDATE employee
SET birth_date = DATE_ADD(birth_date, INTERVAL '9-11' YEAR_MONTH)
WHERE emp_id = 4789;

/*last_day(): return last day of a month*/
SELECT LAST_DAY('2008-09-17');

/*convert_tz(): converts a datetime value from one time zone to another*/
SELECT CURRENT_TIMESTAMP() current_est,
CONVERT_TZ(CURRENT_TIMESTAMP(), 'US/Eastern', 'UTC') current_utc;

/*ayname(): determine which day of the week a certain date*/
SELECT DAYNAME('2008-09-18');

/*extract(): extract an element of the date interests you*/
SELECT EXTRACT(YEAR FROM '2008-09-18 22:19:05');

/*datediff() returns the number of full days between two dates*/
SELECT DATEDIFF('2009-09-03', '2009-06-24');




/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
/**/
