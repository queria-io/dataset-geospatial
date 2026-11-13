{# 地方海上予報区（海域ポリゴン）（G空間情報センター links-ippanryokyakuteikikourojigyou-2024 の 03_chihoukaijyouyohouku_kaiikipolygon.geojson） #}

select
    "Code" as code,
    "Name" as name,
    "Namekana" as namekana,
    "ACCIDENT_COUNT" as accident_count,
    "geom" as geometry
from st_read('data/links/links-ippanryokyakuteikikourojigyou-2024/03_chihoukaijyouyohouku_kaiikipolygon.geojson')
