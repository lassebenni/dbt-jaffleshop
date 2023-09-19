{% macro find_duplicates(cte, columns=[]) %}

,
dupes as (
    select {{ columns | join(", ") }}
    from {{ cte }}
    group by {{ columns | join(", ") }}
    having count(*) > 1
    limit 1
)

select {{ columns | join(", ") }}, *
from {{ cte }}
where ({{ columns | join(", ") }}) in (select {{ columns | join(", ") }} from dupes)

{% endmacro %}
