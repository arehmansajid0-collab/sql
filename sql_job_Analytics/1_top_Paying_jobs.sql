/*  Question :  What are the top paying jobs for my role?
 => Identify the top-paying Data Analyst roles that are available remotely.
 => Focuses on job postings with specified salaries (Removed NULLS)
 => BONUS: Include company name of top 10 roles
 => HIghlight the top-paying oppourtunities for Data Analyst, offering insights into employment
*/

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact jpf
LEFT JOIN company_dim ad ON jpf.company_id =  ad.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10 

/*
    /////////////////////////////////////////     Analytical Insights     ///////////////////////////////////////////////////
    =>  Essential Core Stack: SQL is required in 100% of the job postings, 
    followed closely by Python (87.5%) and Tableau (75.0%). These three form the foundational requirements for top-tier roles.

    =>  Highest-Paying Skill Clusters: Cloud platforms like AWS and Azure, 
    alongside Power BI, are tied to the highest average salary band (~$222,569/yr).

    =>  Big Data Drivers: High-earning roles like Associate - Data Insights at AT&T ($255,829.50) 
    explicitly call for enterprise big-data tools like PySpark, Databricks, and Jupyter.
*/