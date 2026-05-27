/*
====================================================
DATA CLEANING & RELATIONSHIP VALIDATION
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
data cleaning, datatype standardization,
currency formatting, null handling,
and relationship validation between tables.

====================================================
*/



-- =================================================
-- CREATE CLEANED RESTAURANTS TABLE
-- =================================================

/*
This cleaned table was created to standardize:
- ratings
- cost values
- datatype consistency
*/

CREATE TABLE restaurants_cleaned AS

SELECT
    restaurant_id,
    restaurant_name,
    city,

    CASE
        WHEN rating = '--'
            THEN NULL

        ELSE rating::NUMERIC(2,1)

    END AS rating,

    rating_count,

    CAST(
        REPLACE(cost, '₹ ', '') AS INT
    ) AS cost,

    cuisine,
    license_no,
    link,
    address,
    menu

FROM restaurants;



-- =================================================
-- CLEANED RESTAURANTS TABLE VALIDATION
-- =================================================


-- Preview Cleaned Restaurants Table

SELECT *
FROM restaurants_cleaned

LIMIT 10;



-- Validate Rating and Cost Columns

SELECT
    rating,
    cost

FROM restaurants_cleaned

LIMIT 10;



-- =================================================
-- CREATE CLEANED ORDERS TABLE
-- =================================================

/*
This cleaned table was created to:
- remove invalid sales values
- standardize currency formatting
- prepare clean transactional data
*/

CREATE TABLE orders_cleaned AS

SELECT
    order_date,
    sales_qty,

    CASE
        WHEN sales_amount < 0
            THEN NULL

        ELSE sales_amount

    END AS sales_amount,

    TRIM(
        REPLACE(currency, E'\r', '')
    ) AS currency,

    user_id,
    r_id

FROM orders;



-- =================================================
-- CLEANED ORDERS TABLE VALIDATION
-- =================================================


-- Validate Null Sales Amounts

SELECT *
FROM orders_cleaned

WHERE sales_amount IS NULL;



-- Validate Currency Formatting

SELECT DISTINCT currency

FROM orders_cleaned;



-- =================================================
-- TRIAL & ERROR QUERY
-- =================================================

/*
Trial and Error Query

Used during testing and recreation
of cleaned orders table.
*/

DROP TABLE orders_cleaned;



-- =================================================
-- RELATIONSHIP VALIDATION
-- =================================================


-- Validate Orders ↔ Users Relationship

SELECT
    COUNT(*) AS unmatched_users

FROM orders_cleaned o

LEFT JOIN users u
ON o.user_id = u.user_id

WHERE u.user_id IS NULL;



-- Validate Orders ↔ Restaurants Relationship

SELECT
    COUNT(*) AS unmatched_restaurants

FROM orders_cleaned o

LEFT JOIN restaurants_cleaned r
ON o.r_id = r.restaurant_id

WHERE r.restaurant_id IS NULL;



-- Validate Menu ↔ Food Relationship

SELECT
    COUNT(*) AS unmatched_food

FROM menu m

LEFT JOIN food f
ON m.f_id = f.f_id

WHERE f.f_id IS NULL;



-- Validate Menu ↔ Restaurants Relationship

SELECT
    COUNT(*) AS unmatched_restaurants

FROM menu m

LEFT JOIN restaurants_cleaned r
ON m.r_id = r.restaurant_id

WHERE r.restaurant_id IS NULL;



-- =================================================
-- MISSING JOIN VALUE ANALYSIS
-- =================================================


-- Missing Restaurant IDs in Orders Table

SELECT DISTINCT o.r_id

FROM orders_cleaned o

LEFT JOIN restaurants_cleaned r
ON o.r_id = r.restaurant_id

WHERE r.restaurant_id IS NULL

LIMIT 20;



-- Missing Restaurant IDs in Menu Table

SELECT DISTINCT m.r_id

FROM menu m

LEFT JOIN restaurants_cleaned r
ON m.r_id = r.restaurant_id

WHERE r.restaurant_id IS NULL

LIMIT 20;



-- Null Restaurant IDs in Orders Table

SELECT COUNT(*)

FROM orders_cleaned

WHERE r_id IS NULL;



/*
====================================================
END OF DATA CLEANING & RELATIONSHIP VALIDATION
====================================================

This section was used to clean raw datasets,
standardize values, validate relationships,
and prepare analytical tables for SQL analysis
and Power BI dashboard development.

====================================================
*/