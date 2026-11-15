{# 倉庫業登録申請書と倉庫明細書（中部運輸局管内）（G空間情報センター links-soukogyou-2024 の 01_soukogyoutourokushinseisyo.csv）。取得したままの形 #}

select *
from read_csv('data/links/links-soukogyou-2024/01_soukogyoutourokushinseisyo.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1, filename = true)
