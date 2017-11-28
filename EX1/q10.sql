-- "Diversity isn't all" - return the name of the actor who played the most kinds (categories) of movies,
-- but didn't star in the most movies overall.

-- assuming one film only has one category

SELECT CONCAT(first_name, ' ', last_name) AS actor_name
FROM actor
JOIN(SELECT actor_id, category_id AS category, fa.film_id AS film
	 FROM film_actor AS fa
	 JOIN(SELECT f.film_id, fc.category_id AS category_id
		  FROM film AS f
		  JOIN film_category 
          AS fc ON f.film_id = fc.film_id)
	 AS fc ON fa.film_id = fc.film_id)
AS ac ON ac.actor_id = actor.actor_id
GROUP BY actor_name
HAVING COUNT(DISTINCT(category)) >= ALL(SELECT COUNT(DISTINCT(category_id))
										FROM film_actor AS fa
										JOIN (SELECT f.film_id, fc.category_id AS category_id
											 FROM film AS f
											 JOIN film_category 
                                             AS fc ON f.film_id = fc.film_id)
										AS fc ON fa.film_id = fc.film_id
										GROUP BY actor_id)
       AND COUNT(film) < ANY(SELECT COUNT(fa.film_id)
							 FROM film_actor AS fa
							 JOIN (SELECT f.film_id, fc.category_id AS category_id
								   FROM film AS f
								   JOIN film_category 
								   AS fc ON f.film_id = fc.film_id)
                             AS fc ON fa.film_id = fc.film_id
							 GROUP BY actor_id)
