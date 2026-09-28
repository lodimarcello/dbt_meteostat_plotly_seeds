WITH sales_data AS (
    SELECT * FROM {{ref('prep_sales')}}
),
aggregated_data AS (
    SELECT order_year,
    order_month,
    category_name,
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(revenue), 2) AS average_revenue_per_order
    FROM sales_data
    GROUP BY 1, 2, 3
    ORDER BY order_year,
    order_month,
    category_name
)
SELECT * FROM aggregated_data