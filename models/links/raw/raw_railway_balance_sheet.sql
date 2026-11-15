{# 鉄道統計年報 貸借対照表（G空間情報センター links-tetsudoujigyou-2025 の 06_tetsudou_taisyakutaisyouhyou.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-tetsudoujigyou-2025/06_tetsudou_taisyakutaisyouhyou.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
