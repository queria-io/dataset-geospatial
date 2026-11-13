{# 列名を小文字のスネークケースにする（tools/generate_models.py の snake と同じ規則） #}

{% macro snake_case(text) -%}
trim(regexp_replace(regexp_replace(regexp_replace(lower(ltrim({{ text }}, chr(65279))), '^([0-9]+)(st|nd|rd|th)_floor', 'floor\1'), '[^a-z0-9]+', '_', 'g'), '_+', '_', 'g'), '_')
{%- endmacro %}
