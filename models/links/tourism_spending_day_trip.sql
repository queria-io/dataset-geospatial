{# 旅行・観光消費動向調査（日帰り旅行）（G空間情報センター links_kankoutoukei_2025 の 03_ryokoukankousyouhidoukou_higaeri.csv） #}

select
    "YEAR" as year,
    lpad(cast("PREFECTURE_CODE" as varchar), 2, '0') as prefecture_code,
    "POPULATION_SUM_DAY_TRIP_TOTAL_SPENDING_COST" as population_sum_day_trip_total_spending_cost,
    "POPULATION_SUM_DAY_TRIP_PACKAGE_TOUR_COST" as population_sum_day_trip_package_tour_cost,
    "POPULATION_SUM_DAY_TRIP_ACCOMMODATION_COST" as population_sum_day_trip_accommodation_cost,
    "POPULATION_SUM_DAY_TRIP_FOOD_COST" as population_sum_day_trip_food_cost,
    "POPULATION_SUM_DAY_TRIP_TRANSPORTATION_COST" as population_sum_day_trip_transportation_cost,
    "POPULATION_SUM_DAY_TRIP_ENTERTAINMENT_COST" as population_sum_day_trip_entertainment_cost,
    "POPULATION_SUM_DAY_TRIP_SHOPPING_COST" as population_sum_day_trip_shopping_cost,
    "POPULATION_SUM_DAY_TRIP_OTHER_COST" as population_sum_day_trip_other_cost,
    "AVG_DAY_TRIP_TOTAL_SPENDING_COST_PER_PERSON" as avg_day_trip_total_spending_cost_per_person,
    "AVG_DAY_TRIP_PACKAGE_TOUR_COST_PER_PERSON" as avg_day_trip_package_tour_cost_per_person,
    "AVG_DAY_TRIP_ACCOMMODATION_COST_PER_PERSON" as avg_day_trip_accommodation_cost_per_person,
    "AVG_DAY_TRIP_FOOD_COST_PER_PERSON" as avg_day_trip_food_cost_per_person,
    "AVG_DAY_TRIP_TRANSPORTATION_COST_PER_PERSON" as avg_day_trip_transportation_cost_per_person,
    "AVG_DAY_TRIP_ENTERTAINMENT_COST_PER_PERSON" as avg_day_trip_entertainment_cost_per_person,
    "AVG_DAY_TRIP_SHOPPING_COST_PER_PERSON" as avg_day_trip_shopping_cost_per_person,
    "AVG_DAY_TRIP_OTHER_COST_PER_PERSON" as avg_day_trip_other_cost_per_person
from read_csv('data/links/links_kankoutoukei_2025/03_ryokoukankousyouhidoukou_higaeri.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
