{# 空港等の周辺空域（G空間情報センター links-mujinkoukuukihikoukeikaku-2024 の 03_kakusyukuuikijyouhou_syuuhenkuuiki.geojson） #}

select
    "name" as name,
    "geom" as geometry
from {{ ref('raw_drone_airspace_airport_vicinity') }}
