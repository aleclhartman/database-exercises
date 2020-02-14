USE employees;

SELECT d.dept_name, SELECT( CONCAT(m.first_name, ' ', m.last_name) AS manager, ms.salary AS manager_salary, AVG(ds.salary) AS avg_salary
FROM dept_manager AS dm
LEFT JOIN employees AS m ON dm.emp_no = m.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN salaries AS ms ON m.emp_no = ms.emp_no
JOIN salaries as ds ON ds.emp_no = de.emp_no
WHERE dm.to_date > CURDATE() AND ms.to_date > CURDATE() AND ds.to_date > CURDATE() AND de.to_date > CURDATE()
GROUP BY d.dept_name;