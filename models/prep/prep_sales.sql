WITH orders AS (
SELECT * 
FROM {{ref('staging_orders')}}
),
order_details AS (
SELECT *
FROM {{ref('staging_order_details')}}
),
categories AS (
SELECT *
FROM {{ref('staging_categories')}}
),
products AS (
SELECT *
FROM {{ref('staging_products')}}
),
merged_tables AS (
SELECT orders.order_id,
customer_id,
category_name,
products.category_id,
order_details.unit_price,
quantity,
discount,
EXTRACT(YEAR FROM order_date) AS order_year,
EXTRACT(MONTH FROM order_date) AS order_month,
order_details.unit_price * quantity * (1 - discount) AS revenue
FROM orders
JOIN order_details
ON orders.order_id = order_details.order_id
JOIN products
ON products.product_id = order_details.product_id
JOIN categories
ON products.category_id = categories.category_id
)
SELECT * FROM merged_tables