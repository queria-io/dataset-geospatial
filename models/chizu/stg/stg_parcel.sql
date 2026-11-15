{# 筆に団体コードを付け、形を GEOMETRY にする。
   原典の形には自己交差するものが 0.3% ほどあるので st_makevalid を通す。 #}

select
    city_code,
    {{ local_government_code('city_code') }} as lg_code,
    city_name,
    oaza_code,
    chome_code,
    koaza_code,
    yobi_code,
    oaza,
    chome,
    koaza,
    yobi,
    chiban,
    crs,
    datum,
    accuracy,
    coord_type,
    undetermined_members,
    st_makevalid(st_geomfromwkb(geometry)) as geometry,
    lng,
    lat,
    map_name,
    file,
    fude_id
from {{ ref('raw_parcel') }}
