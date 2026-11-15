select s.* exclude (source_path), f.sha256 as source_sha256
from {{ ref('stg_motor_carrier_accident_reports') }} as s
left join {{ ref('stg_source_file') }} as f on list_contains(f.paths, s.source_path)
