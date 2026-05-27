/*
====================================================
ZOMATO SALES & CUSTOMER ANALYTICS PROJECT
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

Project Type :
Business Intelligence & Analytics Dashboard

Project Objective:
Analyze restaurant performance, customer behavior,
sales trends, and business KPIs using SQL and Power BI.

====================================================
*/


-- =================================================
-- USERS TABLE
-- =================================================

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150),
    password VARCHAR(150),
    age INT,
    gender VARCHAR(20),
    marital_status VARCHAR(30),
    occupation VARCHAR(100),
    monthly_income VARCHAR(50),
    educational_qualifications VARCHAR(100),
    family_size INT
);


-- Preview sample records from users table

SELECT *
FROM users
LIMIT 100;


-- Total records in users table

SELECT COUNT(*) AS total_users
FROM users;



-- =================================================
-- RESTAURANTS TABLE
-- =================================================

CREATE TABLE restaurants (
    restaurant_id BIGINT PRIMARY KEY,
    restaurant_name TEXT,
    city VARCHAR(100),
    rating VARCHAR(20),
    rating_count VARCHAR(50),
    cost VARCHAR(50),
    cuisine TEXT,
    license_no VARCHAR(100),
    link TEXT,
    address TEXT,
    menu TEXT
);


-- Total restaurant count

SELECT COUNT(*) AS total_restaurants
FROM restaurants;


-- Preview restaurant records

SELECT *
FROM restaurants
LIMIT 5;


-- =================================================
-- FOOD TABLE
-- =================================================

CREATE TABLE food (
    f_id VARCHAR PRIMARY KEY,
    item VARCHAR,
    veg_or_non_veg VARCHAR
);



-- =================================================
-- INITIAL ORDERS TABLE (TRIAL VERSION)
-- =================================================

/*
Trial and Error Query

Initial version of the orders table created during
database setup before final datatype optimization.
*/

CREATE TABLE orders (
    order_date DATE,
    sales_qty INT,
    sales_amount INT,
    currency TEXT,
    user_id INT,
    r_id INT
);



-- =================================================
-- MENU TABLE (INITIAL VERSION)
-- =================================================

CREATE TABLE menu (
    menu_id VARCHAR,
    r_id BIGINT,
    f_id VARCHAR,
    cuisin VARCHAR,
    price INT
);



-- =================================================
-- TRIAL & ERROR SECTION
-- =================================================

/*
The following queries were used during schema testing,
datatype correction, and table redesign validation.
*/


-- Trial query used while redesigning restaurants table

DROP TABLE restaurants;


-- =================================================
-- FINAL ORDERS TABLE
-- =================================================

/*
Final optimized version of the orders table
with improved datatype formatting.
*/

CREATE TABLE orders (
    order_date DATE,
    sales_qty INT,
    sales_amount DECIMAL(12, 2),
    currency VARCHAR(4),
    user_id INT,
    r_id INT
);


-- Trial query used during orders table redesign

DROP TABLE orders;



-- =================================================
-- FINAL MENU TABLE
-- =================================================

CREATE TABLE menu (
    menu_id VARCHAR,
    r_id BIGINT,
    f_id VARCHAR,
    cuisin VARCHAR,
    price VARCHAR
);


-- Trial query used during menu table redesign

DROP TABLE menu;



-- =================================================
-- DATA VALIDATION QUERIES
-- =================================================

-- Preview orders data

SELECT *
FROM orders
LIMIT 10;