USE employees;

/* Find all the employees with the same hire date as employee 101010 using a sub-query */
SELECT CONCAT(first_name, ' ', last_name) AS same_hire_date_as_emp_no_101010
FROM employees
WHERE hire_date IN (
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010
	);

/* Find all the titles held by all employees with the first name Aamod */
SELECT title, COUNT(title) AS unique_titles
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod'
	)
GROUP BY title;

/* How many people in the employees table are no longer working for the company - Solo attempt - WRONG */
SELECT COUNT(DISTINCT emp_no) AS former_employees
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM salaries
	WHERE to_date < CURDATE()
	)
AND emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date < CURDATE()
	)
AND emp_no IN (
	SELECT emp_no
	FROM titles
	WHERE to_date < CURDATE()
	);

/* How many people in the employees table are no longer working for the company - Zach solution - CORRECT */
SELECT (
	SELECT COUNT(*)
	FROM employees
	) -
	(SELECT COUNT(*)
	FROM salaries
	WHERE to_date > CURDATE()
	) AS former_employees;
	
/* Find all the current department managers that are female */
SELECT first_name, last_name
FROM employees
WHERE emp_no IN	 (
	SELECT emp_no
	FROM dept_manager
	WHERE to_date > CURDATE()
	)
AND gender = 'F';

/* Find all the employees that currently have a higher than average salary */
SELECT e.first_name, e.last_name, s.salary
FROM salaries AS s
JOIN employees AS e ON s.emp_no = e.emp_no
WHERE salary > (
	SELECT avg_salary.salary AS salary
	FROM (
		SELECT AVG(salary) AS salary
		FROM salaries
		) AS avg_salary
	)
AND to_date > CURDATE();
	
/* How many current salaries are within 1 standard deviation of the highest salary? What percentage of all salaries is this? */
SELECT COUNT(*) AS current_salaries
FROM salaries
WHERE salary >= (
	SELECT MAX(salary) -
		(
		SELECT STD(salary)
		FROM salaries
		)
	FROM salaries
	)
AND salary <= (
	SELECT MAX(salary) +
		(
		SELECT STD(salary)
		FROM salaries
		)
	FROM salaries
	)
AND to_date > CURDATE();