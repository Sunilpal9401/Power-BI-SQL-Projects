# Employee_Analytics _SQL
## Overview
The Employee Management System project involves creating a T-SQL database to manage and query employee information efficiently. 
This system will enable seamless handling of employee records, salary details, and
departmental data through well-structured SQL queries.

![optimize-your-database-with-sql-expertise](https://github.com/user-attachments/assets/fadcfcd2-196f-447a-ad8d-a12222178e35)


## Key Objectives:

- Data Exploration: Understand the structure, content, and relationships within the dataset.
- Query Development: Write SQL queries to extract relevant information and answer specific business questions.
- Data Analysis: Analyze the results to identify patterns, trends, and insights.

## Business Queries

### Question 1 :Retrieve employees with a salary less than the average salary of all employees.
```sql
SELECT * FROM employeeDetails WHERE Salary < (SELECT AVG(Salary) FROM employeeDetails)
```

