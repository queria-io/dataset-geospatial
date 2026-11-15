{# 宿泊旅行統計調査（都道府県別の延べ宿泊者数）（G空間情報センター links_kankoutoukei_2025 の 01_syukuhakuryokoutoukeityousa.csv）。取得したままの形 #}

select *
from read_csv('data/links/links_kankoutoukei_2025/01_syukuhakuryokoutoukeityousa.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
