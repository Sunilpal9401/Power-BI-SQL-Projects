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

![image](https://github.com/user-attachments/assets/7d159380-d2c0-4c92-be83-7991a97cbe50)


### Question 2: Retrieve the top 3 highest paid employees.
```sql
SELECT top 3 * FROM employeeDetails ORDER BY Salary DESC
```
![image](https://github.com/user-attachments/assets/d44f25f3-80aa-4c58-9f98-f68cf0d8f902)

### Question 3 : Retrieve employees whose hire date is not in 2017.
```sql
SELECT * FROM employeeDetails WHERE YEAR(HireDate) <> 2017;
```
![image](https://github.com/user-attachments/assets/aecf377a-2e26-452b-b7b9-bf51a38259fc)

### Question 4 : Retrieve the nth highest salary (you can choose the value of n=10).
```sql
SELECT DISTINCT Salary FROM employeeDetails ORDER BY Salary DESC OFFSET 10-1 ROWS FETCH NEXT 1 ROWS ONLY;
```

![image](https://github.com/user-attachments/assets/60d22ac1-3277-4c89-8482-04d49db69727)

### Question 5 : Retrieve employees who were hired in the same year as ‘Priya Reddy’.
```sql
SELECT * FROM employeeDetails WHERE YEAR(HireDate) = 
(SELECT YEAR(HireDate) FROM employeeDetails WHERE FirstName = 'Priya' AND LastName = 'Reddy');
```
![image](https://github.com/user-attachments/assets/e1bdbd7e-2cd2-4037-bedd-8e31df5123f1)

### Question 6 : Retrieve employees who have been hired on weekends (Saturday or Sunday).
```sql
SELECT *  FROM employeeDetails WHERE DATEPART(WEEKDAY, HireDate) IN (1, 7);
```
![image](https://github.com/user-attachments/assets/485a9778-9014-41b4-a2fd-283a25189c4d)


### Question 7 : Retrieve employees who have been hired in the last 6 years.
```sql
SELECT * FROM employeeDetails  WHERE HireDate >= DATEADD(YEAR, -6, GETDATE());
```
![image](https://github.com/user-attachments/assets/49f472ec-25e9-458c-87d9-0ba740bacba7)

### Question 8 : Retrieve the department with the highest average salary.
```sql
SELECT Department
FROM employeeDetails
GROUP BY Department
HAVING AVG(Salary) = (
    SELECT MAX(AvgSalary)
    FROM (
        SELECT AVG(Salary) AS AvgSalary
        FROM employeeDetails
        GROUP BY Department
    ) AS AvgSalaries
);
```
![image](https://github.com/user-attachments/assets/424046af-5991-48b5-b6d0-93731410ed4f)

### Question 9 : Retrieve the top 2 highest paid employees in each department.
```sql
SELECT EmployeeID, FirstName, LastName, Department,
Salary
FROM (
    SELECT EmployeeID, FirstName,LastName,
    DepartmenT,
    Salary,
    ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Salary DESC) AS Rank
    FROM employeeDetails
    ) AS RankedemployeeDetails
    WHERE Rank <= 2;

Method 2 :
WITH CTE AS
(
SELECT EmployeeID, FirstName, LastName, Department, Salary,
ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Salary DESC) AS Rank
FROM employeeDetails
)

SELECT * FROM CTE  WHERE Rank <= 2;
```
![image](https://github.com/user-attachments/assets/65f8cef9-07b8-4aef-9999-118bb4419165)

### Question 10 : Retrieve the cumulative salary expense for each department sorted by department and hire date.
```sql
SELECT EmployeeID, FirstName, LastName, Department, Salary,HireDate,
SUM(Salary) OVER(PARTITION BY Department ORDER BY HireDate) AS CumulativeSalaryExpense
FROM employeeDetails
ORDER BY Department, HireDate;
```
![image](https://github.com/user-attachments/assets/134c2425-c75b-49ce-a5e8-016a00f00c8c)


### Question 11 : Retrieve the employee ID, salary, and the next highest salary for each employee.
```sql
SELECT EmployeeID,
Salary,
LEAD(Salary) OVER (ORDER BY Salary DESC) AS NextHighestSalary
FROM employeeDetails;
```
![image](https://github.com/user-attachments/assets/8e48b7c3-f4ea-4614-95c0-540245fad28a)


### Question 12 : Retrieve the employee ID, salary, and the difference between the current salary and the next highest salary for each employee.
```sql
SELECT EmployeeID, Salary,
Salary - LEAD(Salary) OVER (ORDER BY Salary DESC)  AS SalaryDifference
FROM employeeDetails;
```
![image](https://github.com/user-attachments/assets/68f6cadf-afa0-4de8-867e-6b3dd0eb7725)

### Question 13 : Retrieve the employee(s) with the highest salary in each department.
```sql
SELECT *FROM (
  SELECT *, dense_rank() OVER(PARTITION BY Department ORDER BY Salary DESC) AS Rank
  FROM employeeDetails
) AS RankedemployeeDetails
  WHERE Rank = 1;
```
![image](https://github.com/user-attachments/assets/42a72f70-b5d5-4da5-afb6-3298755af461)

### Question 14 : Retrieve the department(s) where the total salary expense is greater than the average total salary expense across all departments.
```sql
SELECT Department, SUM(Salary) AS TotalSalaryExpense
FROM employeeDetails
GROUP BY Department
HAVING SUM(Salary) >
(SELECT AVG(TotalSalaryExpense) FROM
            (SELECT SUM(Salary) AS TotalSalaryExpense
            FROM employeeDetails GROUP BY Department) AS AvgTotalSalary);
```
![image](https://github.com/user-attachments/assets/2491d7bd-de68-46da-aad9-3ff5367a51fa)

### Question 15 : Retrieve the employee(s) who have the same first name and last name as any other employee.
```sql
SELECT *
FROM employeeDetails e1
WHERE EXISTS (
    SELECT 1
    FROM employeeDetails e2
    WHERE e1.EmployeeID != e2.EmployeeID
    AND e1.FirstName = e2.FirstName
    AND e1.LastName = e2.LastName );
```
![image](https://github.com/user-attachments/assets/2d37ea19-1fd1-4ddf-a6b3-8344719b03e1)

### Question 16 : Retrieve the employee(s) who have been with the company for more then 7 Years.
```sql
SELECT FirstName, LastName, DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsWithCompany
FROM employeeDetails
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 7;
```
![image](https://github.com/user-attachments/assets/08b928b2-3b86-43a9-a786-e498dd6271ff)

### Question 17 : Retrieve the department with the highest salary range (Difference b/w highest and lowest).
```sql
SELECT Department, MAX(Salary) - MIN(Salary) AS Range
FROM employeeDetails
GROUP BY Department
ORDER BY Range DESC
```
![image](https://github.com/user-attachments/assets/f967fe34-73d6-435b-9c06-de782bb62b44)








