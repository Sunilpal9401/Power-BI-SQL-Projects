-- Create database
CREATE DATABASE  walmartSales;
use walmartSales
--importing the data by assining the primary key and validating the data types

--checking complete data

-- Data cleaning

select * from sales

-- Add day_name column
ALTER TABLE sales add day_name VARCHAR(10);

UPDATE sales
SET day_name = DATENAME(weekday,date)
select * from sales

-- Add month_name column
alter table sales add month_name varchar(10)

update sales
set month_name = DATENAME(month,date)



-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------



-- How many unique cities does the data have?

select distinct city from sales

-- In which city is each branch?
SELECT 
	DISTINCT city,
    branch
FROM sales;


-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?
SELECT
	DISTINCT product_line
FROM sales;

-- What is the most selling product line
SELECT
	SUM(quantity) as qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

-- What is the total revenue by month
SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM sales
GROUP BY month_name 
ORDER BY total_revenue;

-- What month had the largest COGS?
SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM sales
GROUP BY month_name 
ORDER BY cogs;

-- What product line had the largest revenue?
SELECT
	product_line,
	SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue;

-- What product line had the largest VAT?
SELECT
	product_line,
	AVG(tax_5) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales

SELECT
	product_line,
	CASE
		WHEN AVG(quantity) > 6 THEN 'Good'
        ELSE 'Bad'
    END AS remark
FROM sales
GROUP BY product_line;

-- Which branch sold more products than average product sold?
SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity)
> 
(SELECT AVG(quantity) FROM sales);


-- What is the most common product line by gender
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------


-- How many unique customer types does the data have?
SELECT
	DISTINCT customer_type
FROM sales;

-- How many unique payment methods does the data have?
SELECT
	DISTINCT payment
FROM sales;

-- What is the most common customer type?
SELECT
	customer_type,
	count(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;


-- Which customer type buys the most?
SELECT
	customer_type,
    COUNT(*)as buys
FROM sales
GROUP BY customer_type
order by buys desc;

-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;


-- What is the gender distribution per branch?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
WHERE 
branch = 'A' 
GROUP BY gender
ORDER BY gender_cnt DESC;

SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
WHERE 
branch = 'B'
GROUP BY gender
ORDER BY gender_cnt DESC;

SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
WHERE 
branch = 'C'
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Gender per branch is more or less the same hence, I don't think has
-- an effect of the sales per branch and other factors.

-- Which time of the day do customers give most ratings?
SELECT
	time,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time
ORDER BY avg_rating DESC;

-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter

-- Which time of the day do customers give most ratings per branch?
SELECT
	time,
	AVG(rating) AS avg_rating
FROM sales
WHERE branch = 'A'
GROUP BY time
ORDER BY avg_rating DESC;
SELECT
	time,
	AVG(rating) AS avg_rating
FROM sales
WHERE branch = 'B'
GROUP BY time
ORDER BY avg_rating DESC;

SELECT
	time,
	AVG(rating) AS avg_rating
FROM sales
WHERE branch = 'C'
GROUP BY time
ORDER BY avg_rating DESC;

-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.

-- Which day fo the week has the best avg ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;
-- Mon, Tue and Friday are the top best days for good ratings
-- why is that the case, how many sales are made on these days?


-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday 
SELECT
	time,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name = 'Sunday'
GROUP BY time
ORDER BY total_sales DESC;
-- Evenings experience most sales, the stores are 
-- filled during the evening hours


-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;

-- Which city has the largest tax/VAT percent?
SELECT
	city,
    ROUND(AVG(Tax_5), 2) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
	AVG(Tax_5) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;




select  * from sales