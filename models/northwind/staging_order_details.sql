WITH standardized_data AS (
SELECT * 
FROM {{source('northwind_data', 'order_details')}}
)
SELECT REPLACE(CAST(order_id AS VARCHAR(10)), ',', '') AS order_id,
product_id,
unit_price::NUMERIC AS unit_price,
quantity,
discount::NUMERIC AS discount
FROM standardized_data