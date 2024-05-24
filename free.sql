--Free hand sql for duckdb
FROM air_ambient;
DESCRIBE air_ambient;
SELECT city, avg(ifnull(pm10_concentration,0)) FROM  air_ambient GROUP BY ALL 
having avg(ifnull(pm10_concentration,0)) > 0
ORDER BY  2 desc;

CREATE TABLE city_pm10_valid AS SELECT DISTINCT
city FROM  
WHERE pm10_concentration <> 0;

--- Determine 5 top cities where air become more pure
WITH rank_city as (
SELECT
country_name, city, year,
rank() OVER(PARTITION BY country_name order by lag asc ) as rank,
lag,
pm10_concentration_y_1,
pm10_concentration
from
    (---- one year lag on pm10_concentration for each city
    SELECT air_ambient.country_name, air_ambient.city, air_ambient.year, 
    lag(pm10_concentration, 1) OVER(PARTITION BY country_name, air_ambient.city ORDER BY year asc)  as pm10_concentration_y_1, 
    (pm10_concentration - pm10_concentration_y_1 ) / pm10_concentration_y_1 *100 as lag,
    pm10_concentration,
    no2_concentration
    FROM air_ambient
    INNER JOIN city_pm10_valid on air_ambient.city = city_pm10_valid.city
    order by  air_ambient.country_name, air_ambient.city, air_ambient.year
    )

)
SELECT * FROM rank_city WHERE rank <= 5;

