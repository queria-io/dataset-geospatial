{# 船員労働統計調査 第二号調査（G空間情報センター links-naikoukaiungyou-2025 の 04_seninroudoutoukeityousa_2goutyousa.csv） #}

select
    "YEAR" as year,
    "AVERAGE_NON_OWNED_SHIPS" as average_non_owned_ships,
    "AVERAGE_GROSS_TONNAGE" as average_gross_tonnage,
    "AVERAGE_VOYAGE_DAYS" as average_voyage_days,
    "AVERAGE_TOTAL_CREWS" as average_total_crews,
    "AVERAGE_OPERATIONAL_CREWS" as average_operational_crews,
    "AVERAGE_MALE_RATIO_STAFFS" as average_male_ratio_staffs,
    "AVERAGE_MALE_RATIO_OPERATIONAL_CREWS" as average_male_ratio_operational_crews,
    "AVERAGE_FOREIGNER_RATIO_STAFFS" as average_foreigner_ratio_staffs,
    "AVERAGE_FOREIGNER_OPERATIONAL_CREWS" as average_foreigner_operational_crews,
    "AVERAGE_ANNUAL_SALARY_TOTAL_CREWS" as average_annual_salary_total_crews,
    "AVERAGE_ANNUAL_SALARY_OPERATIONAL_CREWS" as average_annual_salary_operational_crews
from read_csv('data/links/links-naikoukaiungyou-2025/04_seninroudoutoukeityousa_2goutyousa.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
