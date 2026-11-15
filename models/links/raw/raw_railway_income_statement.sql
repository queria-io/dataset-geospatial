{# 鉄道統計年報 損益計算書（G空間情報センター links-tetsudoujigyou-2025 の 05_tetsudou_sonekikeisansyo.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-tetsudoujigyou-2025/05_tetsudou_sonekikeisansyo.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
