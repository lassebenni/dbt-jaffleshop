with raw_source as (



    select *
    from {{ source('jaffle_shop', 'supplies') }}

),

final as (

    select
        id,
        name,
        cost,
        perishable,
        sku,
        ingestion_date

    from raw_source

)

select * from final
