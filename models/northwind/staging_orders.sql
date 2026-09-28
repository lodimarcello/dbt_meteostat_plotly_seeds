WITH standardized_data AS (
SELECT
	*
FROM
	{{source('northwind_data', 'orders')}}
)
SELECT
	REPLACE(CAST(order_id AS VARCHAR(10)), ',', '') as order_id,
	INITCAP(customer_id) as customer_id,
	employee_id,
	CAST(order_date AS DATE),
	CAST(required_date AS DATE),
	CAST(shipped_date AS DATE),
	ship_via,
	freight,
	ship_address,
	ship_city,
	ship_postal_code,
	ship_country
FROM
	standardized_data