{# 1km メッシュ別の滞在人口。1 行が 1 メッシュ・1 か月・平休日・時間帯の 1 組。地図にしやすいようにメッシュの中心を付ける。 #}

select
    mesh_code,
    date,
    year,
    month,
    day_type,
    time_of_day,
    population,
    prefecture_code,
    city_code,
    lg_code,
    lng,
    lat
from {{ ref('stg_mesh_population') }}
order by date, mesh_code, dayflag, timezone
