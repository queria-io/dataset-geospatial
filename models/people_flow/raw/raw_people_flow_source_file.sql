{# 取得した zip の記録。pipelines/people_flow.py が data/people_flow/source_file.ndjson に書いたものをそのまま読む。 #}

select *
from read_json(
    'data/people_flow/source_file.ndjson',
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
