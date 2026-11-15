{# データ仕様書のコードリスト（pipelines/links.py が data/links/code_lists.csv にまとめる）。取得したままの形 #}

select *
from read_csv('data/links/code_lists.csv', header = true, all_varchar = true)
