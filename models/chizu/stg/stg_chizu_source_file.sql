{# zip を取得した記録に型を付ける。 #}

select
    file,
    url,
    sha256,
    bytes,
    media_type,
    cast(retrieved_at as timestamptz) as retrieved_at,
    etag,
    last_modified
from {{ ref('raw_chizu_source_file') }}
