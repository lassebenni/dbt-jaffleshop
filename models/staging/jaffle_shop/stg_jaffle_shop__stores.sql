with raw_source as (



    select *
    from {{ source('jaffle_shop', 'stores') }}

),

final as (

    select
        id,
        name,
        opened_at,
        tax_rate,
        ingestion_date

    from raw_source

)

select * from final
