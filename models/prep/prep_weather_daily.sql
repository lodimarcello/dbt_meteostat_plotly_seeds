WITH date_parts AS (
SELECT
	*,
	DATE_PART('day', date) AS date_day,
	DATE_PART('month', date) AS date_month,
	DATE_PART('year', date) AS date_year,
	DATE_PART('week', date) AS date_week,
	TO_CHAR(date, 'FMmonth') AS month_name,
	TO_CHAR(date, 'FMDay') AS weekday
FROM
	{{ref('staging_weather_daily')}}
	),
	add_seasons AS (
SELECT
	*,
	(CASE
		WHEN month_name IN ('november', 'december', 'january', 'february') 
		THEN 'winter'
		WHEN month_name IN ('march', 'april', 'may')
		THEN 'spring'
		WHEN month_name IN ('june', 'july', 'august')
		THEN 'summer'
		WHEN month_name IN ('september', 'october')
		THEN 'autumn'
	END) AS season
FROM
	date_parts
	)
SELECT
	*
FROM
	add_seasons