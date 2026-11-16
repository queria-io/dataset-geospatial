{{ config(alias='source_file') }}

{# 取得した zip。1 行が 1 zip。 #}

select url, page_url, sha256, bytes, media_type, retrieved_at, etag, last_modified, file
from (
    select *, 'https://www.geospatial.jp/ckan/dataset/mlit-1km-fromto' as page_url
    from {{ ref('stg_people_flow_source_file') }}
)
order by file
