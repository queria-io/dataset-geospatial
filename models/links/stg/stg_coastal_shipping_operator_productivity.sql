{# 内航船舶輸送統計調査による事業者別の生産性（G空間情報センター links-naikoukaiungyou-2024 の 02_naikoukaiungyou_naikousenpakuyusoutoukei.csv） #}

select
    "Business_Management_ID" as business_management_id,
    "GROSS_TONNAGE_SCORE(OPERATOR)" as gross_tonnage_score_operator,
    "LOADING_RATE_SCORE(OPERATOR)" as loading_rate_score_operator,
    "TRANSPORTATION_AMOUNT_PER_CREW(OPERATOR)" as transportation_amount_per_crew_operator,
    "PRODUCTIVITY
GROUP(OPERATOR)" as productivity_group_operator,
    filename as source_path
from {{ ref('raw_coastal_shipping_operator_productivity') }}
