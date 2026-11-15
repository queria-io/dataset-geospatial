{# 空港等の周辺空域（G空間情報センター links-mujinkoukuukihikoukeikaku-2024 の 03_kakusyukuuikijyouhou_syuuhenkuuiki.geojson）。取得したままの形 #}

select *, 'data/links/links-mujinkoukuukihikoukeikaku-2024/03_kakusyukuuikijyouhou_syuuhenkuuiki.geojson' as filename
from st_read('data/links/links-mujinkoukuukihikoukeikaku-2024/03_kakusyukuuikijyouhou_syuuhenkuuiki.geojson')
