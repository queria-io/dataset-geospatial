{# 自動車運送事業の事故報告書（G空間情報センター links-jidousyaunsoujigyoujiko-2024 の 02_jikohoukokusyo.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-jidousyaunsoujigyoujiko-2024/02_jikohoukokusyo.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
