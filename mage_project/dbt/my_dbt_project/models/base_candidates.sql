{{ config(
    materialized='table'
) }}

with source_data as (
    select * from {{ source('raw', 'raw_kaggle_talent_recruitment') }}
)

select
    cast(candidate_id as string) as candidate_id,
    lower(trim(gender))          as gender,
    cast(age as int64)           as age,
    lower(trim(location))        as location
from source_data
where candidate_id is not null