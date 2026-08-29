/*
        Question : What are the most in demand skills for Data Scientist?
    => Join job postings to inner join table similar to query 2
    => Identify the top 5 in-demand skills for a Data Scientist
    => Focus on all job postigs 
    => Retrieves the top 5 skills with the highest demand in job marcket ,
       providing insights into the most valuable skills for job seekers
*/

SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sjd.job_id) AS demand_count
from 
    skills_job_dim AS sjd
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
INNER JOIN job_postings_fact jpf ON  sjd.job_id = jpf.job_id
WHERE
    jpf.job_title_short = 'Data Scientist'
GROUP BY
    sd.skill_id 
ORDER BY
    demand_count DESC
LIMIT 5

/*
    ////////////////////////////////////////////        Industry Insights       /////////////////////////////////////////////////

        =>  Python is the Uncontested Foundation: Python leads with 114,016 job mentions (36.9% of top-5 demand). 
        It appears 44.0% more frequently than SQL and nearly double (1.91x) as often as R, 
        solidifying its place as the primary language for data manipulation, machine learning, and automation.

        =>  Programming Languages Dominate (81.9%): Core data manipulation tools (Python, SQL, R) 
        collectively represent 252,944 job postings. Employers prioritize foundational programming 
        and relational database querying over reporting tools and infrastructure management.

        =>  SQL Remains Essential: Ranking second with 79,174 mentions (25.6% share), 
        SQL is required alongside programming skills to extract and structure production data.

        =>  R Retains Statistical Significance: R holds 59,754 mentions (19.4% share), 
        showing that while Python leads for engineering and general data science, 
        R remains heavily sought after for statistical modeling and academic research.

        =>  Specialized Application & Cloud Infrastructure (18.1%): Visual reporting (Tableau at 29,513) 
        and cloud computing (AWS at 26,311) represent the remaining fifth of demand, 
        signaling that dashboarding and cloud deployment serve as valuable secondary skill layers once primary coding competencies are met.
*/
