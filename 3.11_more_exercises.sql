USE employees;

/* How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary? */
SELECT e.emp_no, d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS manager_name, ms.salary, AVG(es.salary) AS average_salary
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN salaries AS ms ON ms.emp_no = dm.emp_no
JOIN salaries AS es ON es.emp_no = de.emp_no
WHERE dm.to_date > CURDATE() AND ms.to_date > CURDATE() AND de.to_date > CURDATE() AND es.to_date > CURDATE()
GROUP BY e.emp_no, d.dept_name, manager_name, ms.salary
ORDER BY d.dept_name;











