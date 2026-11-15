{# 自動車運送事業の事故報告書と交通事故統計の統合データ（G空間情報センター links-jidousyaunsoujigyoujiko-2025 の 01_jikohoukokusyo_koutsuujikotoukeijyouhou.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-jidousyaunsoujigyoujiko-2025/01_jikohoukokusyo_koutsuujikotoukeijyouhou.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
