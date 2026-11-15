{# zip の一覧に団体コードを付ける。 #}

select
    file,
    city_code,
    {{ local_government_code('city_code') }} as lg_code,
    registry_code,
    year,
    title,
    page_url,
    zip_url,
    size
from {{ ref('raw_source') }}
