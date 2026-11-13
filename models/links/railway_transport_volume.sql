{# 鉄道統計年報 運輸成績表（数量）（G空間情報センター links-tetsudoujigyou-2025 の 01_tetsudou_unyuseiseki1.csv） #}

select
    "YEAR" as year,
    "CORPORATION_NAME" as corporation_name,
    "JURISDICTION" as jurisdiction,
    "CATEGORY" as category,
    "TRANSPORTED_NUMBER_COMMUTER_PASS_WORKING" as transported_number_commuter_pass_working,
    "TRANSPORTED_NUMBER_COMMUTER_PASS_STUDENT" as transported_number_commuter_pass_student,
    "TRANSPORTED_NUMBER_COMMUTER_PASS_TOTAL" as transported_number_commuter_pass_total,
    "TRANSPORTED_NUMBER_COMMUTER_PASS_RATIO" as transported_number_commuter_pass_ratio,
    "TRANSPORTED_NUMBER_NON_COMMUTER_PASS" as transported_number_non_commuter_pass,
    "TRANSPORTED_NUMBER_NON_COMMUTER_PASS_RATIO" as transported_number_non_commuter_pass_ratio,
    "TRANSPORTED_NUMBER_TOTAL" as transported_number_total,
    "NUMBER_OF_CARRY_ON_BAGGAGE" as number_of_carry_on_baggage,
    "TRANSPORTED_TONNAGE_CONTAINER" as transported_tonnage_container,
    "TRANSPORTED_TONNAGE_CARLOAD_SERVICE" as transported_tonnage_carload_service,
    "TRANSPORTED_TONNAGE_TOTAL" as transported_tonnage_total
from read_csv('data/links/links-tetsudoujigyou-2025/01_tetsudou_unyuseiseki1.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
