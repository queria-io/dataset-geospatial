{# 貨物自動車運送事業の事業実績と財務情報（全国のサンプル）（G空間情報センター links-kamotsujidousyaunsojigyo-2024 の 02_jigyoujissekihoukokusyo_zaimujyouho.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-kamotsujidousyaunsojigyo-2024/02_jigyoujissekihoukokusyo_zaimujyouho.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
