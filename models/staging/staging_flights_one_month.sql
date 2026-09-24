{{ config(materialized='view') }} --only creating a view
    
    WITH flights_one_month AS (
        SELECT * 
        FROM {{source('flights_data', 'flights')}}
        WHERE DATE_PART('month', flight_date) = 1 --limiting to one month only as dataset is very large
    )
    SELECT * FROM flights_one_month