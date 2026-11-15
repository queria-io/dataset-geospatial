{# 地方区分マスタ（2020 年版）。pipelines/people_flow.py が書いた data/people_flow/regioncode_master_2020.csv をそのまま読む。 #}

select * from read_csv('data/people_flow/regioncode_master_2020.csv', all_varchar = true)
