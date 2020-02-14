USE employees;

/* Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. */
SELECT e.emp_no, de.dept_no, e.hire_date, de.to_date,
	CASE
		WHEN s.to_date > CURDATE() THEN 1
		ELSE 0
	END AS is_current_employee
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN salaries AS s ON e.emp_no = s.emp_no;

/* Write a query that returns all employee names, and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name. */
SELECT CONCAT(first_name, ' ', last_name) AS full_name, 
	CASE
		WHEN LEFT(last_name, 1) < 'I'
			THEN 'A-H'
		WHEN LEFT(last_name, 1) < 'R'
			THEN 'I-Q'
		ELSE 'R-Z'
	END AS alpha_group
FROM employees
ORDER BY last_name, first_name;

/* How many employees were born in each decade? */
SELECT
	CASE
		WHEN birth_date BETWEEN "1950-01-01" AND "1959-12-31" THEN "50s"
		ELSE "60s"
	END AS decade,
	COUNT(
		CASE
			WHEN birth_date BETWEEN "1950-01-01" AND "1959-12-31" THEN "50s"
			ELSE "60s"
		END
		) AS employees_born
FROM employees
GROUP BY decade;


/* What is the average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service? */
SELECT
	CASE
		WHEN d.dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
		WHEN d.dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
		WHEN d.dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
		WHEN d.dept_name IN ('Research', 'Development') THEN 'R&D'
		ELSE d.dept_name
	END AS dept_group,
	AVG(s.salary) AS avg_salary
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN salaries AS s ON de.emp_no = s.emp_no
WHERE de.to_date > CURDATE() AND s.to_date > CURDATE()
GROUP BY dept_group;