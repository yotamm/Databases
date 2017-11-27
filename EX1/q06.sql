SELECT	ps1.store_id, MAX(ps1.sum_per_month - ps2.sum_per_month) AS earning_difference
FROM
(
	SELECT		store_id, MONTH(payment_date) AS p_month, 
				YEAR(payment_date) AS p_year, SUM(amount) AS sum_per_month
	FROM		staff AS s
	JOIN		payment AS p
	ON			s.staff_id = p.staff_id
	GROUP BY	store_id, YEAR(payment_date), MONTH(payment_date)
) AS	ps1,
(
	SELECT		store_id, MONTH(payment_date) AS p_month, 
				YEAR(payment_date) AS p_year, SUM(amount) AS sum_per_month
	FROM		staff AS s
	JOIN		payment AS p
	ON		s.staff_id = p.staff_id
	GROUP BY	store_id, YEAR(payment_date), MONTH(payment_date)
) AS	ps2
WHERE	ps1.store_id = ps2.store_id AND
		ps1.p_year = ps2.p_year AND 
		ps1.p_month = ps2.p_month + 1
