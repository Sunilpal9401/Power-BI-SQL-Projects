
# Walmart Sales Data Analysis
![Walmart Sales Data Analysis](https://github.com/user-attachments/assets/cc66279c-05b6-4f5c-b793-115323c39096)

## About

This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized. The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).



## Purposes Of The Project

The major aim of thie project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

## About Data

The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting). This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| invoice_id              | Invoice of the sales made               | VARCHAR(30)    |
| branch                  | Branch at which sales were made         | VARCHAR(5)     |
| city                    | The location of the branch              | VARCHAR(30)    |
| customer_type           | The type of the customer                | VARCHAR(30)    |
| gender                  | Gender of the customer making purchase  | VARCHAR(10)    |
| product_line            | Product line of the product solf        | VARCHAR(100)   |
| unit_price              | The price of each product               | DECIMAL(10, 2) |
| quantity                | The amount of the product sold          | INT            |
| VAT                     | The amount of tax on the purchase       | FLOAT(6, 4)    |
| total                   | The total cost of the purchase          | DECIMAL(10, 2) |
| date                    | The date on which the purchase was made | DATE           |
| time                    | The time at which the purchase was made | TIMESTAMP      |
| payment_method          | The total amount paid                   | DECIMAL(10, 2) |
| cogs                    | Cost Of Goods sold                      | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(10, 2) |
| rating                  | Rating                                  | FLOAT(2, 1)    |


Viewing Full Data
```sql
Select * from sales
```

![image](https://github.com/user-attachments/assets/db606c41-e540-4222-a862-59f454dcb4ff)





### Analysis List

1. Product Analysis

> Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

2. Sales Analysis

> This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

3. Customer Analysis

> This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.

## Approach Used

1. **Data Wrangling:** This is the first step where inspection of data is done to make sure **NULL** values and missing values are detected and data replacement methods are used to replace, missing or **NULL** values.

> 1. Build a database
> 2. Create table and insert the data.
> 3. Select columns with null values in them. There are no null values in our database as in creating the tables, we set **NOT NULL** for each field, hence null values are filtered out.

2. **Feature Engineering:** This will help use generate some new columns from existing ones.



> 1. Add a new column named `day_name` that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.

> 2. Add a new column named `month_name` that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

2. **Exploratory Data Analysis (EDA):** Exploratory data analysis is done to answer the listed questions and aims of this project.

3. **Conclusion:**

## Business Questions To Answer

### Generic Question

1. How many unique cities does the data have?
2. In which city is each branch?

### Product

1. How many unique product lines does the data have?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?
5. What month had the largest COGS?
6. What product line had the largest revenue?
5. What is the city with the largest revenue?
6. What product line had the largest VAT?
7. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
8. Which branch sold more products than average product sold?
9. What is the most common product line by gender?
12. What is the average rating of each product line?

### Sales

1. Number of sales made in each time of the day per weekday
2. Which of the customer types brings the most revenue?
3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
4. Which customer type pays the most in VAT?

### Customer

1. How many unique customer types does the data have?
2. How many unique payment methods does the data have?
3. What is the most common customer type?
4. Which customer type buys the most?
5. What is the gender of most of the customers?
6. What is the gender distribution per branch?
7. Which time of the day do customers give most ratings?
8. Which time of the day do customers give most ratings per branch?
9. Which day fo the week has the best avg ratings?
10. Which day of the week has the best average ratings per branch?


## Revenue And Profit Calculations

$ COGS = unitsPrice * quantity $

$ VAT = 5\% * COGS $

$VAT$ is added to the $COGS$ and this is what is billed to the customer.

$ total(gross_sales) = VAT + COGS $

$ grossProfit(grossIncome) = total(gross_sales) - COGS $

**Gross Margin** is gross profit expressed in percentage of the total(gross profit/revenue)

$ \text{Gross Margin} = \frac{\text{gross income}}{\text{total revenue}} $

<u>**Example with the first row in our DB:**</u>

**Data given:**

- $ \text{Unite Price} = 45.79 $
- $ \text{Quantity} = 7 $

$ COGS = 45.79 * 7 = 320.53 $

$ \text{VAT} = 5\% * COGS\\= 5\%  320.53 = 16.0265 $

$ total = VAT + COGS\\= 16.0265 + 320.53 = $336.5565$

$ \text{Gross Margin Percentage} = \frac{\text{gross income}}{\text{total revenue}}\\=\frac{16.0265}{336.5565} = 0.047619\\\approx 4.7619\% $

## Code

For code, check the [SQL_queries.sql](https://github.com/Sunilpal9401/Power-BI-SQL-Projects/blob/main/Walmart_Sales_Data_Analysis/sql.sql) file

```sql
-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;

-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_5 FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);
```

### Product

- How many unique product lines does the data have?
```sql
SELECT
	DISTINCT product_line
FROM sales;
```
![image](https://github.com/user-attachments/assets/3928d3b9-95ab-4869-a8e0-91d4c2fab710)

- What is the most selling product line
```sql
SELECT
	SUM(quantity) as qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;
```
![image](https://github.com/user-attachments/assets/4795bfac-12c8-4d75-8b19-6169648595a1)

- What is the total revenue by month
```sql
SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM sales
GROUP BY month_name 
ORDER BY total_revenue;
```
![image](https://github.com/user-attachments/assets/010eb78c-6bee-4167-8995-386a50657d37)

- What month had the largest COGS?
```sql
SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM sales
GROUP BY month_name 
ORDER BY cogs
```
![image](https://github.com/user-attachments/assets/65243c07-3348-4c4a-9f0f-1ee9fcf293db)

- What product line had the largest revenue?
```sql
SELECT
	product_line,
	SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;
```
![image](https://github.com/user-attachments/assets/fe00f656-8534-4ddc-bf9e-8d306850943c)

- What is the city with the largest revenue?
```sql
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue;
```
![image](https://github.com/user-attachments/assets/6c8382ee-554b-4849-b019-604899cbc5c2)

- What product line had the largest VAT?
```sql
SELECT
	product_line,
	MAX(tax_5) as LARGEST_tax
FROM sales
GROUP BY product_line
ORDER BY LARGEST_tax DESC;
```
![image](https://github.com/user-attachments/assets/0247cdc0-11c1-4e2b-8e94-95388823b2c0)

- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
```sql
SELECT
	product_line,
	CASE
		WHEN AVG(quantity) > 6 THEN 'Good'
        ELSE 'Bad'
    END AS remark
FROM sales
GROUP BY product_line;
```
![image](https://github.com/user-attachments/assets/4c6c1c36-7fb5-4b13-8349-d83028d7f652)

- Which branch sold more products than average product sold?
```sql
SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity)
> 
(SELECT AVG(quantity) FROM sales);
```
![image](https://github.com/user-attachments/assets/d676608b-0797-4e7e-8492-3f37740e2ca9)

- What is the most common product line by gender
```sql
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;
```
![image](https://github.com/user-attachments/assets/dedf9552-4c4d-41e4-9d2e-4dc4d230f0aa)

- What is the average rating of each product line
```sql
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;
```
![image](https://github.com/user-attachments/assets/7e0a4ae6-52e5-4592-980f-562ebd197604)

### Customer

- How many unique customer types does the data have?
```sql
SELECT
	DISTINCT customer_type
FROM sales;
```
![image](https://github.com/user-attachments/assets/8b14bdc4-a00e-4829-b4cd-06ff5f8671a2)

- How many unique payment methods does the data have?
```sql
SELECT
	DISTINCT payment
FROM sales;
```
![image](https://github.com/user-attachments/assets/fb9fd43e-0440-4393-815b-7688e988298b)

- What is the most common customer type?
```sql
SELECT
	customer_type,
	count(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;
```
![image](https://github.com/user-attachments/assets/0767fdae-3bab-4258-9e27-96a21d96a121)

- Which customer type buys the most?
```sql
SELECT
	customer_type,
    COUNT(*)as buys
FROM sales
GROUP BY customer_type
order by buys desc;
```
![image](https://github.com/user-attachments/assets/f8350cb4-5f0b-421e-9724-1def8219c163)

- What is the gender of most of the customers?
```sql
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;
```
![image](https://github.com/user-attachments/assets/83a3a5cf-528c-4a0e-b066-9c5c5cf4eed7)

- What is the gender distribution per branch?
```sql
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
```
![image](https://github.com/user-attachments/assets/aacb3a68-c1b3-4604-bd50-799d40f18e26)

Gender per branch is more or less the same hence, I don't think has
an effect of the sales per branch and other factors.


- Which time of the day do customers give most ratings?
```sql
SELECT
	time,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time
ORDER BY avg_rating DESC;
```
![image](https://github.com/user-attachments/assets/b928e632-134d-453c-a869-fe7d17f369c4)

Looks like time of the day does not really affect the rating, its
 more or less the same rating each time of the day.

 - Which time of the day do customers give most ratings per branch?
```sql
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
```
![image](https://github.com/user-attachments/assets/9f137955-7679-4ccc-bd08-810edaa88dd9)

Branch A and C are doing well in ratings, branch B needs to do a 
little more to get better ratings.

- Which day fo the week has the best avg ratings?
```sql
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;
```
![image](https://github.com/user-attachments/assets/e7a7d063-d1f5-453b-ac53-11b1cc09ee6c)

Mon, Tue and Friday are the top best days for good ratings
why is that the case, how many sales are made on these days?

### Sales

- Number of sales made in each time of the day per weekday 
```sql
SELECT
	time,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name = 'Sunday'
GROUP BY time
ORDER BY total_sales DESC;
```
![image](https://github.com/user-attachments/assets/c1efbc19-08c5-485f-8f0e-8a82e80ae7e5)

Evenings experience most sales, the stores are 
filled during the evening hours.

- Which of the customer types brings the most revenue?
```sql
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;
```
![image](https://github.com/user-attachments/assets/64fb7505-9695-4e5e-b865-ba2bb7261c3d)

- Which city has the largest tax/VAT percent?
```sql
SELECT
	city,
    ROUND(AVG(Tax_5), 2) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC;
```
![image](https://github.com/user-attachments/assets/6cd4a6f1-0657-4cc6-9d98-0781a93f6665)

- Which customer type pays the most in VAT?
```sql
SELECT
	customer_type,
	AVG(Tax_5) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;
```sql
![image](https://github.com/user-attachments/assets/10e06495-aa36-40a2-a63c-b10fd18ebc23)



 


