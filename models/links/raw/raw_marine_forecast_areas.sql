{# 地方海上予報区（海域ポリゴン）（G空間情報センター links-ippanryokyakuteikikourojigyou-2024 の 03_chihoukaijyouyohouku_kaiikipolygon.geojson）。取得したままの形 #}

select *
from st_read('data/links/links-ippanryokyakuteikikourojigyou-2024/03_chihoukaijyouyohouku_kaiikipolygon.geojson')
