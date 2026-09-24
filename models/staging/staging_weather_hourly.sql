WITH hourly_raw AS (
					SELECT airport_code
							,station_id
							,JSON_ARRAY_ELEMENTS(extracted_data -> 'data') AS json_data
					FROM {{source('weather_data', 'weather_hourly_raw')}}		
),
hourly_flattened AS (
					SELECT airport_code
							,station_id
							,(json_data ->> 'time')::DATE AS date
							,(json_data ->> 'temp')::NUMERIC AS temperature
							,(json_data ->> 'dwpt')::NUMERIC AS dew_point_c
							,(json_data ->> 'rhum')::NUMERIC AS relative_humidity_p
							,(json_data ->> 'prcp')::NUMERIC AS precipitation_mm
							,(json_data ->> 'snow')::NUMERIC::INTEGER AS max_snow_mm
							,(json_data ->> 'wdir')::NUMERIC::INTEGER AS avg_wind_direction
							,(json_data ->> 'wspd')::NUMERIC AS avg_wind_speed
							,(json_data ->> 'wpgt')::NUMERIC AS avg_peakgust
							,(json_data ->> 'pres')::NUMERIC AS avg_pressure_hpa
							,(json_data ->> 'tsun')::NUMERIC::INTEGER AS sun_minutes
							,(json_data ->> 'coco')::NUMERIC::INTEGER AS condition_code
						FROM hourly_raw
)
SELECT * FROM hourly_flattened