#Film categoriesby rental amount (ranked) & rental quantity – tabular& sql query
#customer,payment, category, film_category 
#1-Film categoriesby rental amount (ranked) & rental quantity – tabular& sql query

SELECT c.name, sum(p.amount) as RentalAmount, 
        count(r.rental_id) as Rental_Quantity,
        RANK() OVER (ORDER BY sum(p.amount) DESC) AS 'Rank'
FROM   category AS c 
       JOIN film_category AS f 
         ON c.category_id = f.category_id
       JOIN inventory AS i 
         ON i.film_id = f.film_id
	   JOIN rental AS r
         ON r.inventory_id = i.inventory_id
	   JOIN payment AS p 
         ON p.rental_id = r.rental_id 
GROUP  BY c.name 
ORDER  BY sum(p.amount) desc; 

#2-Film categories by rental amount (ranked) – bar chart & sql query

SELECT  RANK() OVER (ORDER BY sum(p.amount) DESC) AS 'Rank',c.name FilmCategory,sum(p.amount) as RentalAmount
FROM   category AS c 
       JOIN film_category AS f 
         ON c.category_id = f.category_id
       JOIN inventory AS i 
         ON i.film_id = f.film_id
	   JOIN rental AS r
         ON r.inventory_id = i.inventory_id
	   JOIN payment AS p 
         ON p.rental_id = r.rental_id 
GROUP  BY  c.name 
ORDER  BY sum(p.amount) desc; 

#3- Film categories by average rental amount (ranked) & – tabular & sql query

SELECT  RANK() OVER (ORDER BY avg(p.amount) DESC) AS 'Rank',c.name FilmCategory,avg(p.amount) as RentalAmount
FROM   category AS c 
       JOIN film_category AS f 
         ON c.category_id = f.category_id
       JOIN inventory AS i 
         ON i.film_id = f.film_id
	   JOIN rental AS r
         ON r.inventory_id = i.inventory_id
	   JOIN payment AS p 
         ON p.rental_id = r.rental_id 
GROUP  BY c.name; 

#4-Contribution of Film Categories by number of customers - Treemap (or Heatmap) & sql query

#customer,payment, category, film_category, inventory

SELECT  ct.name, count(c.customer_id) as NumberOfCustomers
FROM   customer AS c 
       JOIN rental AS r 
         ON c.customer_id = r.customer_id
	   JOIN inventory as i
          ON r.inventory_id=i.inventory_id
	   JOIN film as fi
		  ON fi.film_id=i.film_id
		JOIN film_category as f
          ON f.film_id=i.film_id
		JOIN category as ct
           ON ct.category_id=f.category_id
GROUP  BY ct.name
ORDER  BY NumberOfCustomers ; 

#5-Contribution of Film Categories by rental amount - Treemap (or Heatmap) & sql query

SELECT  ct.name,sum(p.amount) as RentalAmount
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
GROUP  BY ct.name
ORDER  BY RentalAmount desc; 


