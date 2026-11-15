{# 内航船舶輸送統計調査による事業者別の生産性（G空間情報センター links-naikoukaiungyou-2024 の 02_naikoukaiungyou_naikousenpakuyusoutoukei.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-naikoukaiungyou-2024/02_naikoukaiungyou_naikousenpakuyusoutoukei.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, strict_mode = false, filename = true)
