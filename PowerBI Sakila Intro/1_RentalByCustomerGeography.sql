-- 1.1 Contribution of Countries & Cities (in hierarchy) by rental amount - Treemap (or Heatmap) & sql query

SELECT c.country,
       ci.city,
       sum(p.amount) AS 'Total Amount'
FROM country c
INNER JOIN city ci ON c.country_id = ci.country_id
INNER JOIN address a ON a.city_id = ci.city_id
INNER JOIN customer cust ON cust.address_id = a.address_id
INNER JOIN payment p ON p.customer_id = cust.customer_id
GROUP BY c.country,
         ci.city
ORDER BY sum(p.amount) DESC;

-- 1.2 Rental amounts by countries for PG & PG-13 rated films - bar chart & sql query

SELECT c.country,
       sum(p.amount) AS 'Total Amount for PG & PG-13'
FROM country c
INNER JOIN city ci ON c.country_id = ci.country_id
INNER JOIN address a ON a.city_id = ci.city_id
INNER JOIN customer cust ON cust.address_id = a.address_id
INNER JOIN payment p ON p.customer_id = cust.customer_id
WHERE p.rental_id IN
    (SELECT rental_id
     FROM rental
     WHERE inventory_id IN
         (SELECT inventory_id
          FROM inventory
          WHERE film_id IN
              (SELECT film_id
               FROM film
               WHERE rating IN ('PG','PG-13'))))
GROUP BY c.country
ORDER BY sum(p.amount) DESC;


-- 1.3. Top 20 cities by number of customers who rented - bar chart & sql query
-- Need to check if count needs to be applied on rental_id or customer_id
SELECT ci.city,
       count(r.customer_id) as 'Number of Customers'
FROM rental r
INNER JOIN customer cust ON r.customer_id = cust.customer_id
INNER JOIN address a ON a.address_id = cust.address_id
INNER JOIN city ci ON ci.city_id = a.city_id
WHERE cust.customer_id in (select customer_id from rental)
GROUP BY ci.city
ORDER BY count(r.customer_id) DESC limit 20;


-- 1.4. Top 20 cities by number of films rented - bar chart & sql query

SELECT ci.city,
       count(r.inventory_id) as 'Total Film Rentals'
FROM rental r
INNER JOIN customer cust ON r.customer_id = cust.customer_id
INNER JOIN address a ON a.address_id = cust.address_id
INNER JOIN city ci ON ci.city_id = a.city_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON f.film_id = i.film_id
GROUP BY ci.city
ORDER BY count(r.inventory_id) DESC limit 20;


-- 1.5. Rank cities by average rental cost - bar chart & sql query

SELECT ci.city,
       AVG(p.amount) "Average Rental",
       RANK() OVER (ORDER BY AVG(p.amount) DESC) AS 'Rank'
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN payment p ON p.rental_id = r.rental_id
INNER JOIN address a ON a.address_id = c.address_id
INNER JOIN city ci ON ci.city_id = a.city_id
GROUP BY ci.city
ORDER BY AVG(p.amount) DESC;
