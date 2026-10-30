
  
    

    create or replace table `data-pipeline-poc-513121`.`base`.`base_candidate_education`
      
    
    

    
    OPTIONS()
    as (
      

with source_data as (
    select
        cast(candidate_id as string) as candidate_id,
        certifications
    from `data-pipeline-poc-513121`.`raw`.`raw_kaggle_talent_recruitment`
    where certifications is not null
)

select distinct
    candidate_id,
    lower(trim(certification_name)) as certification_name
from source_data
cross join unnest(split(certifications, ',')) as certification_name
where trim(certification_name) != ''
    );
  