{% macro find_duplicates(cte, columns=[]) %}

, dupes AS (
    SELECT
        {{ columns|join(', ') }}
    FROM {{ cte }}
    GROUP BY 
        {{ columns|join(', ') }}
    HAVING COUNT(*) > 1
    LIMIT 1
)

SELECT
    {{ columns|join(', ') }}, *
FROM {{ cte }}
WHERE CONCAT({{ columns|join(', ') }}) IN (SELECT CONCAT({{ columns|join(', ') }}) FROM dupes)

{% endmacro %}
