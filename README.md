# 📊SQL Project: Quantifying Training ROI and Skill Gaps

_Analysing Organisation-wide skill gaps and training effectiveness to optimize financial problems and reduce operational risk using SQL and MS Excel._

---

## **Overview:**

This Project measures employee skill gaps using SQL to show where where training is actually needed.It identifies weak skills, high risk employees, and missing training programs using clean data analysis. Overall it helps companies spend training money smarter with clear, data-backed insights.

---

## **Business Problem:**

Effective workforce development and training investment are critical for any growing organisation. This Project aims to:

• Identiy the single most critical skill gap causing the highest operational and revenue impact  
• Measure the ROI of training programs by comparing post-training performance course costs    
• Determine the top 3 high-risk skill gap between the specific department    
• Flag the employee who pose the greatest productivity and replacement cost-risk due to multiple severe gap 
• Detect high command skills that currently have no training programs, guiding future course development   

---

## **Tools & Technologies:**
- **SQL(PostgreSQL):** I used SQL to store, organize, and analyze training data to measure impact. Used for data modelling, ensuring data integrity (FKs), and performing advanced aggregation to calculate the Gap and ROI metrics.   
- **Microsoft Excel:** Used to take the query results (the numbers) and turn them into easy-to-read Bar Charts that any manager can understand immediately.
- **GitHub:** Used to professionally showcase the project, allowing the interviewer to easily review the code and documentation.

---

## **Dataset**
- Multiple CSV files located in /data/ folder(Employees,Skills,Emp_Skills_Score,Training_cost)
- Clean normalized tables created from these files and used for all SQL analysis

---

## **The Analysis:**

we are quering data to identify budget priorities and miaximumm the return on our human capital investment.

Qno1. Identify the single most critical skill gap causing the highest operational and revenue impact?

To identidy high skill gap , here i m calculating the average deifict ( required - current Deficinecy ) across the entire company, guiding where immediate training budget should be allocated.

```sql
select skils.skill_name AS "Most Critical Skill Gap"
sum(emp_skill.required_proficiency-emp_skill.current_proficiency) AS "Total Gap score"
from emp_skill
inner join
skills on emp_skill.skill_id = skills.skill_id
group by
skills.skill_name order by "Total Gap Score" DESC
Limit 1;
```

<img width="594" height="355" alt="image" src="https://github.com/user-attachments/assets/f3f8cda4-f03d-44f6-842c-601d425c265c" />

**Key Breakdown:**      
• By running this qiery, the result showed us IT Troubleshooting has the highest average gap(4), indicating the most critical weakness across the entire workforce.           
• This provides the data-driven mandate to prioritize the  pudget for IT Troubleshooting Training Immediately.          

Qno2. Measure the ROI of training programs by comparing post-training performance course costs?

To prove training  works, i focused on the output. i joined the employee records with the training() table data to find the collective performance versus the cost of the session.

```sql
select 
      training.sess_name AS "Training Session",
      emps.first_name AS "Employee First Name",
      emps.last_name AS "Employee Last Name",
      training.session_cost AS "Session Cost",
      training.post_training_score AS "Effective Score (0-100)",
      round((training.post_training_score/training.session_cost*100),3) AS "Training ROI Score"
from 
      training
left join
      emps on training.emp_id=emps.emp_id 
order by "Training ROI Score" DESC;
```

<img width="579" height="283" alt="image" src="https://github.com/user-attachments/assets/a445fcb6-a892-46eb-899d-55c8fcb055c3" />

**Key Breakdown:**      
• The query showes **96.3% average effective score** for a average cost of ₹1190.      
• This confirms high-ROI program ,with providing the financial justication needed to scale this course model across other skill categories.      

Qno3. Determine the top 3 high-risk skill gap between the specific department 

To determine the top 3 high-risk skill gaps, i jjoined employee departs with the individual skill deficit score, providing a clear rankinng of which specific department/skills combination poses the greatest threat to productivity.

```sql
select
      emps.Depart AS "Target Department",
      skills.skill_name AS "High-Risk skill",
-- SUM of (required proficiency - current proficiency) gives the total deficit for that skill
sum (emp_skill.required_proficiency-emp_skill.current_proficiency) AS "Department Total Gap Score"
from
    emp_skill
    inner join 
    skills on emp_skill.skill_id = skills.skill_id
inner join
    emps on emp_skill.emp_id =emps.emp_id
group by
    emps.Depart, skills.skill_name
order by
    "Department Total Gap Score" DESC
Limit 3;
```


**Key Breakdown:**      
• Here **Department Total Gap Score**, this quantifies the single largest skill deficiency for a specific team.It proves that gap is severe and localized to a specific team.     
• This concludes that training funds must be deployed to resolve the #1 ranked skill-gap. This action resolves the biggest local bottleneck first, maximizing immediate providivity gains.      

Qno4. Flag the employee who pose the greatest productivity and replacement cost-risk due to multiple severe gap

To Identify the employees who pose the greatest operational risk due to multiple severe skill gaps, I need to flag individuals who pose a high operational risk. This requires advance grouping and filtering usinng the having clause

```sql
SELECT
    emps.emp_id AS "High-Risk ID",
    emps.first_name,
    emps.last_name,
    emps.Depart,
    -- PRIMARY RISK METRIC (Productivity Risk): The total sum of all skill deficits.
    SUM(emp_skill.required_proficiency - emp_skill.current_proficiency) AS "Productivity Risk Score",
    -- SECONDARY RISK METRIC (Replacement Cost Risk): The count of different skills requiring training.
    COUNT(CASE
        -- Check where a gap exists
        WHEN (emp_skill.required_proficiency - emp_skill.current_proficiency) > 0
        THEN 1
    END) AS "Affected Skill Count"
FROM
    emp_skill
INNER JOIN
    emps ON emp_skill.emp_id = emps.emp_id
GROUP BY
    emps.emp_id,
    emps.first_name,
    emps.last_name,
    emps.Depart
ORDER BY
    "Productivity Risk Score" DESC, -- Sort first by the largest overall skill deficit
    "Affected Skill Count" DESC      -- Then by the number of different skills affected
LIMIT 3; -- Returns only the single highest-risk employee
```
**Key Breakdown:**      
• This query identifes individuals whith three severe skill gaps.     
• This list is crucial for HR inntervention-these employees need immediate coaching or customized             development plans to prevent performance failure.     

Qno5. Detect high command skills that currently have no training programs, guiding future course development

Identifying critical skill gaps that currently have no corresponding training solution. This provides a clear roadmap for high-yield new course development-directing future capital investment,

```sql
select 
skills.skill_id AS "Missing Course", skills.skill_name AS "Course Name",
-- Calculate the average gap to prove people actually need this skill
round(avg(emp_skill.required_proficiency-emp_skill.current_proficiency),3) AS "Average Gap Score"
from
emp_skill,skills
left join
training on skills.skill_id = training.skill_id
where 
training.sess_id is null
group by
skills.skill_id
having 
avg(emp_skill.required_proficiency-emp_skill.current_proficiency) > 0;
```
**Key Breakdown:**         
• This query returnes skills like advanced data modeling which had a high average gap but were missing from the tranining() table.       
• Here , it tells the training department exactly what new course to build next to maximize business impact.     

## What i Learned

Throught this journey, I supercharged my SQL skills with some Powerful upgrades:
• **risk Scoring:** I learned to create **composite risk metrics** using sum() and count(when) to proritize     training needs by both the size of the deficit and the number of skills affected.    
• **Targeted Intelligence:** I mastered using Inner join and group by to isolate risks by department,           transforming general data into **highly actionable,localized training priorities**.        
• **Missing Data Detection:** I effectively used the left join andwhere is null pattern to detect skills        with high demand but zero training programs available, guiding future course development.       
• **Financial Analysis:** I built custom mathematical formulas to calculate the training the **Training ROI     Score**,providing the financial justification needed to cut wasteful programs and scale efficient ones.

**Conclusion:**      
This Project proves that the role of Data Analyst is to deliver **data-backed fiducary responsibility**. By quantifying the skill gap as a financial risk and training outcomes as mesurable ROI, this system provides leadership with the objective proof they need to stop wasting training and start **precise,high-impact capital investments** in their human resources.
