{# 船舶事故等調査報告書（G空間情報センター links-ippanryokyakuteikikourojigyou-2024 の 02_senpakujikohoukokusyo.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-ippanryokyakuteikikourojigyou-2024/02_senpakujikohoukokusyo.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
