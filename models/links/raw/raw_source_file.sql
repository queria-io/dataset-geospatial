{# 取得したファイルの記録 (data/links/source_file.parquet、pipelines/source_file.py が書く)。取得したままの形 #}

select * from read_parquet('data/links/source_file.parquet')
