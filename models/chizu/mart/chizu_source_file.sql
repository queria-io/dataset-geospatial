{{ config(alias='source_file') }}

{# 取り込んだ zip。1 行が 1 zip（市区町村の 1 登記所）。取得の記録と、出典の表示に使うページ URL を持つ。 #}

select
    f.url,
    s.page_url,
    f.sha256,
    f.bytes,
    f.media_type,
    f.retrieved_at,
    f.etag,
    f.last_modified,
    s.file,
    s.city_code,
    s.lg_code,
    s.registry_code,
    s.year,
    s.title
from {{ ref('stg_source') }} s
join {{ ref('stg_chizu_source_file') }} f using (file)
order by s.file
