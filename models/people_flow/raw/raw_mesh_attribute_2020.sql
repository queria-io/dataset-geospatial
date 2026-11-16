{# 1km メッシュ属性（2020 年版）。pipelines/people_flow.py が書いた data/people_flow/attribute_mesh1km_2020.csv をそのまま読む。 #}

select * from read_csv('data/people_flow/attribute_mesh1km_2020.csv', all_varchar = true)
