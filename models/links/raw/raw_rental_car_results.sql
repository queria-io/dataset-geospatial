{# 貸渡実績報告書（レンタカー）（G空間情報センター links-rentacars-2025 の 01_yousiki1_kashiwatashijissekihoukokusho.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-rentacars-2025/01_yousiki1_kashiwatashijissekihoukokusho.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
