SELECT C.city,
D.country,
COUNT (a.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id =B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
WHERE D.country IN
--Subquery to find the top 10 countries
(SELECT D.country
FROM customer A
INNER JOIN address B ON A.address_id=B.address_id
INNER JOIN city C ON B.city_id=C.city_id
INNER JOIN country D ON C.country_id=D.country_id
GROUP BY D.country
ORDER BY COUNT (A.customer_id)DESC
LIMIT 10)
GROUP BY D.country, C.city
ORDER BY COUNT(A.customer_id)DESC
LIMIT 10;



