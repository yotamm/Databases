SELECT HOUR(rental_date) AS goldenHour
FROM rental
GROUP BY HOUR(rental_date)
HAVING COUNT(*) >= ALL (SELECT COUNT(*)
						FROM rental
						GROUP BY HOUR(rental_date))
