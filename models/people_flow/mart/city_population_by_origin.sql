{# 市区町村単位発地別の滞在人口。1 行が 1 市区町村・1 か月・平休日・時間帯・居住地区分の 1 組。 #}

select
    prefecture_code,
    city_code,
    lg_code,
    date,
    year,
    month,
    day_type,
    time_of_day,
    origin,
    population
from {{ ref('stg_city_population_by_origin') }}
order by city_code, date, dayflag, timezone, from_area
