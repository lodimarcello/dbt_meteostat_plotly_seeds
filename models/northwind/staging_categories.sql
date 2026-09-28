WITH standardized_data AS (
SELECT *
FROM {{source('northwind_data', 'categories')}}
)
SELECT category_id,
category_name
FROM standardized_data