{# 全国版空き家・空き地バンクの登録物件（G空間情報センター links-akiyabank-2025 の 01_tourokubukken.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-akiyabank-2025/01_tourokubukken.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
