{# 船員労働統計調査 第一号調査（G空間情報センター links-naikoukaiungyou-2025 の 03_seninroudoutoukeityousa_1goutyousa.csv） #}

select
    "YEAR" as year,
    "NUM_OWNED_SHIPS" as num_owned_ships,
    "NUM_OFFICERS" as num_officers,
    "NUM_RATINGS" as num_ratings,
    "AVG_GROSS_TONNAGE" as avg_gross_tonnage,
    "AVG_OPERATING_DAYS" as avg_operating_days,
    "OFFICER_AVG_AGE" as officer_avg_age,
    "RATING_AVG_AGE" as rating_avg_age,
    "OFFICER_AVG_EXPERIENCE" as officer_avg_experience,
    "RATING_AVG_EXPERIENCE" as rating_avg_experience,
    "OFFICER_MALE_RATIO" as officer_male_ratio,
    "RATING_MALE_RATIO" as rating_male_ratio,
    "OFFICER_FOREIGNER_RATIO" as officer_foreigner_ratio,
    "RATING_FOREIGNER_RATIO" as rating_foreigner_ratio,
    "OFFICER_AVG_ANNUAL_WORKING_HOURS" as officer_avg_annual_working_hours,
    "RATING_AVG_ANNUAL_WORKING_HOURS" as rating_avg_annual_working_hours,
    "OFFICER_AVG_ANNUAL_INCOME" as officer_avg_annual_income,
    "RATING_AVG_ANNUAL_INCOME" as rating_avg_annual_income
from read_csv('data/links/links-naikoukaiungyou-2025/03_seninroudoutoukeityousa_1goutyousa.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
