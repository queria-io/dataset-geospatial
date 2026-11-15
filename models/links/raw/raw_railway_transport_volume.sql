{# 鉄道統計年報 運輸成績表（数量）（G空間情報センター links-tetsudoujigyou-2025 の 01_tetsudou_unyuseiseki1.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-tetsudoujigyou-2025/01_tetsudou_unyuseiseki1.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
