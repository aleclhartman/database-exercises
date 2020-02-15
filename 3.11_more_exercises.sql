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

USE world;

/* What languages are spoken in Santa Monica? */
SELECT cl.language, cl.percentage
FROM countrylanguage AS cl
JOIN city AS c ON cl.CountryCode = c.CountryCode
WHERE c.Name = 'Santa Monica'
ORDER BY cl.Percentage;

/* How many different countries are in each region? */
SELECT region, COUNT(name) AS num_countries
FROM country
GROUP BY region
ORDER BY num_countries;

/* What is the population for each region? */
SELECT region, SUM(population) AS population
FROM country
GROUP BY region
ORDER BY population DESC;

/* What is the population for each continent? */
SELECT continent, SUM(population) AS population
FROM country
GROUP BY continent
ORDER BY population DESC;

/* What is the average life expectancy globally?
	Don't like this one much
		Average of an average*/
SELECT AVG(lifeexpectancy)
FROM country;

/* What is the average life expectancy for each region, each continent? Sort the results from shortest to longest */
SELECT continent, AVG(lifeexpectancy) AS life_expectancy
FROM country
GROUP BY continent
ORDER BY life_expectancy;

SELECT region, AVG(lifeexpectancy) AS life_expectancy
FROM country
GROUP BY region
ORDER BY life_expectancy;

/* Find all the countries whose local name is different from the official name */
SELECT code, name, localname
FROM country
WHERE name != localname;

/* How many countries have a life expectancy less than x? */
SELECT COUNT(*)
FROM country
WHERE lifeexpectancy < 60;

/* What state is city x located in? */
SELECT district
FROM city
WHERE name = 'Springfield';

/* What region of the world is city x located in? */
SELECT ct.region
FROM country AS ct
JOIN city AS ci ON ct.code = ci.countrycode
WHERE ci.name = 'Sao Paulo';

/* What country (use the human readable name) city x located in? */
SELECT ct.name
FROM country AS ct
JOIN city AS ci ON ct.code = ci.countrycode
WHERE ci.name = 'Reykjavik';

/* What is the life expectancy in city x? */
SELECT ct.lifeexpectancy
FROM country AS ct
JOIN city AS ci ON ct.code = ci.countrycode
WHERE ci.name = 'Zacatecas' AND ct.name = 'Mexico';

USE sakila;

SELECT CONCAT(LOWER(first_name), ' ', LOWER(last_name)) AS lowercase_name
FROM actor;


