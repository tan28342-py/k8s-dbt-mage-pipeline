

SELECT DISTINCT
    job_applicant_name,
    resume
FROM `data-pipeline-poc-513121`.`raw`.`raw_kaggle_recruitment_dataset` 
WHERE job_applicant_name IS NOT NULL