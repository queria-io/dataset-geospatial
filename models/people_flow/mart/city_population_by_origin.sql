{# 市区町村単位発地別の滞在人口。1 行が 1 市区町村・1 か月・平休日・時間帯・居住地区分の 1 組。 #}

select
    p.prefecture_code,
    p.city_code,
    p.lg_code,
    p.date,
    p.year,
    p.month,
    p.day_type,
    p.time_of_day,
    p.origin,
    p.population,
    f.sha256 as source_sha256
from {{ ref('stg_city_population_by_origin') }} p
join {{ ref('stg_people_flow_source_file') }} f on f.file = p.source_zip
order by p.city_code, p.date, p.dayflag, p.timezone, p.from_area
