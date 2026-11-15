{# 全国版空き家・空き地バンクの成約物件（G空間情報センター links-akiyabank-2025 の 02_seiyakubukken.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-akiyabank-2025/02_seiyakubukken.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
