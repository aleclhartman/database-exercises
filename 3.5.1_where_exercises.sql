USE employees;

SELECT * FROM employees;

#Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

#Find all employees whose last name starts with 'E'
SELECT *
FROM employees
WHERE last_name LIKE 'e%';

#Find all employees hired in the 90s
SELECT *
FROM employees
WHERE YEAR(hire_date) BETWEEN 1990 AND 1999;

#Find all employees born on Christmas
SELECT *
FROM employees
WHERE MONTH(birth_date) = 12
AND DAY(birth_date) = 25;

#Find all employees with a 'q' in their last name
SELECT *
FROM employees
WHERE last_name LIKE '%q%';