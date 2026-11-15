select s.* exclude (source_path), f.sha256 as source_sha256
from {{ ref('stg_tourism_spending_day_trip') }} as s
left join {{ ref('stg_source_file') }} as f on list_contains(f.paths, s.source_path)
