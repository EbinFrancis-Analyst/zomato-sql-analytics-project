/*
====================================================
DATA VALIDATION & DATA CLEANING ANALYSIS
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
data validation, data quality checks,
relationship verification, duplicate validation,
and data standardization before dashboard analysis.

====================================================
*/



-- =================================================
-- TABLE RECORD VALIDATION
-- =================================================


-- Total Records in Users Table

SELECT COUNT(*)
FROM users;



-- Total Records in Restaurants Table

SELECT COUNT(*)
FROM restaurants;



-- Total Records in Food Table

SELECT COUNT(*)
FROM food;



-- Total Records in Menu Table

SELECT COUNT(*)
FROM menu;



-- Total Records in Orders Table

SELECT COUNT(*)
FROM orders;



-- =================================================
-- BASIC DATA INSPECTION
-- =================================================


-- Preview Users Table

SELECT *
FROM users
LIMIT 5;



-- Preview Restaurants Table

SELECT *
FROM restaurants
LIMIT 5;



-- Preview Food Table

SELECT *
FROM food
LIMIT 5;



-- Preview Menu Table

SELECT *
FROM menu
LIMIT 5;



-- Preview Orders Table

SELECT *
FROM orders
LIMIT 5;



-- =================================================
-- NULL VALUE VALIDATION
-- =================================================


-- Check Null User IDs in Users Table

SELECT *
FROM users

WHERE user_id IS NULL;



-- Check Null Restaurant IDs

SELECT *
FROM restaurants

WHERE restaurant_id IS NULL;



-- Check Null User IDs in Orders Table

SELECT *
FROM orders

WHERE user_id IS NULL;



-- =================================================
-- INVALID / STRANGE VALUE CHECKS
-- =================================================


-- Check Negative Sales Amounts

SELECT *
FROM orders

WHERE sales_amount < 0;



-- Validate Restaurant Ratings

SELECT DISTINCT rating
FROM restaurants

ORDER BY rating;



-- =================================================
-- RELATIONSHIP VALIDATION
-- =================================================


-- Validate Relationship Between Orders and Users

SELECT COUNT(*)

FROM orders o

JOIN users u
ON o.user_id = u.user_id;



-- =================================================
-- DUPLICATE VALIDATION
-- =================================================


-- Check Duplicate User IDs

SELECT
    user_id,
    COUNT(*)

FROM users

GROUP BY user_id

HAVING COUNT(*) > 1;



-- Check Duplicate Restaurant IDs

SELECT
    restaurant_id,
    COUNT(*)

FROM restaurants

GROUP BY restaurant_id

HAVING COUNT(*) > 1;



-- =================================================
-- DATA CLEANING & STANDARDIZATION
-- =================================================


-- Validate Restaurant Rating Values

SELECT DISTINCT rating

FROM restaurants

ORDER BY rating;



-- Validate Restaurant Cost Values

SELECT DISTINCT cost

FROM restaurants

LIMIT 20;



-- Validate Currency Types

SELECT DISTINCT currency

FROM orders;



-- Validate Veg / Non-Veg Categories

SELECT DISTINCT veg_or_non_veg

FROM food;



-- Validate Order Date Range

SELECT
    MIN(order_date) AS minimum_order_date,

    MAX(order_date) AS maximum_order_date

FROM orders;



-- Null Count Validation for Orders Table

SELECT
    COUNT(*) FILTER (
        WHERE user_id IS NULL
    ) AS null_user_ids,

    COUNT(*) FILTER (
        WHERE sales_amount IS NULL
    ) AS null_sales

FROM orders;



/*
====================================================
END OF DATA VALIDATION & CLEANING ANALYSIS
====================================================

This section was used to validate data quality,
identify inconsistencies, and prepare clean data
for SQL analysis and Power BI dashboard development.

====================================================
*/