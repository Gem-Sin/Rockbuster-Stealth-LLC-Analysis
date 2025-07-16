--To get the top 5 customers in top 10 cities in top 10 countries
SELECT
B.customer_id,
B.first_name AS customer_first_name,
B.last_name AS customer_last_name,
D.city,
E.country,
SUM (A.amount) AS total_payment
FROM payment A
INNER JOIN customer B ON A.customer_id = B. customer_id
INNER JOIN address C ON B.address_id = C.address_id
INNER JOIN city D ON C.city_id = D.city_id
INNER JOIN country E ON D.country_id= E.country_id
WHERE D.city IN
-- subquery to get the top 10 cities within the top 10 countries
(SELECT C.city
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
GROUP BY C.city
ORDER BY COUNT(A.customer_id)DESC
LIMIT 10)
GROUP BY B.customer_id, B.first_name, B.last_name, D.city, E.country
ORDER BY SUM (A.amount) DESC
LIMIT 5;



