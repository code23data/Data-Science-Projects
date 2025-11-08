-- Q1: Calculate how much each customer has spent on each artist.
WITH CustomerSpending AS (
  SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ar.name AS artist_name,
    SUM(il.unit_price * il.quantity) AS total_spent
  FROM
    customer AS c
  JOIN
    invoice AS i ON c.customer_id = i.customer_id
  JOIN
    invoice_line AS il ON i.invoice_id = il.invoice_id
  JOIN
    track AS t ON il.track_id = t.track_id
  JOIN
    album AS al ON t.album_id = al.album_id
  JOIN
    artist AS ar ON al.artist_id = ar.artist_id
  GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    ar.name
  ORDER BY
    c.customer_id,
    total_spent DESC
)
SELECT
  customer_id,
  first_name,
  last_name,
  artist_name,
  total_spent
FROM
  CustomerSpending;


-- Q2: Determine the most popular music genre for each country based on purchases.
WITH CountryGenre AS (
	SELECT
		i.billing_country,
		g.name AS genre_name,
		COUNT(il.invoice_line_id) AS genre_purchase_count,
		ROW_NUMBER() OVER (PARTITION BY i.billing_country ORDER BY COUNT(il.invoice_line_id) DESC) AS rn
	FROM
		invoice AS i
		JOIN
		invoice_line AS il ON i.invoice_id = il.invoice_id
		JOIN
		track AS t ON il.track_id = t.track_id
		JOIN
		genre AS g ON t.genre_id = g.genre_id
	GROUP BY
		i.billing_country,
		g.name
)
SELECT
	billing_country,
	genre_name,
	genre_purchase_count
FROM
    CountryGenre
WHERE
    rn = 1
ORDER BY
    billing_country;

-- Q3: Identify the top-spending customer for each country.
WITH CustomerSpending AS (
	SELECT
		c.customer_id,
		c.first_name,
		c.last_name, 
		c.country,
		SUM(i.total) AS total_spending,
		RANK() OVER (PARTITION BY c.country ORDER BY SUM(i.total) DESC) AS r
	FROM customer AS c
	JOIN
		invoice AS i ON c.customer_id = i.customer_id
	GROUP BY
		c.customer_id,
		c.first_name,
		c.last_name,
		c.country
)
SELECT
	customer_id,
	first_name,
	last_name,
	country,
	total_spending
FROM 
	CustomerSpending
WHERE
	r = 1
ORDER BY
	country;