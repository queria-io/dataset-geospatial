{# 自家用有償旅客運送者登録簿（G空間情報センター links-rideshare-2025 の 02_jikayouyuushouryokyakuunsou_tourokubo.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-rideshare-2025/02_jikayouyuushouryokyakuunsou_tourokubo.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
