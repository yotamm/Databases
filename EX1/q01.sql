SELECT customer.first_name,
         customer.last_name,
         max(sums)
FROM customer, 
    (SELECT sum(amount) AS sums
    FROM payment
    GROUP BY  customer_id) AS pays