{# 鉄道統計年報 運輸成績表（延日キロ等）（G空間情報センター links-tetsudoujigyou-2025 の 02_tetsudou_unyuseiseki2.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-tetsudoujigyou-2025/02_tetsudou_unyuseiseki2.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
