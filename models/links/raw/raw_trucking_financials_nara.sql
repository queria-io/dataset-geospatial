{# 貨物自動車運送事業の財務情報（奈良運輸支局管内、2023年度）（G空間情報センター links-kamotsujidousyaunsojigyo-2025 の 02_zaimujyouho_2025.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-kamotsujidousyaunsojigyo-2025/02_zaimujyouho_2025.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
