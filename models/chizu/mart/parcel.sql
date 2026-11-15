{# 登記所備付地図の筆。1 行が 1 筆。地域で引くので市区町村・大字・丁目・小字の順に並べる。
   全国で 2.4 億筆・17.5GB あり、既定の並列のまま R2 へ書くと、Parquet を読むファイルと
   マルチパートアップロードの接続で、開けるファイル数の上限（macOS の既定 256）を使い切る。
   名前解決もできなくなり「Could not resolve hostname」で落ちるので、並列を絞る。
   DuckDB 2.0 には s3_uploader_thread_limit が無いので、threads だけを絞る。 #}

{{ config(pre_hook=["SET threads = 4"]) }}

select *
from {{ ref('stg_parcel') }}
order by city_code, oaza_code, chome_code, koaza_code, yobi_code, chiban, file, fude_id
