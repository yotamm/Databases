SELECT LEFT(title, 1) AS most_common_letter
FROM film
GROUP BY LEFT(title, 1)
HAVING COUNT(LEFT(title, 1)) >= ALL(SELECT COUNT(LEFT(title, 1))
									FROM film
									GROUP BY LEFT(title, 1))
