{# 内航海運業の事業概況報告（2024年度公開）（G空間情報センター links-naikoukaiungyou-2024 の 01_naikoukaiungyou_jigyougaikyouhoukoku.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-naikoukaiungyou-2024/01_naikoukaiungyou_jigyougaikyouhoukoku.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
