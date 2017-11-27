-- assuming if there is a tie in sales numbers, all aligable stores should be returned.
-- first is the most rentals in july 2005, second is the least
-- this one was hard to verify since there are only two stores to begin with!

SELECT		store_id AS good_first_bad_second
FROM		inventory JOIN 
(
	SELECT		inventory_id, rental_id, rental_date
	FROM		rental
	WHERE		YEAR(rental_date) = 2005 AND MONTH(rental_date) = 7
) AS		july_rentals
ON		inventory.inventory_id = july_rentals.inventory_id
GROUP BY	inventory.store_id
HAVING		count(july_rentals.rental_id) >= ALL
(
 	SELECT		count(rental_id)
FROM		inventory AS i 
JOIN 
	(
		SELECT		inventory_id, rental_id, rental_date
		FROM		rental
WHERE		YEAR(rental_date) = 2005 AND MONTH(rental_date) = 7
	) AS		jr
ON		i.inventory_id = jr.inventory_id
GROUP BY	i.store_id
)
UNION
SELECT		store_id
FROM		inventory JOIN 
(
	SELECT		inventory_id, rental_id, rental_date
	FROM		rental
	WHERE		YEAR(rental_date) = 2005 AND MONTH(rental_date) = 7
) AS		july_rentals
ON		inventory.inventory_id = july_rentals.inventory_id
GROUP BY	inventory.store_id
HAVING		count(july_rentals.rental_id) <= ALL
(
 	SELECT		count(rental_id)
FROM		inventory AS i 
JOIN 
(
	SELECT		inventory_id, rental_id, rental_date
	FROM		rental
	WHERE		YEAR(rental_date) = 2005 AND MONTH(rental_date) = 7
) AS		jr
ON		i.inventory_id = jr.inventory_id
GROUP BY	i.store_id
)
