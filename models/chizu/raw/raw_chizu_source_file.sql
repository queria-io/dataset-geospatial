{# 取り込んだ zip を取得した記録。pipelines/chizu.py が data/chizu/source_file.ndjson に書いたものをそのまま読む。 #}

select *
from read_json(
    'data/chizu/source_file.ndjson',
    format = 'newline_delimited',
    columns = {
        file: 'VARCHAR',
        url: 'VARCHAR',
        sha256: 'VARCHAR',
        bytes: 'BIGINT',
        media_type: 'VARCHAR',
        retrieved_at: 'VARCHAR',
        etag: 'VARCHAR',
        last_modified: 'VARCHAR'
    }
)
