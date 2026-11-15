{# 鉄道統計年報 鉄軌道業営業損益（G空間情報センター links-tetsudoujigyou-2025 の 04_tetsudou_eigyousoneki.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-tetsudoujigyou-2025/04_tetsudou_eigyousoneki.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
