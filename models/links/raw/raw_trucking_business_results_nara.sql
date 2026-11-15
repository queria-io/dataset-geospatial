{# 貨物自動車運送事業の事業実績報告書（奈良運輸支局管内、2023年度）（G空間情報センター links-kamotsujidousyaunsojigyo-2025 の 01_jigyoujissekihoukokusyo_2025.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-kamotsujidousyaunsojigyo-2025/01_jigyoujissekihoukokusyo_2025.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
