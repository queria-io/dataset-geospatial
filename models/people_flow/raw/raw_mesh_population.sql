{# 1km メッシュ別の滞在人口。pipelines/people_flow.py が書いた data/people_flow/mesh_1km/<都道府県>.parquet
   （全年月の CSV を都道府県ごとにまとめ、値は文字列のまま）をそのまま読む。
   filename は読んだ Parquet の置き場所で、名前が都道府県コード（monthly_mdp_mesh1km_<都道府県コード>.zip から作った）。 #}

select * from read_parquet('data/people_flow/mesh_1km/*.parquet', filename = true)
