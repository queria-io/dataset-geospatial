{# 期末倉庫使用状況報告書（全国、2019〜2024年度）（G空間情報センター links-soukogyou-2025 の 01_kimatsusoukoshiyoujyoukyouhoukokusyo.csv） #}

select
    "BUSINESS_OPERATOR_ID" as business_operator_id,
    "OFFICE_ID" as office_id,
    "OFFICE_ADDRESS" as office_address,
    "YEARLY_TERM_YEAR" as yearly_term_year,
    "YEARLY_TERM_QUARTER" as yearly_term_quarter,
    "ITEM_NAME" as item_name,
    "ENDING_BALANCE_PREVIOUS_TERM_QUANTITY" as ending_balance_previous_term_quantity,
    "RECEIPTS_DURING_TERM_QUANTITY" as receipts_during_term_quantity,
    "SHIPMENTS_DURING_TERM_QUANTITY" as shipments_during_term_quantity,
    "ENDING_BALANCE_CURRENT_TERM_QUANTITY" as ending_balance_current_term_quantity,
    "ENDING_BALANCE_CURRENT_TERM_AMOUNT" as ending_balance_current_term_amount,
    {{ prefecture_code('"OFFICE_ADDRESS"') }} as prefecture_code
from read_csv('data/links/links-soukogyou-2025/01_kimatsusoukoshiyoujyoukyouhoukokusyo.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
