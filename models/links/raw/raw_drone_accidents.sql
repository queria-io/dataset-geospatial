{# 無人航空機の事故等報告（G空間情報センター links-mujinkoukuukihikoukeikaku-2025_ の 02_jikojyouhou.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-mujinkoukuukihikoukeikaku-2025_/02_jikojyouhou.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
