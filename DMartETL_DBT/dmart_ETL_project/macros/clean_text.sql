{% macro clean_text(column_name) -%}
    nullif(trim(to_varchar({{ column_name }})), '')
{%- endmacro %}
