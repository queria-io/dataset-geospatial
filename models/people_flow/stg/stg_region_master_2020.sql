select
    prefcode as prefecture_code,
    regioncode as region_code,
    regionname as region
from {{ ref('raw_region_master_2020') }}
