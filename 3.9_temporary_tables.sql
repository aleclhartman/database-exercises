USE curie_952;

/* Using the example from the lesson, re-create the employees_with_departments table */
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

/* Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns */
DESCRIBE employees_with_departments;

ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

DESCRIBE employees_with_departments;

/* Update the table so that full name column contains the correct data */
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, last_name);

SELECT *
FROM employees_with_departments;

/* Remove the first_name and last_name columns from the table */
ALTER TABLE curie_952.employees_with_departments
DROP COLUMN first_name;

DESCRIBE employees_with_departments;

ALTER TABLE curie_952.employees_with_departments
DROP COLUMN last_name;

DESCRIBE employees_with_departments;

SELECT *
FROM employees_with_departments;

DESCRIBE employees_with_departments;

/* What is another way you could have ended up with this same table? */
CREATE TEMPORARY TABLE another_employees_with_departments AS
SELECT emp_no, dept_no, dept_name, CONCAT(first_name, last_name) AS full_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

DESCRIBE another_employees_with_departments;

/* Create a temporary table based on the payment table from the sakila database */
CREATE TEMPORARY TABLE payment AS
SELECT *
FROM sakila.payment;

DESCRIBE payment;

SELECT *
FROM payment;

/* Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199 */
ALTER TABLE payment
MODIFY amount INT(5);

DESCRIBE payment;

UPDATE payment
SET amount = (amount * 100);

SELECT *
FROM payment;

DROP TABLE payment;

/* Create a temporary table based on the payment table from the sakila database */
CREATE TEMPORARY TABLE payment AS
SELECT *
FROM sakila.payment;

DESCRIBE payment;

SELECT *
FROM payment;

/* Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199 */
ALTER TABLE payment
ADD new_amount INT(7);

DESCRIBE payment;

UPDATE payment
SET new_amount = (amount * 100);

SELECT *
FROM payment;

ALTER TABLE payment
DROP COLUMN amount;

SELECT *
FROM payment;

ALTER TABLE payment
CHANGE new_amount amount INT(5);

DESCRIBE payment;

SELECT *
FROM payment;

ALTER TABLE payment
MODIFY amount INT(7) NOT NULL;

DESCRIBE payment;

SELECT *
FROM payment;

/* Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst? */
USE curie_952;

CREATE TABLE avg_dept_salaries AS
SELECT d.dept_name AS dept_name, AVG(s.salary) AS salary
FROM employees.departments AS d
JOIN employees.dept_emp AS de ON d.dept_no = de.dept_no
JOIN employees.salaries AS s ON s.emp_no = de.emp_no
WHERE s.to_date > CURDATE() AND de.to_date > CURDATE()
GROUP BY d.dept_name;

DESCRIBE avg_dept_salaries;

SELECT *
FROM avg_dept_salaries;

CREATE TABLE overall_average AS
SELECT AVG(s.salary) AS salary
FROM employees.salaries AS s
WHERE s.to_date > CURDATE();

SELECT *
FROM overall_average;

CREATE TABLE salaries_std AS
SELECT STDDEV(s.salary) AS salary
FROM employees.salaries AS s
WHERE s.to_date > CURDATE();

SELECT *
FROM salaries_std;

SELECT ads.dept_name, ROUND((ads.salary - (SELECT salary FROM overall_average)) / (SELECT salary FROM salaries_std), 6) AS salary_z_scores
FROM avg_dept_salaries AS ads;


