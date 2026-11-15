{# 期末倉庫使用状況報告書（全国、2019〜2024年度）（G空間情報センター links-soukogyou-2025 の 01_kimatsusoukoshiyoujyoukyouhoukokusyo.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-soukogyou-2025/01_kimatsusoukoshiyoujyoukyouhoukokusyo.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
