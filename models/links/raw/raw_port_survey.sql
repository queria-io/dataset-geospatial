{# 港湾調査（G空間情報センター links-naikoukaiungyou-2024 の 03_kouwanchousa.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-naikoukaiungyou-2024/03_kouwanchousa.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
