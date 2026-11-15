{# 船員法第111条に基づく事業状況報告（関東運輸局管内）（G空間情報センター links-naikoukaiungyou-2025 の 02_seninjoukyouhoukoku.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-naikoukaiungyou-2025/02_seninjoukyouhoukoku.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
