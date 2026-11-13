{# 事務所別車種別配置車両数一覧（レンタカー）（G空間情報センター links-rentacars-2025 の 02_yousiki2_haisyasyaryousuu.csv） #}

select
    "OFFICE_VEHICLE_ALLOCATION_LIST_OFFICE_ID" as office_vehicle_allocation_list_office_id,
    "OFFICE_VEHICLE_ALLOCATION_LIST_TRANSPORT_BRANCH" as office_vehicle_allocation_list_transport_branch,
    "OFFICE_VEHICLE_ALLOCATION_LIST_LOCATION" as office_vehicle_allocation_list_location,
    "OWNED_VEHICLES_PASSENGER" as owned_vehicles_passenger,
    "OWNED_VEHICLES_BUS" as owned_vehicles_bus,
    "OWNED_VEHICLES_TRUCK" as owned_vehicles_truck,
    "OWNED_VEHICLES_SPECIAL_PURPOSE" as owned_vehicles_special_purpose,
    "OWNED_VEHICLES_MOTORCYCLE" as owned_vehicles_motorcycle,
    "OWNED_VEHICLES_TOTAL" as owned_vehicles_total,
    "NUMBER_OF_OFFICES_TOTAL" as number_of_offices_total,
    "TOTAL_PASSENGER" as total_passenger,
    "TOTAL_BUS" as total_bus,
    "TOTAL_TRUCK" as total_truck,
    "TOTAL_SPECIAL_PURPOSE" as total_special_purpose,
    "TOTAL_MOTORCYCLE" as total_motorcycle,
    "TOTAL_SUM" as total_sum,
    {{ prefecture_code('"OFFICE_VEHICLE_ALLOCATION_LIST_LOCATION"') }} as prefecture_code
from read_csv('data/links/links-rentacars-2025/02_yousiki2_haisyasyaryousuu.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
