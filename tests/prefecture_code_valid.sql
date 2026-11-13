-- 付けた都道府県コードは 01〜47 のどれか
select prefecture_code
from {{ ref('vacant_house_bank_listings') }}
where prefecture_code not between '01' and '47'
