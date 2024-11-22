/*
What are the most optimal skills ? ( high in demand and high paying)
- Identify skills in high demand and associated with high average salaries for Data analyst roles
- Concentrates on remote jobs with specified salaries
- values : targets skills that offer job security(high demand) and good financial benefits( high salaries),
    offering strategic insights for caree development in data analysis
*/

-- CTE METHOD
WITH skills_demand AS (

    SELECT 
        skills_dim.skill_id as skill_id,
        skills_dim.skills as skill,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact 
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY  
        skills_dim.skill_id
), average_salary AS (
    SELECT
        skills_job_dim.skill_id as skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skill,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC

LIMIT 25

/* if we order it by avg_salary and then demand count 
we can see higher salaries tha are above 120k 
but the demand count is very very low for these skills
( between 1 and 10) for the top 25

If we order it by demand_count and then average salary the salaries are between
81k and 115k but here the demand count is between (18 and 398) which is decent and might 
give us another perspective on the skills and their demand and therefore might
encourage job seekers to seek these skills that are decently paid but not the top paid 
due to their higher demand

Another alternative is to order by average salary and then demand count but put
a constraint of demand count being higher than 10.
that gave me better results of salaries between 97k and 115k and jobs with demand count
between 11 and 236 which can be a more balanced compromise between the highest paid skills
and the most in-demand skills
*/

-- more concise solution
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact 
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY  
    skills_dim.skill_id
HAVING
    -- demand count (putting the aggregation itself in the having clause can't be done
    -- and therefore we have rewrite the demand_count aggregation again here )
    COUNT(skills_job_dim.job_id) > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;