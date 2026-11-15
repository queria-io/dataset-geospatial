{# 市区町村単位発地別の滞在人口。pipelines/people_flow.py が書いた data/people_flow/city_from_area/<都道府県>.parquet
   （全年月の CSV を都道府県ごとにまとめ、値は文字列のまま）をそのまま読む。
   filename は読んだ Parquet の置き場所で、名前が都道府県コード（monthly_fromto_city_<都道府県コード>.zip から作った）。 #}

select * from read_parquet('data/people_flow/city_from_area/*.parquet', filename = true)
