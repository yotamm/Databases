SELECT 
    actor_id
FROM
    film_actor
WHERE
    actor_id IN (SELECT 
            COUNT(*) AS appearences
        FROM
            film_actor
        WHERE
            film_id IN (SELECT 
                    film_id
                FROM
                    inventory
                WHERE
                    inventory_id IN (SELECT 
                            inventory_id
                        FROM
                            rental
                        WHERE
                            rental_date >= '2005-06-01'
                                AND rental_date <= '2005-06-30'))
        GROUP BY actor_id)
HAVING COUNT(actor_id) >= ALL (SELECT 
        COUNT(*) AS appearences
    FROM
        film_actor
    WHERE
        film_id IN (SELECT 
                film_id
            FROM
                inventory
            WHERE
                inventory_id IN (SELECT 
                        inventory_id
                    FROM
                        rental
                    WHERE
                        rental_date >= '2005-06-01'
                            AND rental_date <= '2005-06-30'))
    GROUP BY actor_id)