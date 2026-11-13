{# 自動車輸送統計調査（発地・着地の都道府県の組）（G空間情報センター links-modalshift-2024 の 02_jidousyayusoutoukeichousa.csv） #}

select
    "都道府県コード_発地" as prefecture_code_origin,
    "都道府県名_発地" as prefecture_name_origin,
    "都道府県コード_着地" as prefecture_code_destination,
    "都道府県名_着地" as prefecture_name_destination,
    "調査年" as survey_year,
    "サンプル数" as sample_size,
    "平均_最大積載量" as average_maximum_load_capacity_kg,
    "用途別_台数_特定荷主専属" as purpose_vehicle_count_dedicated_to_specific_shipper,
    "用途別_台数_積合せ貨物" as purpose_vehicle_count_mixed_cargo,
    "用途別_台数_一般貨物" as purpose_vehicle_count_general_cargo,
    "用途別_台数_集配" as purpose_vehicle_count_collection_and_delivery,
    "用途別_台数_その他" as purpose_vehicle_count_other,
    "平均_休車日数" as average_non_operating_days,
    "平均_調査期間中の走行距離" as average_distance_traveled_during_survey_period,
    "平均_輸送回数" as average_transport_frequency,
    "平均_輸送当たり重量" as average_weight_per_transport,
    "平均_輸送当たり積載率" as average_load_rate_per_transport,
    "発地_都道府県_緯度" as origin_prefecture_latitude,
    "発地_都道府県_経度" as origin_prefecture_longitude,
    "着地_都道府県_緯度" as destination_prefecture_latitude,
    "着地_都道府県_経度" as destination_prefecture_longitude,
    {{ prefecture_code('"都道府県名_発地"') }} as origin_prefecture_code,
    {{ prefecture_code('"都道府県名_着地"') }} as destination_prefecture_code
from read_csv('data/links/links-modalshift-2024/02_jidousyayusoutoukeichousa.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
