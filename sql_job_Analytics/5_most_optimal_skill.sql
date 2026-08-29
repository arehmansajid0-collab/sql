/*
    Question : What are the most optimal skills to learn (aka it's  in demand and highly paying)
    => Identify skills in demand and assioted with high average salaries for Data Scientics toles.
    => Concentrates on remote positions with spacifies salaries 
    =>  Targets skills that offer job security (high Demand) and financial benefits ( High salaries),
        offering strategic insights for career deveelopment in Data Science
*/

--     ///////////////////////////////////////////     SOLUTION QUERY 1 (USING QUERY 3 AND 4 )      ///////////////////////////////
With skill_demand AS(
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
        AND salary_year_avg IS NOT NULL
    GROUP BY
        sd.skill_id 
), avarage_salary AS (
    SELECT
        sd.skill_id,
        sd.skills,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    from 
        skills_job_dim AS sjd
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    INNER JOIN job_postings_fact jpf ON  sjd.job_id = jpf.job_id
    
    WHERE
        jpf.job_title_short = 'Data Scientist'
        AND salary_year_avg IS NOT NULL
   GROUP BY 
   sd.skill_id, 
   sd.skills
)

SELECT 
    skill_demand.skill_id,
    avarage_salary.skills,
    demand_count,
    avg_salary
FROM
    skill_demand
INNER join avarage_salary ON skill_demand.skill_id = avarage_salary.skill_id
WHERE
    demand_count > 10
ORDER BY    
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

-- /////////////////////////////////////         SOLUTION QUERY 2 (OPTIMAL QUERY)        ////////////////////////////////////////



SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id,
    skills_dim.skills
HAVING 
    COUNT(skills_job_dim.job_id) > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;



/*
Key Takeaways
    1.Python Rules Demand, But Specialization Pays More
    =>  Python is by far the most in-demand skill with 763 postings, 
        but it sits at the bottom of the top 25 list for average salary ($143,828).
    =>   Low-level or high-performance languages like C ($164,865) and Go ($164,691) 
        command the highest average salaries, despite lower demand.

    2.Machine Learning Frameworks Are Essential Core Skills
    =>    Deep learning and ML packages have massive demand combined with high pay: TensorFlow (126 jobs | $151,536), 
    =>   PyTorch (115 jobs | $152,603), NumPy (73 jobs | $149,089), and Scikit-learn (81 jobs | $148,964).
        PyTorch commands a slightly higher average salary than TensorFlow.

    3.Cloud Infrastructure & Data Engineering Boost Compensation
    =>    High salaries in GCP ($155,811), BigQuery ($157,142), Airflow ($157,414), 
        and Snowflake ($152,687) indicate that companies heavily value Data Scientists
        who can handle end-to-end data pipelines and cloud architectures.

    4.BI & Visualization Skills
    =>    Tableau leads in demand for visualization tools (219 postings | $146,970).
    =>    Looker and Qlik have smaller sample sizes/demand, but higher average salaries ($158k–$164k).
*/