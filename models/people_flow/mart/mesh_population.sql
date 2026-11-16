{# 1km メッシュ別の滞在人口。1 行が 1 メッシュ・1 か月・平休日・時間帯の 1 組。地図にしやすいようにメッシュの中心を付ける。 #}

select
    p.mesh_code,
    p.date,
    p.year,
    p.month,
    p.day_type,
    p.time_of_day,
    p.population,
    p.prefecture_code,
    p.city_code,
    p.lg_code,
    p.lng,
    p.lat,
    f.sha256 as source_sha256
from {{ ref('stg_mesh_population') }} p
join {{ ref('stg_people_flow_source_file') }} f on f.file = p.source_zip
order by p.date, p.mesh_code, p.dayflag, p.timezone
