-- assuming that if more than one actor answers the condition, we should return them all

SELECT		CONCAT(first_name, ' ', last_name) AS actor_name
FROM		actor AS a
JOIN 
(
	SELECT		fa.actor_id, fa.film_id, f.rating
	FROM		film_actor AS fa 
	JOIN		film AS f
	ON			fa.film_id = f.film_id
	WHERE		f.rating = 'R'
) AS		faa
ON			a.actor_id = faa.actor_id
GROUP BY	actor_name
HAVING		COUNT(actor_name) >= ALL
(
	SELECT		COUNT(a.actor_id)
	FROM		actor AS a
	JOIN 
	(
		SELECT		fa.actor_id, fa.film_id, f.rating
		FROM		film_actor AS fa 
		JOIN 		film AS f
		ON	 		fa.film_id = f.film_id
		WHERE 		f.rating = 'R'
	) AS		faa
	ON			a.actor_id = faa.actor_id
	GROUP BY	a.actor_id
)
