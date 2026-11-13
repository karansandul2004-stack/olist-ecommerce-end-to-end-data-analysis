create database olist_store_project;

use olist_store_project;
show tables;
DROP TABLE IF EXISTS olist_master_dataset;

CREATE TABLE olist_dataset (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),

    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),

    customer_id VARCHAR(50),
    order_status VARCHAR(30),

    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,

    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,

    product_weight_g DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm DECIMAL(10,2),

    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10),

    payment_count INT,
    payment_value_total DECIMAL(10,2),
    payment_installments_max INT,
    payment_types VARCHAR(100),

    review_count INT,
    review_score_avg DECIMAL(3,2),
    review_score_min INT,
    review_score_max INT,

    product_category_name_english VARCHAR(100)
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_master_dataset.csv" 
into table olist_dataset
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_master_dataset.csv'
INTO TABLE olist_dataset
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value,
    customer_id,
    order_status,
    order_purchase_timestamp,
    @order_approved_at,
    @order_delivered_carrier_date,
    @order_delivered_customer_date,
    order_estimated_delivery_date,
    product_category_name,
    @product_name_lenght,
	@product_description_lenght,
	@product_photos_qty,
	@product_weight_g,
	@product_length_cm,
	@product_height_cm,
	@product_width_cm,
    seller_zip_code_prefix,
    seller_city,
    seller_state,
    @payment_count,
    @payment_value_total,
    @payment_installments_max,
    @payment_types,
    @review_count,
    @review_score_avg,
    @review_score_min,
    @review_score_max,
    product_category_name_english
)
SET
    order_approved_at = NULLIF(@order_approved_at, ''),
    order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
    order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),
    payment_count = NULLIF(@payment_count, ''),
    payment_value_total = NULLIF(@payment_value_total, ''),
    payment_installments_max = NULLIF(@payment_installments_max, ''),
    payment_types = NULLIF(@payment_types, ''),
    review_count = NULLIF(@review_count, ''),
    review_score_avg = NULLIF(@review_score_avg, ''),
    review_score_min = NULLIF(@review_score_min, ''),
    review_score_max = NULLIF(@review_score_max, '');

alter Table olist_dataset
modify payment_value_total Decimal(12,4);

/* 1. How many total order items are there?*/
select count(*) as total_order_items from olist_dataset;

/* 2. How many unique orders are there?*/
select count(distinct order_id) as unique_orders from olist_dataset;

/* 3. How many unique customers are there?*/
Select count(distinct customer_id) as unique_customers from olist_dataset;

/* 4. How many unique products are sold?*/
Select count(distinct product_id) as unique_products from olist_dataset;

/* 5. How many unique sellers are there?*/
Select count(distinct seller_id) as unique_sellers from olist_dataset;

/* 6. What is the total revenue generated from products?*/
Select Sum(price) as revenue from olist_dataset;

/* 7. What is the total freight revenue?*/
Select sum(freight_value) as freight_revenue from olist_dataset;

/*8. What is the average product price?*/
select avg(price) as product_price from olist_dataset;

/* 9. What is the average freight value?*/
select avg(freight_value) as avg_freight_value from olist_dataset;

/* 10. What is the average order value?*/
Select avg(order_value) as avg_order_value
from (
	Select order_id,sum(price) as order_value
	from olist_dataset
	group by order_id
    )
as order_value;

/* 11. What are the different order statuses? */
select distinct order_status from olist_dataset;

/* 12. How many orders exist for each order status? */
Select order_status, count(distinct order_id) as order_count from olist_dataset
group by order_status;

/* 13. What are the different payment types?*/
select distinct payment_types from olist_dataset;

/*14. How many orders use each payment type?*/
Select payment_types, count(distinct order_id) as orders_count from olist_dataset
group by payment_types;

/*15. What is the average review score? */
SELECT AVG(review_score_avg) AS avg_review_score
FROM (
    SELECT order_id, MAX(review_score_avg) AS review_score_avg
    FROM olist_dataset
    GROUP BY order_id
) AS order_reviews;

/* Sales Analysis */

/*16. What is the total revenue generated by each month?*/
SELECT 
    YEAR(order_purchase_timestamp) AS years,
    MONTH(order_purchase_timestamp) AS months,
    SUM(price) AS revenue
FROM
    olist_dataset
GROUP BY YEAR(order_purchase_timestamp) , MONTH(order_purchase_timestamp)
ORDER BY years , months;

/*17. Which month generated the highest revenue?*/
SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    SUM(price) AS revenue
FROM olist_dataset
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY revenue DESC
LIMIT 1;

/*18. Which month generated the lowest revenue? */
SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    SUM(price) AS revenue
FROM olist_dataset
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY revenue
LIMIT 1;

/*19. How many orders were placed each month? */
SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    COUNT(DISTINCT order_id) AS orders_placed
FROM olist_dataset
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY order_year, order_month;

/*20. Which month had the highest number of orders? */
SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    COUNT(DISTINCT order_id) AS orders_placed
FROM olist_dataset
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY orders_placed DESC
LIMIT 1;

/* 21. What is the average order value for each month?*/
SELECT 
	Year(order_purchase_timestamp) as years,
    MONTH(order_purchase_timestamp) AS months,
    AVG(order_value) AS avg_order_value
FROM
    (SELECT 
        order_id,
            SUM(price) AS order_value,
            MAX(order_purchase_timestamp) AS order_purchase_timestamp
    FROM
        olist_dataset
    GROUP BY order_id) AS order_values
GROUP BY Year(order_purchase_timestamp),
MONTH(order_purchase_timestamp)
ORDER BY years,months;

/*22. What is the total revenue generated by each year?*/

Select
	Year(order_purchase_timestamp) as Years,
    Sum(price) as revenue
From olist_dataset
group by Year(order_purchase_timestamp);

/*23. Which year generated the highest revenue? */
Select
	Year(order_purchase_timestamp) as Years,
    Sum(price) as revenue
From olist_dataset
group by Year(order_purchase_timestamp)
order by revenue desc limit 1;

/* 24. What percentage of total revenue comes from each month? */

With monthly_sales as (
Select date_format(order_purchase_timestamp, '%Y-%m') as year_monthly,
sum(price) as monthly_sales
from olist_dataset
group by date_format(order_purchase_timestamp, '%Y-%m')
)
Select 
	year_monthly,
    monthly_sales,
    Round(monthly_sales * 100.0 / Sum(monthly_sales) over(), 2) as percentage_of_total
from monthly_sales
group by year_monthly;

/*25. Which product categories generate the highest revenue? */

select product_category_name, Sum(price) as highest_revenue from olist_dataset
group by product_category_name
order by highest_revenue desc limit 1;

/* 26. Which product categories generate the lowest revenue? */

select product_category_name, Sum(price) as lowest_revenue from olist_dataset
group by product_category_name
order by lowest_revenue limit 1;

/* 27. What is the average selling price for each product category? */

select product_category_name, avg(price) as avg_revenue from olist_dataset
group by product_category_name
order by avg_revenue;

/* 28. Which categories have the highest average product price? */

select product_category_name, avg(price) as avg_revenue from olist_dataset
group by product_category_name
order by avg_revenue desc;

/*29. Which categories have the highest number of order items? */

select product_category_name, count(order_item_id) as order_items from olist_dataset
group by product_category_name
order by order_items desc limit 1;

/* 30. Which categories generate high revenue despite having relatively few orders? */

With category_performance as (
	Select product_category_name_english as category,
    Count(distinct order_id) as total_orders,
    Round(sum(price),2) as total_revenue,
    Round(sum(price) / count(distinct order_id),2) as revenue_per_order
    from olist_dataset
    where product_category_name_english is not null
    group by product_category_name_english
)
Select 
	category,
    total_revenue,
    total_orders,
    revenue_per_order
from category_performance
where total_revenue > (Select avg(total_revenue) from category_performance)
And
total_orders < (Select avg(total_orders) from category_performance)
order by revenue_per_order desc;

CREATE TABLE customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_customers.csv"
into table customers
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows
(
customer_id,
customer_unique_id,
@customer_zip_code_prefix,
customer_city,
customer_state
)
set customer_zip_code_prefix =
	nullif(@customer_zip_code_prefix, '');

SHOW VARIABLES LIKE 'secure_file_priv';
/* Customer Analysis */
/* 31. How many unique customers are there in each state? */

Select customer_state, count(distinct customer_unique_id) as unique_customer
from customers
group by customer_state;

/* 32. Which state has the highest number of customers? */

Select customer_state, count(distinct customer_unique_id) as unique_customer
from customers
group by customer_state
order by unique_customer desc limit 1;

/* 33. Which state has the lowest number of customers? */

Select customer_state, count(distinct customer_unique_id) as unique_customer
from customers
group by customer_state
order by unique_customer limit 1;

/* 34. How many orders does each customer place? */

Select customer_id, count(distinct order_id) as order_counts from olist_dataset
group by customer_id;

/* 35. Who are the top 10 customers by number of orders? */

Select customer_id, count(distinct order_id) as order_counts from olist_dataset
group by customer_id
order by order_counts desc limit 10;

/* 36. Who are the top 10 customers by total spending? */

Select customer_id, sum(price) as total_spending from olist_dataset
group by customer_id
order by total_spending desc limit 10;

/* 37. What is the average spending per customer? */

Select customer_id, avg(order_value) as avg_spending_per_order 
from 
(Select customer_id,
	order_id,
    sum(price) as order_value
    from olist_dataset
    group by customer_id, order_id
    ) as customer_orders
group by customer_id;

/* 38. How many customers placed more than one order? */

SELECT COUNT(*) AS repeat_customers
FROM (
    SELECT customer_id
    FROM olist_dataset
    GROUP BY customer_id
    HAVING COUNT(DISTINCT order_id) > 1
) AS customer_orders;

/* 39. How many customers placed exactly one order? */

SELECT COUNT(*) AS one_order_customers
FROM (
    SELECT customer_id
    FROM olist_dataset
    GROUP BY customer_id
    HAVING COUNT(DISTINCT order_id) = 1
) AS customer_orders;

/* 40. What percentage of customers are repeat customers? */

SELECT
    ROUND(
        100.0 * SUM(CASE WHEN order_counts > 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS repeat_customer_percentage
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS order_counts
    FROM olist_dataset
    GROUP BY customer_id
) AS customer_orders;

/* 41. Which customers have spent more than the average customer spending? */

WITH customer_spending AS (
    SELECT 
        customer_id,
        SUM(price) AS total_spent
    FROM olist_dataset
    GROUP BY customer_id
)
SELECT 
    customer_id,
    ROUND(total_spent, 2) AS total_spent
FROM customer_spending
WHERE total_spent > (SELECT AVG(total_spent) FROM customer_spending)
ORDER BY total_spent DESC;

/* 42. Which customers have placed more orders than the average customer? */

With avg_customers as
(
	Select customer_id, count(distinct order_id) as total_order
    from olist_dataset
    group by customer_id
)
Select customer_id, total_order
from avg_customers
where total_order > (select avg(total_order) from avg_customers)
order by total_order desc;

/* 43. What is the average order value for repeat customers vs one-time customers? */

WITH customer_order_counts AS (
    SELECT 
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM olist_dataset
    GROUP BY customer_id
),
order_totals AS (
    SELECT 
        o.order_id,
        SUM(o.price) AS order_value,
        CASE 
            WHEN c.total_orders > 1 THEN 'Repeat Customer'
            ELSE 'One-Time Customer'
        END AS customer_type
    FROM olist_dataset o
    JOIN customer_order_counts c ON o.customer_id = c.customer_id
    GROUP BY o.order_id, c.total_orders
)
SELECT 
    customer_type,
    COUNT(DISTINCT order_id) AS total_orders_placed,
    ROUND(AVG(order_value), 2) AS avg_order_value
FROM order_totals
GROUP BY customer_type;