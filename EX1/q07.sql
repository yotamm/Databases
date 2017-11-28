SELECT name, len
FROM category
JOIN (SELECT category_id, AVG(length) AS len
	  FROM film_category
      JOIN (SELECT length, film_id
		    FROM film 
	  ) AS f ON film_category.film_id = f.film_id
      GROUP BY category_id
) AS fc ON category.category_id = fc.category_id
ORDER BY len DESC