WITH updated_hourly AS (
SELECT
	*,
	DATE_PART('day', timestamp) AS date,
	DATE_PART('hour', timestamp) AS time,
	DATE_PART('hour', timestamp)::TEXT AS hour,
	TO_CHAR(timestamp, 'FMmonth') AS month_name,
	TO_CHAR(timestamp, 'FMDay') AS weekday,
	DATE_PART('day', timestamp) AS date_day,
	DATE_PART('month', timestamp) AS date_month,
	DATE_PART('year', timestamp) AS date_year,
	DATE_PART('week', timestamp) AS cw
FROM
	{{ref('staging_weather_hourly')}}
),
add_hourtime AS (
SELECT *,
	CASE
		WHEN DATE_PART('hour', timestamp) = 0
	THEN 'midnight'
		WHEN DATE_PART('hour', timestamp) < 6
	THEN 'night'
		WHEN DATE_PART('hour', timestamp) < 12
	THEN 'morning'
		WHEN DATE_PART('hour', timestamp) = 12
	THEN 'midday'
		WHEN DATE_PART('hour', timestamp) < 18
	THEN 'afternoon'
		ELSE 'evening'
		END AS day_part
	FROM
	updated_hourly
)
SELECT
	*
FROM
	add_hourtime;