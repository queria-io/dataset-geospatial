{# 市区町村単位発地別の滞在人口に型を付け、区分のコードを名前にする。並べ替えに使うので原典のコードも残す #}

select
    prefcode as prefecture_code,
    citycode as city_code,
    {{ local_government_code('citycode') }} as lg_code,
    make_date(cast(year as integer), cast(month as integer), 1) as date,
    cast(year as integer) as year,
    cast(month as integer) as month,
    dayflag,
    timezone,
    from_area,
    {{ day_type('dayflag') }} as day_type,
    {{ time_of_day('timezone') }} as time_of_day,
    case from_area
        when '0' then '同一市区町村'
        when '1' then '同一都道府県'
        when '2' then '同一地方'
        when '3' then '他の地方'
    end as origin,
    cast(population as integer) as population,
    -- 行を読んだ配布物の zip の名前
    'monthly_fromto_city_' || regexp_extract(filename, '([0-9]{2})\.parquet$', 1) || '.zip' as source_zip
from {{ ref('raw_city_population_by_origin') }}
