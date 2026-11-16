select
    prefcode as prefecture_code,
    prefname as prefecture,
    citycode as city_code,
    {{ local_government_code('citycode') }} as lg_code,
    cityname as city_name,
    address
from {{ ref('raw_city_master_2020') }}
