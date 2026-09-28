WITH standardized_data AS (
SELECT *
FROM {{source('northwind_data', 'products')}}
)
SELECT product_id,
--product_name,
supplier_id,
category_id,
--quantity_per_unit,
unit_price,
units_in_stock
--units_on_order
--reorder_level,
--discontinued
FROM standardized_data