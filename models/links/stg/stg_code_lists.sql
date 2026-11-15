{# データ仕様書のコードリスト（pipelines/links.py が data/links/code_lists.csv にまとめる） #}

select
    package,
    field_name,
    {{ snake_case('field_name') }} as column_name,
    item_name,
    code,
    label,
    'data/links/' || package || '/spec.json' as source_path
from {{ ref('raw_code_lists') }}
