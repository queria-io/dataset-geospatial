{# 鉄道統計年報 営業キロ及び走行キロ（G空間情報センター links-tetsudoujigyou-2025 の 03_tetsudou_eigyoukiro.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-tetsudoujigyou-2025/03_tetsudou_eigyoukiro.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
