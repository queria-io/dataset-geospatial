-- 1 都道府県の 1 年は 1 行
select prefecture_code, year, count(*) as n
from {{ ref('tourism_accommodation_guests') }}
group by all
having n > 1
