{# 無人航空機の事故等報告（G空間情報センター links-mujinkoukuukihikoukeikaku-2025_ の 02_jikojyouhou.csv） #}

select
    "No." as no,
    "OCCURRENCE_DATE" as occurrence_date,
    "OCCURRENCE_LOCATION" as occurrence_location,
    "OPERATOR" as operator,
    "MODEL_OR_MANUFACTURER" as model_or_manufacturer,
    "DEPARTURE_LOCATION_ARRIVAL_DESTINATION" as departure_location_arrival_destination,
    "INCIDENT_SUMMARY" as incident_summary,
    "CASUALTIES_SUMMARY" as casualties_summary,
    "AIRCRAFT_DAMAGE_SUMMARY" as aircraft_damage_summary,
    "RECURRENCE_PREVENTION_MEASURES" as recurrence_prevention_measures,
    "REMARKS" as remarks,
    {{ prefecture_code('"OCCURRENCE_LOCATION"') }} as prefecture_code
from read_csv('data/links/links-mujinkoukuukihikoukeikaku-2025_/02_jikojyouhou.csv', header = true, delim = ',', quote = '"', escape = '"', nullstr = ['', 'None', 'nan', 'NaN'], sample_size = -1)
