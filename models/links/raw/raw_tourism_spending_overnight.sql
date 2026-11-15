{# 旅行・観光消費動向調査（宿泊旅行）（G空間情報センター links_kankoutoukei_2025 の 02_ryokoukankousyouhidoukou_syukuhaku.csv）。取得したままの形 #}

select *
from read_csv('data/links/links_kankoutoukei_2025/02_ryokoukankousyouhidoukou_syukuhaku.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
