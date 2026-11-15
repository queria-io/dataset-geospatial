{# 小型無人機等飛行禁止法のレッドゾーン（G空間情報センター links-mujinkoukuukihikoukeikaku-2024 の 05_kakusyukuuikijyouhou_redzone.geojson）。取得したままの形 #}

select *
from st_read('data/links/links-mujinkoukuukihikoukeikaku-2024/05_kakusyukuuikijyouhou_redzone.geojson')
