-- get jobs and companies from January
-- UNION KEYWORd
SELECT
    job_title_short,
    company_id,
    job_location
FROM 
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM 
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM 
    march_jobs
--UNION ALL

-- Practice Problem 8
/*
Finc the job postings from the first quarter that have a salary greater than 70 k
- Combine job postings from the 1st quarter of 2023(Jan-Mar)
- Get jobs job postings with an average yearly salary > 70000
*/
SELECT
    quarter_1_job_postings.job_title_short,
    quarter_1_job_postings.job_location,
    quarter_1_job_postings.job_via,
    quarter_1_job_postings.job_posted_date::DATE,
    quarter_1_job_postings.salary_year_avg
FROM(
    SELECT *
    FROM 
        january_jobs

    UNION ALL

    SELECT *
    FROM 
        february_jobs

    UNION ALL

    SELECT *
    FROM 
        march_jobs
) AS quarter_1_job_postings

WHERE
    quarter_1_job_postings.salary_year_avg > 70000 AND
    quarter_1_job_postings.job_title_short = 'Data Scientist'

ORDER BY
    quarter_1_job_postings.salary_year_avg DESC