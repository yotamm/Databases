select max(sums), id
from (SELECT 
    SUM(amount) AS sums, customer_id AS id
FROM
    payment
GROUP BY customer_id) as s