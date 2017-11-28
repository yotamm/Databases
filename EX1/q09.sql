SELECT actor1Name, actor2Name
FROM (SELECT actor1Name, actor2Name, COUNT(*) AS numAppear
	  FROM (SELECT CONCAT(x.first_name,' ', x.last_name)  AS actor1Name, CONCAT(y.first_name,' ', y.last_name) AS actor2Name
			FROM actor AS x, actor AS y, film_actor AS z, film_actor AS w
			WHERE x.actor_id = z.actor_id AND y.actor_id = w.actor_id AND z.film_id = w.film_id AND x.actor_id != y.actor_id) 
	  AS pairs
	  WHERE actor1Name <= actor2Name
      GROUP BY actor1Name , actor2Name
      ORDER BY numAppear DESC) 
AS table2;
