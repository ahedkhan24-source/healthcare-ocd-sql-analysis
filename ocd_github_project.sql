CREATE DATABASE IF NOT EXISTS ocd_db;
 USE ocd_db;
-- Step 2: Create Table Schema DROP TABLE IF EXISTS ocd_patients; 
CREATE TABLE ocd_patients ( patient_id INT PRIMARY KEY, age INT, gender VARCHAR(10), 
ethnicity VARCHAR(50), marital_status VARCHAR(30), 
education_level VARCHAR(30), ocd_diagnosis_date DATE, duration_of_symptoms_months INT,
 previous_diagnoses VARCHAR(50), family_history_of_ocd VARCHAR(10), obsession_type VARCHAR(50), 
 compulsion_type VARCHAR(50), ybocs_score_obsessions INT, ybocs_score_compulsions INT,
 depression_diagnosis VARCHAR(10), anxiety_diagnosis VARCHAR(10),
 medications VARCHAR(50) );
 
 use ocd_db;
 
select count(*) as total_patients from ocd_patients;

-- Data Cleansing & NULL Auditing

SELECT SUM(CASE WHEN previous_diagnoses IS NULL THEN 1 ELSE 0 END) AS missing_prev_diag, 
SUM(CASE WHEN medications IS NULL THEN 1 ELSE 0 END) AS missing_meds FROM ocd_patients;

-- Q1: Count Total Patients in the Clinical Study

select count(*) as total_count from ocd_patients;

-- Q2: Gender Breakdown of OCD Patients
select gender,count(*) as total_gender_count from ocd_patients group by gender;


-- Q3: Calculate Average Age Across Genders
select gender,round(avg(age),2) as avg_gender from ocd_patients group by gender;

-- Q4: Find the Most Common Obsession Type

select obsession_type,count(*) as total_cases from ocd_patients group by obsession_type
order by total_cases desc;

-- Q5: Find the Most Common Compulsion Type 

select compulsion_type ,count(*) as total_type from ocd_patients group by compulsion_type 
order by total_type desc;

-- Q6: Average Y-BOCS Obsession & Compulsion Scores

select round(avg(ybocs_score_obsessions),2) as avg_obsessions , round(avg(ybocs_score_compulsions),2) as avg_compulsions
from ocd_patients;

-- Q7: Count Patients with Comorbid Depression and Anxiety 
select count(*) as dual_comborbid_count from ocd_patients where depression_diagnosis='Yes'
and anxiety_diagnosis='Yes';

-- Q8: Average Y-BOCS Total Score by Ethnicity

select ethnicity,round(avg(ybocs_score_obsessions + ybocs_score_compulsions),2)as total_avg 
from ocd_patients group by ethnicity order by total_avg desc;

-- Q9: Family History of OCD vs. Severity

select family_history_of_ocd,count(*) as patients_count,
round(avg(ybocs_score_obsessions + ybocs_score_compulsions),2) as total_count
from ocd_patients group by family_history_of_ocd;

-- Q10: Top Prescribed Pharmaceutical Medications 
 
 select medications,count(*) as total_count from ocd_patients where medications is not null 
 group by medications order by total_count desc;
 
 -- Q11: Average Duration of Symptoms by Marital Status
 
 select marital_status,round(avg(duration_of_symptoms_months),1) as avg_duration_months
 from ocd_patients group by marital_status;
 
 -- Q12: Ranking Patients by Severity via DENSE_RANK()
 
select patient_id,age,gender,(ybocs_score_obsessions+ybocs_score_compulsions) as total_ybocs
,dense_rank() over (order by (ybocs_score_obsessions+ybocs_score_compulsions) desc)
as severity_rank from ocd_patients;

-- Q13: Patients Exceeding Cohort Average Y-BOCS Score 

select avg(ybocs_score_obsessions+ybocs_score_compulsions) as avg_ybocs from ocd_patients; 
 
select patient_id,age,gender,(ybocs_score_obsessions+ybocs_score_compulsions) as total_score 
from ocd_patients where (ybocs_score_obsessions+ybocs_score_compulsions)>
(select avg(ybocs_score_obsessions+ybocs_score_compulsions) from ocd_patients);

-- Q14: Cumulative Patient Counts by Diagnosis Year 

with my_cte as (select year(ocd_diagnosis_date) as diag_year,count(*) as new_patients from ocd_patients
group by (ocd_diagnosis_date))
select diag_year,new_patients,sum(new_patients) over 
(order by diag_year asc rows between unbounded preceding and current row) as cumalative_patients
from my_cte;

-- Q15: Categorizing Patient Severity via CASE WHEN 

select patient_id,(ybocs_score_obsessions+ybocs_score_compulsions) as total_ybocs,
case when (ybocs_score_obsessions+ybocs_score_compulsions)>30 then 'Serve'
when (ybocs_score_obsessions+ybocs_score_compulsions)>=20 then 'Moderate'
else 'Mild' end as clinical_severity from ocd_patients;







