/*
Label new column as follows:
- 'anywhere' as remote
- 'newyork , NY' as Local
- otherwise, 'Onsite'
*/

select *,
    CASE
        WHEN salary_year_avg BETWEEN 0 AND 30000 THEN 'LOW SALARY'
        WHEN salary_year_avg BETWEEN 30000 AND 80000 THEN 'MEDIUM SALARY'
        ELSE 'HIGH SALARY'
    END AS salary_category
from 
    job_postings_fact
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg >= 0
ORDER BY salary_year_avg DESC

    