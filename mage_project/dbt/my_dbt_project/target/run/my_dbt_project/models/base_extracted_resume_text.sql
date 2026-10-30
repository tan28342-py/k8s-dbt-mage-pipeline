
  
    

    create or replace table `data-pipeline-poc-513121`.`base`.`base_extracted_resume_text`
      
    
    

    
    OPTIONS()
    as (
      

SELECT DISTINCT
    job_applicant_name,
    resume
FROM `data-pipeline-poc-513121`.`raw`.`raw_kaggle_recruitment_dataset` 
WHERE job_applicant_name IS NOT NULL
    );
  