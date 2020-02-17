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

/* Display the first and last names in all lowercase of all the actors */
SELECT CONCAT(LOWER(first_name), ' ', LOWER(last_name)) AS lowercase_name
FROM actor;

/* You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." */
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

/* Find all actors whose last name contain the letters "gen" */
SELECT *
FROM actor
WHERE last_name LIKE 'gen%'
	OR last_name LIKE '%gen%'
	OR last_name LIKE '%gen';
	
/* Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order. */
SELECT *
FROM actor
WHERE last_name LIKE 'li%'
	OR last_name LIKE '%li%'
	OR last_name LIKE 'li%'
ORDER BY last_name, first_name;

/* Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China */
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

/* List the last names of all the actors, as well as how many actors have that last name */
SELECT last_name, COUNT(last_name) AS count
FROM actor
GROUP BY last_name;

/* List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors */
SELECT last_name, COUNT(last_name) AS count
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

/* You cannot locate the schema of the address table. Which query would you use to re-create it? */
DESCRIBE address;

/* Use JOIN to display the first and last names, as well as the address, of each staff member */
SELECT s.first_name, s.last_name, a.address, a.district
FROM staff AS s
JOIN address AS a ON s.address_id = a.address_id;

/* Use JOIN to display the total amount rung up by each staff member in August of 2005. */
SELECT CONCAT(s.first_name, ' ', s.last_name) AS full_name, SUM(p.amount) AS amount_rung_up
FROM staff AS s
JOIN payment AS p ON s.staff_id = p.staff_id
WHERE p.payment_date LIKE "2005-08-%"
GROUP BY full_name;

/* List each film and the number of actors who are listed for that film. */
SELECT f.title, COUNT(fa.actor_id) AS actors
FROM film AS f
JOIN film_actor AS fa ON f.film_id = fa.film_id
GROUP BY f.title;

/* How many copies of the film Hunchback Impossible exist in the inventory system? */
SELECT f.title, f.film_id, COUNT(i.inventory_id) AS copies
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.film_id;

/* The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English. */
SELECT title
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = 'English')
AND LEFT(title, 1) IN ('K', 'Q');
	
/* Use subqueries to display all actors who appear in the film Alone Trip. */
SELECT CONCAT(a.first_name, ' ',a.last_name) AS actor_name
FROM actor AS a
WHERE a.actor_id IN (
	SELECT fa.actor_id
	FROM film_actor AS fa
	WHERE fa.film_id IN (
		SELECT f.film_id
		FROM film AS f
		WHERE f.title = 'Alone Trip'));

/* You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. */
SELECT CONCAT(first_name, ' ', last_name) AS customer_name, email
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE country_id IN (
			SELECT country_id
			FROM country
			WHERE country = 'Canada'
			)
		)
	);

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.email
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS ct ON ci.country_id = ct.country_id
WHERE ct.country = 'Canada';

/* Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films. */
SELECT title
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_category
	WHERE category_id IN (
		SELECT category_id
		FROM category
		WHERE name = 'Family'
		)
	);

SELECT f.title
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON c.category_id = fc.category_id
WHERE c.name = 'Family';

/* Write a query to display how much business, in dollars, each store brought in. */
SELECT s.store_id, SUM(p.amount) AS total_business
FROM payment AS p
JOIN store AS s ON p.staff_id = s.manager_staff_id
GROUP BY s.store_id;

/* Write a query to display for each store its store ID, city, and country. */
SELECT s.store_id, ci.city, ct.country
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS ct ON ci.country_id = ct.country_id;

/* List the top five genres in gross revenue in descending order */
SELECT c.name, SUM(p.amount) AS gross_revenue
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN inventory AS i ON fc.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;





