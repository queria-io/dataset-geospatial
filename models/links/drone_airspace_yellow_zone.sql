{# 小型無人機等飛行禁止法のイエローゾーン（G空間情報センター links-mujinkoukuukihikoukeikaku-2024 の 04_kakusyukuuikijyouhou_yellowzone.geojson） #}

select
    "name" as name,
    "geom" as geometry
from st_read('data/links/links-mujinkoukuukihikoukeikaku-2024/04_kakusyukuuikijyouhou_yellowzone.geojson')
