#3.1. List Films with rental amount, rental quantity, rating, rental rate, replacement cost and category name – tabular
#& sql query

select f.title as films, f.replacement_cost, f.rental_rate, f.rating, sum(p.amount) as Rental_amount,count(r.rental_id) as Rental_Quantity, c.name as Category_name
from payment as p 
join rental as r on p.rental_id = r.rental_id
join inventory as i on r.inventory_id = i.inventory_id
join film as f on i.film_id = f.film_id
join film_category as fc on f.film_id = fc.film_id
join category as c on fc.category_id = c.category_id 
group by f.title;

#3.2. List top 10 Films by rental amount (ranked) – bar chart & sql query

select RANK() OVER (ORDER BY sum(p.amount) DESC) AS 'Rank',f.title as films,sum(p.amount) as rental_amount
from payment as p
join rental as r on p.rental_id = r.rental_id
join inventory as i on r.inventory_id = i.inventory_id 
join film as f on i.film_id = f.film_id
group by f.film_id
order by rental_amount desc
limit 10;

#3.3. List top 20 Films by number of customers(ranked) – bar chart & sql query

select row_number() OVER (ORDER BY count(r.customer_id) DESC) AS 'Rank', f.title,count(r.customer_id) as count
from rental as r 
JOIN inventory as i ON r.inventory_id = i.inventory_id
JOIN film as f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY count(r.customer_id) desc
limit 20



#3.4. List Films with the word “punk” in title with rental amount and number of customers – 
#Tabular & sql query

select f.film_id, f.title ,  sum(p.amount) as rental_amount, count(r.customer_id) as NumberOfCustomers
from payment as p 
join rental as r on p.rental_id = r.rental_id 
join inventory as i on r.inventory_id = i.inventory_id 
join film as f on i.film_id = f.film_id
where f.title like '%punk%'
group by film_id;

#3.5. Contribution by rental amount for films with a documentary category - Treemap (or Heatmap) & sql query

select f.title as Films, sum(p.amount) as rental_amount
from payment as p 
join rental as r on p.rental_id = r.rental_id 
join inventory as i on i.inventory_id = r.inventory_id
join film as f on  i.film_id = f.film_id 
join film_category as g on i.film_id = g.film_id
join category as c on g.category_id = c.category_id
where name like '%doc%'
group by Films	
order by rental_amount desc;
