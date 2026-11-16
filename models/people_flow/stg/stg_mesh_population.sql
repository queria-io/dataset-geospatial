{# 1km メッシュ別の滞在人口に型を付け、区分のコードを名前にする。メッシュの中心はメッシュコードから計算する（people_flow.mesh と同じ）。
   並べ替えに使うので原典のコードも残す #}

select
    mesh1kmid as mesh_code,
    make_date(cast(year as integer), cast(month as integer), 1) as date,
    cast(year as integer) as year,
    cast(month as integer) as month,
    dayflag,
    timezone,
    {{ day_type('dayflag') }} as day_type,
    {{ time_of_day('timezone') }} as time_of_day,
    cast(population as integer) as population,
    prefcode as prefecture_code,
    citycode as city_code,
    {{ local_government_code('citycode') }} as lg_code,
    {{ mesh_center_lng('mesh1kmid') }} as lng,
    {{ mesh_center_lat('mesh1kmid') }} as lat,
    -- 行を読んだ配布物の zip の名前
    'monthly_mdp_mesh1km_' || regexp_extract(filename, '([0-9]{2})\.parquet$', 1) || '.zip' as source_zip
from {{ ref('raw_mesh_population') }}
