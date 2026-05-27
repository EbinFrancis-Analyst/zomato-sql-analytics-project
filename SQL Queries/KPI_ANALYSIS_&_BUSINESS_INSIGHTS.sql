/*
====================================================
KPI ANALYSIS & BUSINESS INSIGHTS
====================================================

Created By   : Ebin Francis K S
Role         : Data Analyst

GitHub       : https://github.com/EbinFrancis-Analyst
Portfolio    : https://ebinfrancis-analyst.github.io/ebinfrancis.github.io/
LinkedIn     : https://www.linkedin.com/in/ebin-francis-30b7b4273/

Tools Used   :
- PostgreSQL
- SQL
- Power BI

Purpose:
This section contains SQL queries used for
business KPI analysis, customer analytics,
restaurant performance analysis, and revenue insights.

====================================================
*/



-- =================================================
-- LEVEL 1 KPI ANALYSIS
-- =================================================


-- Total Revenue

SELECT
    SUM(sales_amount) AS total_revenue
FROM orders_cleaned;



-- Total Orders

SELECT
    COUNT(*) AS total_orders
FROM orders_cleaned;



-- Active Customers

SELECT
    COUNT(DISTINCT user_id) AS active_customers
FROM orders_cleaned;



-- Average Order Value (AOV)

SELECT
    ROUND(AVG(sales_amount), 2) AS avg_order_value
FROM orders_cleaned;



-- Revenue by Currency

SELECT
    currency,
    SUM(sales_amount) AS revenue
FROM orders_cleaned
GROUP BY currency;



-- Top 10 Cities by Revenue

SELECT
    r.city,
    SUM(o.sales_amount) AS total_revenue

FROM orders_cleaned o

INNER JOIN restaurants_cleaned r
ON o.r_id = r.restaurant_id

GROUP BY r.city

ORDER BY total_revenue DESC

LIMIT 10;



-- =================================================
-- RESTAURANT PERFORMANCE ANALYSIS
-- =================================================


-- Top 10 Restaurants by Revenue

SELECT
    r.restaurant_name,
    r.city,
    SUM(o.sales_amount) AS total_revenue

FROM orders_cleaned o

INNER JOIN restaurants_cleaned r
ON o.r_id = r.restaurant_id

GROUP BY r.restaurant_name, r.city

ORDER BY total_revenue DESC

LIMIT 10;



-- Top Cuisines by Revenue

SELECT
    r.cuisine,
    SUM(o.sales_amount) AS total_revenue

FROM orders_cleaned o

INNER JOIN restaurants_cleaned r
ON o.r_id = r.restaurant_id

GROUP BY r.cuisine

ORDER BY total_revenue DESC

LIMIT 10;



-- City-wise Average Order Value

SELECT
    r.city,
    ROUND(AVG(o.sales_amount), 2) AS avg_order_value

FROM orders_cleaned o

INNER JOIN restaurants_cleaned r
ON o.r_id = r.restaurant_id

GROUP BY r.city

ORDER BY avg_order_value DESC

LIMIT 10;



-- Highest Rated Restaurants

SELECT
    restaurant_name,
    city,
    rating

FROM restaurants_cleaned

WHERE rating IS NOT NULL

ORDER BY rating DESC

LIMIT 20;



-- Rating vs Revenue Analysis

SELECT
    r.rating,
    ROUND(AVG(o.sales_amount), 2) AS avg_revenue

FROM orders_cleaned o

INNER JOIN restaurants_cleaned r
ON o.r_id = r.restaurant_id

WHERE r.rating IS NOT NULL

GROUP BY r.rating

ORDER BY r.rating;



-- =================================================
-- TRIAL & ERROR QUERY
-- =================================================

/*
This query was used during testing and validation
of restaurant revenue calculations.
*/

SELECT
    r.restaurant_name,
    r.city,
    COALESCE(SUM(o.sales_amount), 0) AS total_revenue

FROM orders_cleaned o

INNER JOIN restaurants_cleaned r
ON o.r_id = r.restaurant_id

GROUP BY r.restaurant_name, r.city

ORDER BY total_revenue DESC

LIMIT 10;



-- =================================================
-- ADVANCED RESTAURANT ANALYSIS
-- =================================================


-- Restaurant Revenue Ranking

WITH restaurant_revenue AS (

    SELECT
        r.restaurant_name,
        r.city,
        SUM(o.sales_amount) AS revenue

    FROM orders_cleaned o

    INNER JOIN restaurants_cleaned r
    ON o.r_id = r.restaurant_id

    GROUP BY r.restaurant_name, r.city
)

SELECT
    restaurant_name,
    city,
    revenue,

    DENSE_RANK() OVER(
        ORDER BY revenue DESC
    ) AS revenue_rank

FROM restaurant_revenue

LIMIT 20;



-- Top Restaurant Within Each City

WITH city_restaurant_revenue AS (

    SELECT
        r.city,
        r.restaurant_name,

        SUM(o.sales_amount) AS revenue,

        ROW_NUMBER() OVER(
            PARTITION BY r.city
            ORDER BY SUM(o.sales_amount) DESC
        ) AS rn

    FROM orders_cleaned o

    INNER JOIN restaurants_cleaned r
    ON o.r_id = r.restaurant_id

    GROUP BY r.city, r.restaurant_name
)

SELECT *
FROM city_restaurant_revenue

WHERE rn = 1;



-- Monthly Revenue Growth Trend

WITH monthly_revenue AS (

    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(sales_amount) AS revenue

    FROM orders_cleaned

    GROUP BY month
)

SELECT
    month,
    revenue,

    LAG(revenue) OVER(
        ORDER BY month
    ) AS previous_month,

    revenue -
    LAG(revenue) OVER(
        ORDER BY month
    ) AS revenue_growth

FROM monthly_revenue;



-- =================================================
-- CUSTOMER ANALYTICS
-- =================================================


-- Top 20 High-Value Customers

SELECT
    user_id,
    COUNT(*) AS total_orders,
    SUM(sales_amount) AS total_spent,

    ROUND(AVG(sales_amount), 2) AS avg_order_value

FROM orders_cleaned

GROUP BY user_id

ORDER BY total_spent DESC

LIMIT 20;



-- Customer Segmentation

WITH customer_spending AS (

    SELECT
        user_id,
        SUM(sales_amount) AS total_spent

    FROM orders_cleaned

    GROUP BY user_id
)

SELECT
    CASE

        WHEN total_spent >= 50000
            THEN 'High Value'

        WHEN total_spent >= 20000
            THEN 'Medium Value'

        ELSE 'Low Value'

    END AS customer_segment,

    COUNT(*) AS customer_count

FROM customer_spending

GROUP BY customer_segment;



-- Repeat Customer Analysis

SELECT
    user_id,
    COUNT(*) AS total_orders

FROM orders_cleaned

GROUP BY user_id

HAVING COUNT(*) > 5

ORDER BY total_orders DESC

LIMIT 20;



-- Monthly Customer Growth

WITH monthly_customers AS (

    SELECT
        DATE_TRUNC('month', order_date) AS month,

        COUNT(DISTINCT user_id)
        AS active_customers

    FROM orders_cleaned

    GROUP BY month
)

SELECT
    month,
    active_customers,

    LAG(active_customers)
    OVER(ORDER BY month)
    AS previous_month,

    active_customers
    -
    LAG(active_customers)
    OVER(ORDER BY month)
    AS customer_growth

FROM monthly_customers;



/*
====================================================
END OF KPI & BUSINESS ANALYSIS
====================================================

This SQL analysis was used for KPI generation,
business reporting, dashboard visualization,
and Power BI analytics development.

====================================================
*/