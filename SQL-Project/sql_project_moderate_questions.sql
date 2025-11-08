-- Q1: Find the email, first name, and last name of customers who listen to Rock music.
SELECT DISTINCT
	c.email,
	c.first_name,
	c.last_name
FROM 
	customer c
	JOIN
	invoice i ON c.customer_id = i.invoice_id
	JOIN
	invoice_line il ON i.invoice_id = il.invoice_id
	JOIN
	track t ON il.track_id = t.track_id
	JOIN
	genre g ON t.genre_id = g.genre_id
WHERE
	g.name = 'Rock';

-- Q2: Identify the top 10 rock artists based on track count.
SELECT DISTINCT
	ar.name,
	COUNT(t.track_id) AS track_count
FROM
	artist ar
	JOIN
	album al ON ar.artist_id = al.artist_id
	JOIN
	track t ON al.album_id = t.album_id
	JOIN
	genre g ON t.genre_id = g.genre_id
WHERE
	g.name = 'Rock'
GROUP BY 
	ar.name
ORDER BY
	track_count
LIMIT 10;

-- Q3: Find all track names that are longer than the average track length.
SELECT 
	name,
	milliseconds AS track_length
FROM
	track
WHERE
	milliseconds > (SELECT AVG(milliseconds) FROM track);