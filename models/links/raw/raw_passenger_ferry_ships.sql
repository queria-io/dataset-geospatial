{# 一般旅客定期航路事業許可申請書（船舶）（G空間情報センター links-ippanryokyakuteikikourojigyou-2024 の 01_ippanryokyakuteikikourojigyoukyokashinseisyo.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-ippanryokyakuteikikourojigyou-2024/01_ippanryokyakuteikikourojigyoukyokashinseisyo.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
