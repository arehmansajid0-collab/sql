/*
        Question : What are the top paying skills  based on salary?
    => Looked at the avarage salary associated with each skill for Data Science Positions
    => Focuses on roles with specified salaties , regaardless os location
    => IT reveals how different skills impact salary levels for Data Science 
        AND helps identify most  finacially rewarding skills to aquire or improve
*/


SELECT
    sd.skills,
    ROUND(AVG(salary_year_avg),2) AS avg_salary
from 
    skills_job_dim AS sjd
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
INNER JOIN job_postings_fact jpf ON  sjd.job_id = jpf.job_id
WHERE
    jpf.job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
ORDER BY
    avg_salary DESC
LIMIT 25


/*
    ////////////////////////////////////        Top Skill Domain Categories     ///////////////////////////////////////////////////
    1. Workflow & Project Operations ($175,144 Avg Salary)
        =>  Asana ($215,477.38) and Airtable ($201,142.86) lead the dataset, 
        indicating that senior/lead data professionals managing cross-functional workflows command top tier compensation.
        =>  Additional productivity tools (Slack, Notion, Zoom, Atlassian) average $151,000–$168,000, 
        highlighting the premium placed on operational leadership alongside technical execution.

    2. AI, Natural Language Processing & Specialized Frameworks ($167,139 Avg Salary)
        Enterprise AI platforms like IBM Watson ($187,417.14) and modern LLM repositories like Hugging Face ($160,867.72) 
        show strong earning potential for specialized machine learning developers.

    3. Niche & Functional Programming Languages ($166,134 Avg Salary)
        Languages like Elixir ($170,823.56), Lua ($170,500.00), Solidity ($166,979.90), 
        and Haskell ($157,500.00) command strong salaries due to developer scarcity in 
        specialized domains (e.g., high-concurrency systems, smart contracts, embedded scripts).

    4. Cloud, Data Engineering & Infrastructure ($162,318 Avg Salary)
        Expertise in enterprise platforms (Red Hat at $189,500), 
        orchestration (Airflow at $155,878), and specialized databases (DynamoDB, Neo4j, BigQuery) 
        forms a steady $150k–$190k salary baseline.
*/