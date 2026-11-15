{# 一般乗用旅客自動車運送事業輸送実績報告（タクシー・ハイヤー）（G空間情報センター links-ippanryokyaku-2025 の 03_ippanjyouyouryokyaku_yusoujisseki.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-ippanryokyaku-2025/03_ippanjyouyouryokyaku_yusoujisseki.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
