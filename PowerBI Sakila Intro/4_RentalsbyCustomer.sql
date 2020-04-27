#1.List Customers (Last name, First Name) with rental amount, rental quantity, active status, country and city –
#tabular & sql query

SELECT c.last_name,c.first_name, sum(p.amount) as RentalAmount, count(r.rental_id) as Rental_Quantity, country.country, city.city,c.active
FROM   customer AS c 
       JOIN rental AS r 
         ON c.customer_id = r.customer_id
		JOIN payment as p
           ON p.rental_id=r.rental_id
		JOIN address as a
           ON a.address_id=c.address_id
		JOIN city as city
           ON a.city_id=city.city_id
		JOIN country as country
           ON country.country_id=city.country_id
WHERE c.active = 1
GROUP  BY c.last_name,c.first_name
ORDER  BY c.last_name,c.first_name desc; 


#2-List top 10 Customers (Last name, First Name) by rental amount (ranked) for PG & PG-13 rated films – bar chart
#& sql query

SELECT RANK() OVER (ORDER BY sum(p.amount) DESC) AS 'Rank', c.last_name,c.first_name, sum(p.amount) as RentalAmount
FROM   customer AS c 
       JOIN rental AS r 
         ON c.customer_id = r.customer_id
	   JOIN inventory as i
          ON r.inventory_id=i.inventory_id
		JOIN film_category as f
          ON f.film_id=i.film_id
		JOIN film as fil
          ON fil.film_id = f.film_id
		JOIN category as ct
           ON ct.category_id=f.category_id
		JOIN payment as p
           ON p.rental_id=r.rental_id
WHERE fil.rating ='PG' or fil.rating = 'PG-13'
GROUP  BY c.last_name,c.first_name
ORDER  BY RentalAmount desc
limit 10; 

#3-Contribution by rental amount for customers from France, Italy or Germany - Treemap (or Heatmap) & sql
#query

SELECT c.last_name,c.first_name, sum(p.amount) as RentalAmount
FROM   customer AS c 
       JOIN rental AS r 
         ON c.customer_id = r.customer_id
	   JOIN payment as p
           ON p.rental_id=r.rental_id
		JOIN address as a
           ON a.address_id=c.address_id
		JOIN city as city
           ON a.city_id=city.city_id
		JOIN country as country
           ON country.country_id=city.country_id
WHERE country.country ='France' or country.country ='Italy' or country.country ='Germany' 
GROUP  BY c.customer_id
ORDER  BY RentalAmount desc; 

#4- List top 20 Customers (Last name, First Name) by rental amount (ranked) for comedy films – bar chart & sql
#query

SELECT row_number() OVER (ORDER BY sum(p.amount) DESC) AS 'Rank', c.last_name,c.first_name, sum(p.amount) as RentalAmount
FROM   customer AS c 
       JOIN rental AS r 
         ON c.customer_id = r.customer_id
	   JOIN inventory as i
          ON r.inventory_id=i.inventory_id
		JOIN film_category as f
          ON f.film_id=i.film_id
		JOIN category as ct
           ON ct.category_id=f.category_id
		JOIN payment as p
           ON p.rental_id=r.rental_id
WHERE ct.name = 'Comedy'
GROUP  BY c.customer_id
limit 20; 

#5-List top 10 Customers (Last name, First Name) from China by rental amount (ranked) for films that have
#replacement costs greater than $24 – bar chart & sql query

SELECT row_number() OVER (ORDER BY sum(p.amount) DESC) AS 'Rank',c.last_name,c.first_name, sum(p.amount) as RentalAmount
FROM   customer AS c 
        JOIN rental AS r 
         ON c.customer_id = r.customer_id
	    JOIN inventory as i
          ON r.inventory_id=i.inventory_id
		JOIN film_category as f
          ON f.film_id=i.film_id
		JOIN film as fi
          ON fi.film_id=f.film_id
		JOIN category as ct
           ON ct.category_id=f.category_id
		JOIN payment as p
           ON p.rental_id=r.rental_id
		JOIN address as a
           ON a.address_id=c.address_id
		JOIN city as city
           ON a.city_id=city.city_id
		JOIN country as country
           ON country.country_id=city.country_id
WHERE country.country ='China' AND fi.replacement_cost>24
GROUP  BY c.customer_id
limit 10; 





