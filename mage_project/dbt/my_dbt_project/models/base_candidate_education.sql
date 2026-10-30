{{ config(
    materialized='table'
) }}

with source_data as (
    select
        cast(candidate_id as string) as candidate_id,
        certifications
    from {{ source('raw', 'raw_kaggle_talent_recruitment') }}
    where certifications is not null
)

select distinct
    candidate_id,
    lower(trim(certification_name)) as certification_name
from source_data
cross join unnest(split(certifications, ',')) as certification_name
where trim(certification_name) != ''