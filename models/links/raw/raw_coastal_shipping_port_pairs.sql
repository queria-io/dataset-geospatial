{# 内航船舶輸送統計調査（積地・揚地の港の組）（G空間情報センター links-modalshift-2024 の 01_naikousenpakuyusoutoukeichousa.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-modalshift-2024/01_naikousenpakuyusoutoukeichousa.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
