{# 一般旅客自動車運送事業の事業概況報告（乗合・貸切・乗用）（G空間情報センター links-ippanryokyaku-2025 の 04_ippanryokyakujidousya_jigyougaikyou.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-ippanryokyaku-2025/04_ippanryokyakujidousya_jigyougaikyou.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
