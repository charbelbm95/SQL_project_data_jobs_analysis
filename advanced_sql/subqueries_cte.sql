-- SUBQUERY
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs

-- CTE
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT *
FROM january_jobs

-- list of companies that are offering jobs that dont have any requirements for degree

-- usual method
SELECT DISTINCT(company_id),
       job_no_degree_mention
FROM job_postings_fact jpf
WHERE jpf.job_no_degree_mention = False

-- SUBQUERY method
SELECT name 
FROM company_dim
WHERE company_id IN (
    SELECT company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention = False
)

/*
Find the companies that have the most job openings.
- get the total number of job postings per company id
- return the total number of jobs with the company name
*/

-- Usual method
select 
    cd.name,
    count(jpf.job_id) as total_jobs
from 
    job_postings_fact jpf
left join company_dim cd on jpf.company_id = cd.company_id
group by 
    cd.name
order by 
    total_jobs desc

-- CTE
WITH company_jobs_count AS (
    
SELECT
    company_id,
    COUNT(job_id) AS total_jobs
FROM job_postings_fact
GROUP BY company_id
)
SELECT 
    cd.name,
    cjc.total_jobs
FROM company_dim cd
LEFT JOIN company_jobs_count cjc ON cd.company_id = cjc.company_id
ORDER BY total_jobs DESC


-- Practice Problem 1
/*Identify the top 5 skills that are most frequently mentioned in job postings. 
Use a subquery to find the skill IDs with the highest counts in the skills_job_dim 
table and then join this result with the skills_dim table to get the skill names.
*/

WITH top_5_skills AS (
SELECT
    sjd.skill_id,
    COUNT(jpf.job_id) AS job_count
FROM job_postings_fact jpf
LEFT JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
GROUP BY
    sjd.skill_id
LIMIT 5 )
SELECT
    sd.skills,
    top_5_skills.job_count
FROM top_5_skills
LEFT JOIN skills_dim sd ON top_5_skills.skill_id = sd.skill_id
ORDER BY job_count DESC

/* Practice problem 2
Determine the size category ('Small', 'Medium', or 'Large') for each company 
by first identifying the number of job postings they have.
 Use a subquery to calculate the total job postings per company. 
 A company is considered 'Small' if it has less than 10 job postings, 
 'Medium' if the number of job postings is between 10 and 50, and 
 'Large' if it has more than 50 job postings. 
 Implement a subquery to aggregate job counts per company before classifying them based on size.
*/

WITH top_jobs_per_company AS (
    
    SELECT 
        COUNT(jpf.job_id) AS job_count_per_company,
        jpf.company_id
    FROM
        job_postings_fact jpf
    GROUP BY
        jpf.company_id
    )

SELECT
    job_count_per_company,
    cd.name,
    CASE
        WHEN job_count_per_company < 10 THEN 'Small'
        WHEN job_count_per_company BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size_category
FROM top_jobs_per_company
LEFT JOIN company_dim cd ON top_jobs_per_company.company_id = cd.company_id

-- Practice problem 7
/*
Find the count of number of remote job postings per skill
 - Display the top 5 skills by their demand in remote jobs
 - Include Skill_id, name, and count of postings requiring the skill
*/

-- my solution
WITH remote_jobs_per_skill AS (
    SELECT
        sjd.skill_id,
        sd.skills ,
        COUNT(jpf.job_id) AS job_count
    FROM job_postings_fact jpf
    LEFT JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    LEFT JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE jpf.job_location = 'Anywhere'
    GROUP BY
        sjd.skill_id,
        sd.skills
    )
SELECT
    skill_id,
    skills,
    job_count
FROM remote_jobs_per_skill
ORDER BY job_count DESC
LIMIT 5

-- his solution
WITH remote_job_skills AS (
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE 
        job_postings.job_work_from_home = TRUE
    GROUP BY
        skill_id
    )

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM 
    remote_job_skills 
INNER JOIN skills_dim AS skills ON remote_job_skills.skill_id = skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5