{# 登記所備付地図の筆。pipelines/chizu_convert.py が地図 XML の zip ごとに書いた Parquet をそのまま読む（形は WKB）。
   filename は読んだ Parquet の置き場所で、名前が zip の名前（拡張子を除く）と同じ。 #}

select * from read_parquet('data/chizu/parcel/*.parquet', filename = true)
