{# 登記所備付地図の筆。pipelines/chizu_convert.py が地図 XML の zip ごとに書いた Parquet をそのまま読む（形は WKB）。 #}

select * from read_parquet('data/chizu/parcel/*.parquet')
