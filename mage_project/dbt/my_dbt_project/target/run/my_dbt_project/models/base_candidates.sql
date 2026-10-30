
  
    

    create or replace table `data-pipeline-poc-513121`.`base`.`base_candidates`
      
    
    

    
    OPTIONS()
    as (
      

with source_data as (
    select * from `data-pipeline-poc-513121`.`raw`.`raw_kaggle_talent_recruitment`
)

select
    cast(candidate_id as string) as candidate_id,
    lower(trim(gender))          as gender,
    cast(age as int64)           as age,
    lower(trim(location))        as location
from source_data
where candidate_id is not null
    );
  