-- Q1: Find the most senior employee based on job title.
SELECT * FROM employee ORDER BY levels DESC LIMIT 1;

-- Q2: Determine which countries have the most invoices.
SELECT COUNT(invoice_id) AS total_invoices, billing_country FROM invoice GROUP BY billing_country ORDER BY total_invoices DESC;

-- Q3: Identify the top 3 invoice totals.
SELECT * FROM invoice ORDER BY total DESC LIMIT 3;

-- Q4: Find the city with the highest total invoice amount to determine the best location for a promotional event.
SELECT billing_city, SUM(total) as total_invoice_amount FROM invoice GROUP BY billing_city ORDER BY total_invoice_amount DESC LIMIT 1;

-- Q5: Identify the customer who has spent the most money.
SELECT 
	c.first_name, 
	c.last_name,
	SUM(i.total) AS total_amount_spent
FROM
	customer c JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY
	c.customer_id, c.first_name, c.last_name
ORDER BY 
	total_amount_spent DESC
LIMIT 10;
