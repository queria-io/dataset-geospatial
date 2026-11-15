{# 貨物自動車運送事業の事業実績報告書（全国、2015〜2022年度）（G空間情報センター links-kamotsujidousyaunsojigyo-2024 の 01_jigyoujissekihoukokusyo.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-kamotsujidousyaunsojigyo-2024/01_jigyoujissekihoukokusyo.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
