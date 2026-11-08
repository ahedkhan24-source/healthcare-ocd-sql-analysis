# Healthcare Capstone Project: OCD Patient Clinical Data Analysis

## Executive Summary
This project delivers a comprehensive clinical data analysis of Obsessive-Compulsive Disorder (OCD) patient demographics, obsession/compulsion trends, and diagnosis timelines using MySQL Workbench. The target dataset was audited for data hygiene, structured, and queried to solve key clinical questions, providing actionable insights for healthcare researchers and clinical management.

---

## Dataset & Database Schema
* **Database Name:** `ocd_db`
* **Primary Table:** `ocd_patient`
* **Key Attributes Analyzed:** Patient ID, Age, Gender, Ethnicity, Marital Status, Education Level, OCD Diagnosis Date, Duration of Symptoms, Obsession Score, Compulsion Score, Previous Diagnoses, and Medications.

---

## Repository Structure
```text
├── 01_schema_setup.sql      # Database initialization, table DDL creation, and charset configuration
├── 02_data_cleaning.sql     # NULL value auditing, data hygiene queries, and missing record checks
├── 03_clinical_queries.sql   # Execution of 15 advanced clinical business queries (window functions, CTEs)
└── README.md                # Project documentation and summary findings
# healthcare-ocd-sql-analysis
