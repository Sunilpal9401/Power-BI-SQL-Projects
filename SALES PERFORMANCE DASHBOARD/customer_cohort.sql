DROP VIEW IF EXISTS cube_customer_cohort_monthly;
GO

CREATE VIEW cube_customer_cohort_monthly AS
--(
--cohort_month DATE NOT NULL,
--cohort_year INT NOT NULL,
--month_number INT NOT NULL,
--month_num_lab DATE NOT NULL,
--product_category VARCHAR(50) NOT NULL,
--country VARCHAR(50) NOT NULL,
--total_customers_month INT NOT NULL,
--retained_customers_month INT NOT NULL,
--percentage_month DECIMAL(18, 2) NOT NULL
--);
WITH customer_cohort AS (
SELECT
c.customerkey,
c.country,
p.category,
MIN(DATEADD(mm, DATEDIFF(mm, 0, d.date), 0)) AS cohort_month
FROM fact_internet_sales_view s
JOIN dim_date_view d ON s.OrderDateKey = d.DateKey
JOIN dim_customers_view c ON s.CustomerKey = c.CustomerKey
JOIN dim_products_view p ON s.ProductKey = p.ProductKey
GROUP BY c.customerkey,
c.country,
p.category
),
customer_activities AS (
SELECT
cc.customerkey,
cc.country,
cc.category,
DATEADD(mm, DATEDIFF(mm, 0, d.date), 0) AS month_num_lab,
DATEDIFF(month, cc.cohort_month, d.date) AS month_number
FROM fact_internet_sales_view f
JOIN dim_date_view d ON f.OrderDateKey = d.DateKey
JOIN dim_products_view p ON f.ProductKey = p.ProductKey
LEFT JOIN customer_cohort cc ON cc.customerkey = f.customerkey
AND cc.category = p.category
GROUP BY cc.customerkey, cc.category, cc.country, DATEADD(mm, DATEDIFF(mm, 0, d.date), 0), DATEDIFF(month, cc.cohort_month, d.date)
),
cohort_size AS (
SELECT
cohort_month,
COALESCE(category, 'all') AS category,
COALESCE(country, 'all') AS country,
COUNT(DISTINCT customerkey) AS month_num_customers
FROM
customer_cohort
GROUP BY
cohort_month,
CUBE(category, country)
),
retention_table_month AS (
SELECT
cc.cohort_month,
COALESCE(ca.category, 'all') AS product_category,
COALESCE(ca.country, 'all') AS country,
ca.month_num_lab,
ca.month_number,
COUNT(DISTINCT ca.customerkey) AS num_customers_month
FROM
customer_activities ca
LEFT JOIN customer_cohort cc ON ca.customerkey = cc.customerkey
    AND ca.category = cc.category
    AND ca.country = cc.country
  GROUP BY
    cc.cohort_month,
    ca.month_num_lab,
    ca.month_number,
    CUBE(
      ca.category, ca.country
    )
)
SELECT TOP 100 PERCENT
  ry.cohort_month,
  DATEPART(YEAR, ry.cohort_month) AS cohort_year
  ,ry.month_number,
  ry.month_num_lab,
  ry.product_category,
  ry.country,
  cs.month_num_customers AS total_customers_month,
  ry.num_customers_month AS retained_customers_month,
  ROUND(
    CONVERT(FLOAT, ry.num_customers_month) / CONVERT(FLOAT, cs.month_num_customers), 
    2
) AS percentage_month
FROM
  retention_table_month ry
  LEFT JOIN cohort_size cs ON ry.cohort_month = cs.cohort_month
WHERE
  ry.cohort_month IS NOT NULL
  AND ry.month_num_lab IS NOT NULL
  AND ry.product_category = cs.category
  AND ry.country = cs.country
ORDER BY
  ry.cohort_month,
  ry.month_number,
  product_category,
  country
