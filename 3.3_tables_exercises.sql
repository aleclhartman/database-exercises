USE employees;

#List the tables in the database
SHOW TABLES;

#Select all fields from the employees table
SELECT * FROM employees;

#Data types present in the employees table include INT, DATE, VARCHAR, and ENUM
DESCRIBE employees;

#I think the salaries table may contain at least one numeric type column
DESCRIBE salaries;

#I think the titles table may contain at least one string type column
DESCRIBE titles;

#I think the dept_manager table may contain at least one date type column
DESCRIBE dept_manager;

#Currently, there are no relationships between the employees and departments tables
DESCRIBE employees;
DESCRIBE departments;

#Showing SQL that created dept_manager table
SHOW CREATE TABLE dept_manager;