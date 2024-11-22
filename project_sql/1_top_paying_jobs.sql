/* 
What are the top 10 paying data analyst jobs (remote only)?
- I am going to identify the top 10 highest-paying data analyst roles that are available remotely.
- Foces on job postings with specified salaries (removing nulls)
- Value : Offer insights for job hunting 
*/

SELECT
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE
FROM 
    job_postings_fact
LEFT JOIN
    company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND  -- or job_work_from_home = TRUEA
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
