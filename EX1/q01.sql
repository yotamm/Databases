SELECT CONCAT(first_name, ' ', last_name) AS name
FROM customer
JOIN (SELECT customer_id
      FROM payment
      GROUP BY customer_id
      HAVING SUM(amount) >= ALL (SELECT SUM(amount)
								 FROM payment
								 GROUP BY customer_id)) 
AS t ON customer.customer_id = t.customer_id