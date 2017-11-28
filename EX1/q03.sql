SELECT act.actorName
FROM (SELECT COUNT(CONCAT(a.first_name, ' ', a.last_name)) AS count, CONCAT(a.first_name, ' ', a.last_name) AS actorName
	  FROM actor AS a, film_actor AS fa, inventory AS i, rental AS r
      WHERE a.actor_id = fa.actor_id
            AND fa.film_id = i.film_id
            AND i.inventory_id = r.inventory_id
            AND r.rental_date >= '2005-06-01'
            AND r.rental_date <= '2005-06-30'
      GROUP BY actorName) 
AS act
WHERE act.count = (SELECT MAX(act1.count1)
				   FROM (SELECT COUNT(CONCAT(a1.first_name, ' ', a1.last_name)) AS count1, CONCAT(a1.first_name, ' ', a1.last_name) AS actorName1
						 FROM actor AS a1, film_actor AS fa1, inventory AS i1, rental AS r1
						 WHERE a1.actor_id = fa1.actor_id
							   AND fa1.film_id = i1.film_id
							   AND i1.inventory_id = r1.inventory_id
							   AND r1.rental_date >= '2005-06-01'
							   AND r1.rental_date <= '2005-06-30'
						 GROUP BY actorName1) 
				   AS act1)
