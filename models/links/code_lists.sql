{# データ仕様書のコードリスト（pipelines/links.py が data/links/code_lists.csv にまとめる） #}

select
    package,
    field_name,
    {{ snake_case('field_name') }} as column_name,
    item_name,
    code,
    label
from read_csv('data/links/code_lists.csv', header = true, all_varchar = true)
