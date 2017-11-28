SELECT CONCAT(first_name, ' ', last_name) AS name
FROM actor
JOIN (SELECT actor_id
	  FROM film_actor
	  JOIN(SELECT DISTINCT film_id
		   FROM	inventory
		   JOIN	(SELECT DISTINCT inventory_id
				 FROM rental
			     WHERE rental_date >= '2005-06-01' 
                       AND rental_date <= '2005-06-30') 
		   AS ren ON inventory.inventory_id = ren.inventory_id) 
	  AS inv ON film_actor.film_id = inv.film_id
	  GROUP BY actor_id
	  HAVING COUNT(film_actor.film_id) >= ALL (SELECT COUNT(film_actor.film_id)
											   FROM film_actor
											   JOIN (SELECT DISTINCT film_id
													 FROM inventory
													 JOIN (SELECT DISTINCT inventory_id
														   FROM rental
														   WHERE rental_date >= '2005-06-01' 
                                                           AND rental_date <= '2005-06-30') 
													 AS ren ON inventory.inventory_id = ren.inventory_id) 
											   AS inv ON film_actor.film_id = inv.film_id
											   GROUP BY actor_id)) 
AS fTOa ON actor.actor_id = fTOa.actor_id