/* Use the join_example_db. Select all the records from both the users and roles tables. */
USE join_example_db;

SELECT *
FROM roles;

SELECT *
FROM users;

/* Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. */

SELECT *
FROM roles
JOIN users ON roles.id = users.role_id;

SELECT *
FROM roles
LEFT JOIN users ON roles.id = users.role_id;

SELECT *
FROM roles
RIGHT JOIN users ON roles.id = users.role_id;

/* Use count and the appropriate join type to get a list of roles along with the number of users that has the role. */
SELECT roles.name AS role_name, COUNT(users.id) AS user_count
FROM roles
LEFT JOIN users ON roles.id = users.role_id
GROUP BY roles.name;

USE employees;

/* write a query that shows each department along with the name of the current manager for that department. */
SELECT d.dept_name AS "Department Name", CONCAT(e.first_name, ' ', e.last_name) AS "Department Manager"
FROM departments AS d
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
JOIN employees AS e ON e.emp_no = dm.emp_no
WHERE dm.to_date > CURDATE()
ORDER BY `Department Name`;

/* Find the name of all departments currently managed by women. */
SELECT d.dept_name AS "Department Name", CONCAT(e.first_name, ' ', e.last_name) AS "Manager Name"
FROM departments AS d
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
JOIN employees AS e ON e.emp_no = dm.emp_no
WHERE dm.to_date > CURDATE() AND e.gender = 'F'
ORDER BY `Department Name`;

/* Find the current titles of employees currently working in the Customer Service department. */
SELECT t.title AS "Title", COUNT(t.title) AS "Count"
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN titles AS t ON t.emp_no = de.emp_no
WHERE d.dept_name = 'Customer Service' AND t.to_date > CURDATE() AND de.to_date > CURDATE()
GROUP BY `Title`;

/* Find the current salary of all current managers. */
SELECT d.dept_name AS "Department Name", CONCAT(e.first_name, ' ', e.last_name) AS "Name", s.salary AS "Salary"
FROM departments AS d
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
JOIN employees AS e ON e.emp_no = dm.emp_no
JOIN salaries AS s ON s.emp_no = dm.emp_no
WHERE dm.to_date > CURDATE() AND s.to_date > CURDATE()
ORDER BY d.dept_name;

/* Find the number of employees in each department. */
SELECT d.dept_no AS dept_no, d.dept_name AS dept_name, COUNT(de.emp_no) AS num_employees
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
WHERE de.to_date > CURDATE()
GROUP BY d.dept_no;

/* Which department has the highest average salary? */
SELECT d.dept_name AS dept_name, AVG(s.salary) AS average_salary
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN employees AS e ON e.emp_no = de.emp_no
JOIN salaries AS s ON s.emp_no = de.emp_no
WHERE de.to_date > CURDATE() AND s.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC
LIMIT 1;

/* Who is the highest paid employee in the Marketing department? */
SELECT first_name, last_name
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;

/* Which current department manager has the highest salary? */
SELECT e.first_name AS first_name, e.last_name AS last_name, s.salary AS salary, d.dept_name AS dept_name
FROM departments AS d
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
JOIN employees AS e ON e.emp_no = dm.emp_no
JOIN salaries AS s ON s.emp_no = dm.emp_no
WHERE dm.to_date > CURDATE() AND s.to_date > CURDATE()
ORDER BY s.salary DESC
LIMIT 1;

/* Find the names of all current employees, their department name, and their current manager's name. */
SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name, d.dept_name AS department_name, CONCAT(me.first_name, ' ', me.last_name) AS manager_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN dept_manager AS dm ON dm.dept_no = de.dept_no
LEFT JOIN employees AS me ON me.emp_no = dm.emp_no
WHERE de.to_date > CURDATE() AND dm.to_date > CURDATE()
ORDER BY d.dept_name, employee_name;

/* Find the highest paid employee in each department. */
SELECT d.dept_name, MAX(s.salary) AS highest_salary
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN  salaries AS s ON e.emp_no = s.emp_no
WHERE s.to_date > CURDATE() AND de.to_date > CURDATE()
GROUP BY d.dept_name
LIMIT 9;
