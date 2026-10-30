

SELECT DISTINCT
    job_roles,
    job_description
FROM `data-pipeline-poc-513121`.`raw`.`raw_kaggle_recruitment_dataset` 
WHERE job_roles IS NOT NULL