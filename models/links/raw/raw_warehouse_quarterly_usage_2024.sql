{# 期末倉庫使用状況報告書（2024年度公開）（G空間情報センター links-soukogyou-2024 の 02_kimatsusoukoshiyoujyoukyouhoukokusyo.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-soukogyou-2024/02_kimatsusoukoshiyoujyoukyouhoukokusyo.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
