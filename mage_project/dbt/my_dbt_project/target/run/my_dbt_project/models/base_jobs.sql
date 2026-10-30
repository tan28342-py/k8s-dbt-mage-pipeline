
  
    

    create or replace table `data-pipeline-poc-513121`.`base`.`base_jobs`
      
    
    

    
    OPTIONS()
    as (
      

SELECT DISTINCT
    job_roles,
    job_description
FROM `data-pipeline-poc-513121`.`raw`.`raw_kaggle_recruitment_dataset` 
WHERE job_roles IS NOT NULL
    );
  