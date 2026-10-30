

with source_data as (
    select * from `data-pipeline-poc-513121`.`raw`.`raw_kaggle_talent_recruitment`
)

select
    cast(candidate_id as string)                                as candidate_id,
    cast(communication_score as numeric)                        as communication_score,
    cast(leadership_score as numeric)                           as leadership_score,
    cast(problem_solving_score as numeric)                      as problem_solving_score,
    cast(resume_score as numeric)                               as resume_score,
    cast(recruiter_rating as numeric)                           as recruiter_rating,
    cast(cast(job_applications_count as float64) as int64)      as job_applications_count,
    cast(cast(interview_attempts as float64) as int64)          as interview_attempts,
    lower(trim(target_category))                                as target_category
from source_data
where candidate_id is not null