USE employees;

SELECT * FROM employees;

#Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

/* Modify your first query to order by first name. */
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

/* Update the query to order by first name and then last name */
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

/* Change the order by clause so that you order by last name before first name */
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

#Find all employees whose last name starts with 'E'
SELECT *
FROM employees
WHERE last_name LIKE 'e%';

/* Update your queries for employees with 'E' in their last name to sort the results by their employee number */
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
ORDER BY emp_no;

/* Now reverse the sort order for both queries */
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
ORDER BY emp_no DESC;

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

#Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN
SELECT *
FROM employees
WHERE first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya';

#Add a condition to the previous query to find everybody with those names who is also male
SELECT *
FROM employees
WHERE ( first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya')
	AND gender = 'M';

#Find all employees whose last name starts or ends with 'E'
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
	OR last_name LIKE '%e';
	
/* Update your queries for employees with 'E' in their last name to sort the results by their employee number */
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
	OR last_name LIKE '%e'
ORDER BY emp_no;

/* Now reverse the sort order for both queries */
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
	OR last_name LIKE '%e'
ORDER BY emp_no DESC;
	
/* Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' */
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
	AND last_name LIKE '%e';
	
/* Update your queries for employees with 'E' in their last name to sort the results by their employee number */
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
	AND last_name LIKE '%e'
ORDER BY emp_no;

/* Now reverse the sort order for both queries */
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
	AND last_name LIKE '%e'
ORDER BY emp_no DESC;
	
#Find all employees hired in the 90s and born on Christmas
SELECT *
FROM employees
WHERE YEAR(hire_date) BETWEEN 1990 AND 1999
	AND MONTH(birth_date) = 12
	AND DAY(birth_date) = 25;

/* Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last */
SELECT *
FROM employees
WHERE YEAR(hire_date) BETWEEN 1990 AND 1999
	AND MONTH(birth_date) = 12
	AND DAY(birth_date) = 25
ORDER BY birth_date, hire_date DESC;
	
#Find all employees with a 'q' in their last name but not 'qu'
SELECT *
FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%';
	
/* Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name. */
SELECT *,
	CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE 'e%'
	AND last_name LIKE '%e';

/* Convert the names produced in your last query to all uppercase. */
SELECT *,
	UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'e%'
	AND last_name LIKE '%e';
	
/* For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company */
SELECT
	*,
	DATEDIFF(CURDATE(), hire_date) AS days_employed
FROM employees
WHERE YEAR(hire_date) BETWEEN 1990 AND 1999
	AND MONTH(birth_date) = 12
	AND DAY(birth_date) = 25;


/* Find the smallest and largest salary from the salaries table */
SELECT
	MAX(salary) AS largest_salary,
	MIN(salary) AS smallest_salary
FROM salaries;

# Create employee username
SELECT
	CONCAT(LOWER(LEFT(first_name, 1)), LOWER(LEFT(last_name, 4)), "_", SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2)) AS username,	
	first_name,
	last_name,
	birth_date
FROM employees
LIMIT 10;