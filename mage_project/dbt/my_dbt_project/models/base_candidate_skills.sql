{{ config(
    materialized='table'
) }}

with source_data as (
    select
        cast(candidate_id as string) as candidate_id,
        technical_skills
    from {{ source('raw', 'raw_kaggle_talent_recruitment') }}
    where technical_skills is not null
)

select distinct
    candidate_id,
    lower(trim(skill_name)) as skill_name
from source_data
cross join unnest(split(technical_skills, ',')) as skill_name
where trim(skill_name) != ''