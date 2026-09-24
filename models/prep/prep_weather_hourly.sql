WITH updated_hourly AS (
SELECT
	*,
	DATE_PART('day', timestamp) AS date,
	DATE_PART('hour', timestamp) AS time,
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
SELECT
	airport_code,
	station_id,
	timestamp,
	temp_c,
	dewpoint_c,
	humidity_perc,
	precipitation_mm,
	snow_mm,
	wind_direction,
	wind_speed_kmh,
	wind_peakgust_kmh,
	pressure_hpa,
	sun_minutes,
	condition_code,
	date,
	time,
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
		END AS HOUR,
		month_name,
		weekday,
		date_day,
		date_month,
		date_year,
		cw	
FROM
	updated_hourly
)
SELECT
	*
FROM
	add_hourtime