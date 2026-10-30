{{ config(
    materialized='table'
) }}

with source_data as (
    select * from {{ source('raw', 'raw_kaggle_talent_recruitment') }}
)

select
    cast(candidate_id as string)                  as candidate_id,
    lower(trim(career_level))                     as career_level,
    cast(experience_years as numeric)             as experience_years,
    lower(trim(current_role))                     as current_role,
    lower(trim(company_name))                     as company_name,
    lower(trim(industry))                         as industry,
    cast(current_salary_cny_k as numeric)         as current_salary_cny_k,
    cast(expected_salary_cny_k as numeric)        as expected_salary_cny_k,
    lower(trim(preferred_job_title))              as preferred_job_title,
    lower(trim(preferred_work_mode))              as preferred_work_mode
from source_data
where candidate_id is not null