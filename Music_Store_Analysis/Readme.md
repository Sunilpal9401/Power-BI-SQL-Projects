# Music Store SQL Project 
![images](https://github.com/user-attachments/assets/48267df0-ab9d-4d06-83fe-31b59547c23a)

## Project Goal:
To analyze a dataset of a music store using SQL queries to gain insights into customer behavior, product performance, and overall business trends.

## Key Objectives:

- Data Exploration: Understand the structure, content, and relationships within the dataset.
- Query Development: Write SQL queries to extract relevant information and answer specific business questions.
- Data Analysis: Analyze the results to identify patterns, trends, and insights.

## Key Learnings 📝:

- 1)Aggregation Functions: Mastery in utilizing sum, avg, and count functions for comprehensive data insights.
- 2)Window Functions: Skillfully applied to analyze data within specific contextual ranges.
- 3)Sub-queries: Employed for intricate data extraction, enhancing the depth of analysis.
- 4)Common Table Expressions (CTEs): Leveraged for streamlining complex queries and improving readability.
- 5)JOINS: Mastered the art of merging data from disparate tables to unveil meaningful patterns.

## Business Queries

#### Who is the senior most employee based on job title?
```sql
SELECT top 5 CONCAT(first_name, ' ' , last_name)as employee_name,levels,title,reports_to
FROM employee
ORDER By levels DESC
```
![image](https://github.com/user-attachments/assets/c4eec697-4d43-4128-a5b5-f1785c96d8f0)

#### Which countries have the most Invoices? 
```sql
SELECT COUNT(*) AS cnt, billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY cnt DESC
```
![image](https://github.com/user-attachments/assets/e03a7d3f-1098-48fa-9aa2-2807028022a9)

#### What are top 3 values of total invoice? 
```sql
SELECT top 3 total FROM invoice
ORDER BY total DESC
```
![image](https://github.com/user-attachments/assets/2535936e-8f92-4fde-bbed-f7042bd936f8)

#### Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals
```sql
SELECT SUM(total) AS invoice_total, billing_city 
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total
```
![image](https://github.com/user-attachments/assets/8e42ed34-2204-4031-9367-bf935e02960a)

#### Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.
```sql
SELECT top 1 c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total
FROM customer c 
JOIN invoice i  ON c.customer_id = i.customer_id
GROUP BY c.customer_id,c.first_name, c.last_name
ORDER BY total DESC
```
![image](https://github.com/user-attachments/assets/6ac4a8e9-453b-4ed6-9cee-39aa8b5b57c5)

#### Write query to return the email, Full name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A.

```sql
SELECT DISTINCT email AS Email,concat(first_name,' ',last_name)as Full_Name, genre.name AS Name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email
```
![image](https://github.com/user-attachments/assets/f2eaf83e-b36f-4477-b116-134ec53ef5c8)

#### Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands.
```sql
SELECT top 10 artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id,artist.name
ORDER BY number_of_songs DESC
```
![image](https://github.com/user-attachments/assets/35e8325c-44e0-481d-a3a7-250e25e49820)

#### Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.
```sql
SELECT name,Milliseconds
FROM track
WHERE Milliseconds > (
	SELECT AVG(Milliseconds) AS avg_track_length
	FROM track )
ORDER BY Milliseconds DESC
```
![image](https://github.com/user-attachments/assets/c2891dfc-ae4d-477d-be28-ef7d9667e44f)

#### Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent
```sql
WITH best_selling_artist AS (
	SELECT top 1 artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY artist.artist_id,artist.name
	ORDER BY 3 DESC
	
)
SELECT c.customer_id, concat(c.first_name,' ', c.last_name)customer_Name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, bsa.artist_name
ORDER BY amount_spent DESC;
```
![image](https://github.com/user-attachments/assets/b047c4de-0c4c-4986-8a3f-0ed0d6e41600)

####  We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres.

```sql
WITH popular_genre AS 
(
    SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS rn 
    FROM invoice_line 
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY customer.country, genre.name, genre.genre_id
	
)
SELECT * FROM popular_genre WHERE rn <= 1
ORDER BY  purchases DESC
```
![image](https://github.com/user-attachments/assets/38db0181-50cc-4258-b2d8-eb0da31efc65)

#### Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount.

```sql
WITH Customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS rn 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY customer.customer_id,first_name,last_name,billing_country
		)
SELECT * FROM Customter_with_country WHERE rn <= 1
ORDER BY billing_country ASC,total_spending DESC
```
![image](https://github.com/user-attachments/assets/82de4316-cfcb-4a58-bdff-5254a24bd778)







