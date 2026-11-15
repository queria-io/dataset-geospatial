{# 1km メッシュの形と所属。1 行が 1 メッシュ。
   所属の都道府県・市区町村は 2020 年版の 1km メッシュ属性による（2019 年版とは那珂川市など 70 メッシュが違う） #}

select *
from {{ ref('stg_mesh_attribute_2020') }}
order by mesh_code
