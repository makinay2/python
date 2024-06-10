USE BANK;
SHOW TABLES;
/*---------------------Metadata*/
/*Metadata is essentially data about data*/
/*database server uses a different mechanism to publish metadata, such as MySQL’s information_schema database*/
/*SQL Server also includes a special schema called information_schema that is provided automatically within each database*/

/*-------------------------Information_Schema*/
/*All of the objects available within the information_schema database (or schema, in the case of SQL Server) are views*/
/*the views within information_schema can be queried, and, thus, used programmatically*/

/*retrieve the names of all of the tables in the bank database*/
SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'bank'
ORDER BY 1;

/*exclude the views*/
SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'bank' AND table_type = 'BASE TABLE'
ORDER BY 1;

/*only interested in information about views, you can query information_schema.views*/
/*retrieve additional information, such as a flag that shows whether a view is updatable*/
SELECT table_name, is_updatable
FROM information_schema.views
WHERE table_schema = 'bank'
ORDER BY 1;

/*Column information for both tables and views is available via the columns view*/
SELECT column_name, data_type, character_maximum_length char_max_len,
numeric_precision num_prcsn, numeric_scale num_scale
FROM information_schema.columns
WHERE table_schema = 'bank' AND table_name = 'account'
ORDER BY ordinal_position;

/*retrieve information about a table’s indexes via the information_schema.sta tistics view*/
SELECT index_name, non_unique, seq_in_index, column_name
FROM information_schema.statistics
WHERE table_schema = 'bank' AND table_name = 'account'
ORDER BY 1, 3;

/*retrieve the different types of constraints*/
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'bank'
ORDER BY 3,1;

/*---------------Working with Metadata*/
/*1- Schema Generation Scripts*/
/*2- Deployment Verification*/
/*3- Dynamic SQL Generation*/
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
