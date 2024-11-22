/*
What are the most in-demand skills for data analysis ?
- i will join job_postings_fact with skills_job_dim
- identify the 5 top in-demand skills for a data analyst
- focus on all job postings
value: Retrieve the top 5 skills with the highest demand in the market,
providing insights into the most valuable skills for job_seekers
*/

SELECT 
    skills_dim.skills as skill,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact 
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY  
    skill
ORDER BY 
    demand_count DESC
LIMIT 10
