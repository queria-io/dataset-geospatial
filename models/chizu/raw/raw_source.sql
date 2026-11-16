{# 取り込んだ zip の一覧。pipelines/chizu_download.py が data/chizu/sources.ndjson に書いたものをそのまま読む。 #}

select *
from read_json(
    'data/chizu/sources.ndjson',
    format = 'newline_delimited',
    columns = {
        file: 'VARCHAR',
        city_code: 'VARCHAR',
        registry_code: 'VARCHAR',
        year: 'INTEGER',
        title: 'VARCHAR',
        page_url: 'VARCHAR',
        zip_url: 'VARCHAR',
        size: 'BIGINT'
    }
)
