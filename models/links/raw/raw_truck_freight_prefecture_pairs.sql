{# 自動車輸送統計調査（発地・着地の都道府県の組）（G空間情報センター links-modalshift-2024 の 02_jidousyayusoutoukeichousa.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-modalshift-2024/02_jidousyayusoutoukeichousa.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
