with raw_source as (

{% set subschema = relation.schema | replace(env_vars['DATACOVES_USER_SCHEMA'], '') %}

    select *
    from {% raw %}{{{% endraw %} source('{{ subschema }}', '{{ relation.name }}') {% raw %}}}{% endraw %}

),

final as (

    select
{%- for key, cols in nested.items() %}
  {%- for col in cols %}
        {{ cols[col]["id"] }}{% if not loop.last or columns %},{% endif %}
  {%- endfor %}
{%- endfor %}
{%- for col in columns %}
        {{ col['id'] }}{% if not loop.last %},{% endif %}
{%- endfor %}

    from raw_source

)

select * from final
