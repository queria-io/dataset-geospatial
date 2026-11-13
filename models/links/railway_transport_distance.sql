{# 鉄道統計年報 運輸成績表（延日キロ等）（G空間情報センター links-tetsudoujigyou-2025 の 02_tetsudou_unyuseiseki2.csv） #}

select
    "YEAR" as year,
    "CORPORATION_NAME" as corporation_name,
    "JURISDICTION" as jurisdiction,
    "CATEGORY" as category,
    "TOTAL_DAY_KILOMETER_PASSENGER" as total_day_kilometer_passenger,
    "TOTAL_DAY_KILOMETER_CARGO" as total_day_kilometer_cargo,
    "PASSENGER_KILOMETER_COMMUTER_PASS_WORKING" as passenger_kilometer_commuter_pass_working,
    "PASSENGER_KILOMETER_COMMUTER_PASS_STUDENT" as passenger_kilometer_commuter_pass_student,
    "PASSENGER_KILOMETER_NON_COMMUTER_PASS" as passenger_kilometer_non_commuter_pass,
    "PASSENGER_KILOMETER_TOTAL" as passenger_kilometer_total,
    "TRANSPORTED_TONNAGE_KILOMETER_CONTAINER" as transported_tonnage_kilometer_container,
    "TRANSPORTED_TONNAGE_KILOMETER_CARLOAD_SERVICE" as transported_tonnage_kilometer_carload_service,
    "TRANSPORTED_TONNAGE_KILOMETER_TOTAL" as transported_tonnage_kilometer_total,
    "AVERAGE_PASSAGE_AMOUNT_PASSENGER" as average_passage_amount_passenger,
    "AVERAGE_PASSAGE_AMOUNT_CARGO" as average_passage_amount_cargo,
    "AVERAGE_TRANSPORTED_KILOMETER_PASSENGER" as average_transported_kilometer_passenger,
    "AVERAGE_TRANSPORTED_KILOMETER_CARGO" as average_transported_kilometer_cargo
from read_csv('data/links/links-tetsudoujigyou-2025/02_tetsudou_unyuseiseki2.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
