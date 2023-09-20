with raw_source as (



    select *
    from {{ source('jaffle_shop', 'customers') }}

),

final as (

    select
        id,
        name,
        ingestion_date

    from raw_source

)

select * from final
