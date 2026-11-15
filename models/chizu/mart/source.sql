{# 取り込んだ zip。1 行が 1 zip（市区町村の 1 登記所）。出典の表示に使うページ URL を持つ。 #}

select *
from {{ ref('stg_source') }}
order by file
