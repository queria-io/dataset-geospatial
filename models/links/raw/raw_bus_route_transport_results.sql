{# 一般乗合旅客自動車運送事業輸送実績報告（路線バス）（G空間情報センター links-ippanryokyaku-2025 の 01_ippannoriairyokyaku_yusoujisseki.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-ippanryokyaku-2025/01_ippannoriairyokyaku_yusoujisseki.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
