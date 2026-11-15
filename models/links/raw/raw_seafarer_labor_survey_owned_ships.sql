{# 船員労働統計調査 第一号調査（G空間情報センター links-naikoukaiungyou-2025 の 03_seninroudoutoukeityousa_1goutyousa.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-naikoukaiungyou-2025/03_seninroudoutoukeityousa_1goutyousa.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
