/*  
    Question :  What skills are requires for top paying data Scientist jobs?
    => Used top 10 highest_paying Data Scientist jobs form the first query
    => AND the specific skill required for these jobs
    => IT provides a detailed look at which high-paying jobs demands certain skills,
       heiping job seekers understand which skills to develop that align with top salaries
*/

With top_paing_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
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
    )

SELECT 
    top_paing_jobs.*,
    skills_dim.skills 
    FROM top_paing_jobs
    INNER JOIN skills_job_dim ON top_paing_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;


/*
  //////////////////////////////////////  Data Insights   ///////////////////////////////////////////////
    1. High-Demand Core Skills
    =>  SQL is required across 100% of the top-paying roles (8 out of 8 postings).
    =>  Python is the dominant programming language, required in 87.5% of roles (7 out of 8 postings).
    =>  Tableau leads data visualization demands, present in 75% of listings (6 out of 8 postings), outperforming Power BI (25%).
    =>  R retains relevance in top-tier positions, requested in 50% of roles.

    2. Salary & Role Distribution
    =>  Highest-Paying Role: Associate Director - Data Insights at AT&T leads at $255,829.50.
    =>  Leadership & Principal Roles: Executive/Lead roles (Associate Director, 
    Principal Data Analyst, Director) command the upper salary bracket ($186k–$255k+).
    =>  High-Value Specialized Skills: Cloud/Big Data tools (Databricks, PySpark, Azure, AWS) 
    and developer tools (Git, GitLab, Jira) correlate with the highest-earning postings.
*/