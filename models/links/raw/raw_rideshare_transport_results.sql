{# 自家用有償旅客運送輸送実績報告書（G空間情報センター links-rideshare-2025 の 01_jikayouyuushouryokyakuunsou_yusoujissekihoukokusho.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-rideshare-2025/01_jikayouyuushouryokyakuunsou_yusoujissekihoukokusho.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
