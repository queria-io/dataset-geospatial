{# 都道府県・市区町村と地方区分。1 行が 1 市区町村。
   2020 年版のマスタに、2019 年のデータだけに出てくる旧那珂川町（40305、2018 年 10 月に市制施行して 40231）を 2019 年版から足す。
   篠山市（28221）は 2019 年 5 月に丹波篠山市へ改称しており、2020 年版の名前を使う #}

with master as (
    select * from {{ ref('stg_city_master_2020') }}
    union all by name
    select * from {{ ref('stg_city_master_2019') }}
    where city_code not in (select city_code from {{ ref('stg_city_master_2020') }})
)

select
    m.prefecture_code,
    m.prefecture,
    m.city_code,
    m.lg_code,
    m.city_name,
    m.address,
    r.region_code,
    r.region
from master as m
join {{ ref('stg_region_master_2020') }} as r using (prefecture_code)
order by city_code
