
 # QUERIES FOR ANALYSIS
 
 -- 1.what is the race/ethinicity breakdown of employees in the company!
 SELECT race,COUNT(*) AS emp_count FROM hr 
  WHERE age>=18 AND termdate IS NULL
   GROUP BY race
   ORDER BY count(*) DESC;
   
   -- 2.what is the gender breakdown of employees in the company!
  SELECT gender,COUNT(*) AS emp_count FROM hr 
  WHERE age>=18 AND termdate IS NULL
   GROUP BY gender;
   
   -- 3.what is the age distribution of employees in the company!
 SELECT
       CASE
        WHEN age>=18 AND age<=24 THEN '18-24'
        WHEN age>=25 AND age<=34 THEN '25-34'
        WHEN age>=35 AND age<=44 THEN '35-44'
        WHEN age>=45 AND age<=54 THEN '45-54'
        WHEN age>=55 AND age<=64 THEN '55-64'
        ELSE '65+'
      END AS age_group,gender,
      COUNT(*) AS count
    FROM hr 
     WHERE age>=18 AND termdate IS NULL
     GROUP BY age_group,gender
     ORDER BY age_group;
     
     
-- 4.how many employees work at headquarters versus remote locations!
SELECT location,COUNT(*) AS count
FROM hr
 WHERE age>=18 AND termdate IS NULL
 GROUP BY location;
 
 -- 5. what is the avg length of employment for employees who has been terminated !
 SELECT
 round(avg(datediff(termdate,hire_date))/365,0) AS avg_len_employment
FROM hr
 WHERE termdate <= curdate() AND termdate IS NOT NULL AND age>=18; 
 
 -- 6.what is the total length of employment for employees by each employee who has been terminated !
  SELECT emp_id,
 round(SUM(datediff(termdate,hire_date)),0) AS total_len_employment_days
FROM hr
 WHERE termdate <= curdate() AND termdate IS NOT NULL AND age>=18
 GROUP BY emp_id;
 
 -- 7.what is the distribution of job titles across the company!
 SELECT jobtitle,
 COUNT(*) AS count FROM hr 
 WHERE age>=18 AND termdate IS NULL
 GROUP BY jobtitle
 order by jobtitle DESC;
 
 -- 8.which department has the highest turnover rate!
 SELECT department,total_employees,terminated_employees,
        terminated_employees/total_employees*100 AS turnover_rate
  FROM(
     SELECT
     department,
     COUNT(*) AS total_employees,
	 SUM(CASE
			WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_employees
     FROM hr 
     WHERE age>=18 
     GROUP BY department) AS dp
     ORDER BY turnover_rate DESC;
     
  -- 9.distribution of employees across location_state   
  SELECT location_state AS state,COUNT(*) AS count  
  FROM hr
  WHERE age>=18 AND termdate IS NULL
  GROUP BY state
  ORDER BY count;
  
  -- 10.how does the gender distribution across departments!
  SELECT department,gender,COUNT(*) AS count  
  FROM hr
  WHERE age>=18 AND termdate IS NULL
  GROUP BY department,gender
  ORDER BY department;
  
  
  -- 11.how has the company's employee count changed over time based on hire and term dates!
  SELECT
   year,hires,terminations,
   hires-terminations AS net_change,
   round((hires-terminations)/hires*100,2) AS net_change_percent
  FROM (
         SELECT YEAR(hire_date) AS year,
         COUNT(*) AS hires,
         SUM(CASE WHEN termdate IS NOT NULL AND termdate<=CURDATE() THEN 1 ELSE 0 END) AS terminations
	FROM hr WHERE age>=18
         GROUP BY YEAR(hire_date) ) AS hd
  ORDER BY year ASC; 
  
  -- 12.what is the tenure distribution for each department!
  SELECT department,
         ROUND(AVG(datediff(termdate,hire_date)/365),0) AS avg_tenure
	FROM hr WHERE termdate<=curdate() AND termdate IS NOT NULL AND age>=18
			group by department;
         