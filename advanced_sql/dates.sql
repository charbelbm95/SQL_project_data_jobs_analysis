CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

-- April
CREATE TABLE april_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 4;

-- May
CREATE TABLE may_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 5;

-- June
CREATE TABLE june_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 6;

-- July
CREATE TABLE july_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 7;

-- August
CREATE TABLE august_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 8;

-- September
CREATE TABLE september_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 9;

-- October
CREATE TABLE october_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 10;

-- November
CREATE TABLE november_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 11;

-- December
CREATE TABLE december_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 12;
