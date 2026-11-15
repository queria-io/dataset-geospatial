{# 倉庫事業経営状況報告書（G空間情報センター links-soukogyou-2025 の 02_soukojigyou_keieijyoukyouhoukoku.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-soukogyou-2025/02_soukojigyou_keieijyoukyouhoukoku.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
