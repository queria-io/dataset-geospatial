{# 小型無人機等飛行禁止法のレッドゾーン（G空間情報センター links-mujinkoukuukihikoukeikaku-2024 の 05_kakusyukuuikijyouhou_redzone.geojson） #}

select
    "name" as name,
    "geom" as geometry,
    filename as source_path
from {{ ref('raw_drone_airspace_red_zone') }}
