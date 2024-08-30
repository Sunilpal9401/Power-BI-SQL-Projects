# Challenges that Bank is facing to solve 

In order to monitor and assess our bank's lending activities and performance, we need to create a comprehensive Bank Loan Report. This report aims to provide insights into key loan-related metrics and their changes over time. The report will help us make data-driven decisions, track our loan portfolio's health, and identify trends that can inform our lending strategies.


# Key Performance Indicators (KPIs) Requirements:

- 1.Total Loan Applications: We need to calculate the total number of loan applications received during a specified period. Additionally, it is essential to monitor the Month-to-Date (MTD) Loan Applications and track changes Month-over-Month (MoM).

- 2.Total Funded Amount: Understanding the total amount of funds disbursed as loans is crucial. We also want to keep an eye on the MTD Total Funded Amount and analyse the Month-over-Month (MoM) changes in this metric.

- 3.Total Amount Received: Tracking the total amount received from borrowers is essential for assessing the bank's cash flow and loan repayment. We should analyse the Month-to-Date (MTD) Total Amount Received and observe the Month-over-Month (MoM) changes.

- 4.Average Interest Rate: Calculating the average interest rate across all loans, MTD, and monitoring the Month-over-Month (MoM) variations in interest rates will provide insights into our lending portfolio's overall cost.

- 5.Average Debt-to-Income Ratio (DTI): Evaluating the average DTI for our borrowers helps us gauge their financial health. We need to compute the average DTI for all loans, MTD, and track Month-over-Month (MoM) fluctuations.



# Good Loan v Bad Loan KPI’s

In order to evaluate the performance of our lending activities and assess the quality of our loan portfolio, we need to create a comprehensive report that distinguishes between 'Good Loans' and 'Bad Loans' based on specific loan status criteria

## Good Loan KPIs:

- 1.Good Loan Application Percentage: We need to calculate the percentage of loan applications classified as 'Good Loans.' This category includes loans with a loan status of 'Fully Paid' and 'Current.'

- 2.Good Loan Applications: Identifying the total number of loan applications falling under the 'Good Loan' category, which consists of loans with a loan status of 'Fully Paid' and 'Current.'

- 3.Good Loan Funded Amount: Determining the total amount of funds disbursed as 'Good Loans.' This includes the principal amounts of loans with a loan status of 'Fully Paid' and 'Current.'

- 4.Good Loan Total Received Amount: Tracking the total amount received from borrowers for 'Good Loans,' which encompasses all payments made on loans with a loan status of 'Fully Paid' and 'Current.'

## Bad Loan KPIs:

- 1.Bad Loan Application Percentage: Calculating the percentage of loan applications categorized as 'Bad Loans.' This category specifically includes loans with a loan status of 'Charged Off.'

- 2.Bad Loan Applications: Identifying the total number of loan applications categorized as 'Bad Loans,' which consists of loans with a loan status of 'Charged Off.'

- 3.Bad Loan Funded Amount: Determining the total amount of funds disbursed as 'Bad Loans.' This comprises the principal amounts of loans with a loan status of 'Charged Off.'

- 4.Bad Loan Total Received Amount: Tracking the total amount received from borrowers for 'Bad Loans,' which includes all payments made on loans with a loan status of 'Charged Off.'

## Loan Status Grid View
In order to gain a comprehensive overview of our lending operations and monitor the performance of loans, we aim to create a grid view report categorized by 'Loan Status.' This report will serve as a valuable tool for analysing and understanding the key indicators associated with different loan statuses. By providing insights into metrics such as 
- Total Loan Applications
- Total Funded Amount
- Total Amount Received
- Month-to-Date (MTD) Funded Amount
- MTD Amount Received
- Average Interest Rate
- Average Debt-to-Income Ratio (DTI)
this grid view will empower us to make data-driven decisions and assess the health of our loan portfolio.


# DASHBOARD 2: OVERVIEW

In our Bank Loan Report project, we aim to visually represent critical loan-related metrics and trends using a variety of chart types. These charts will provide a clear and insightful view of our lending operations, facilitating data-driven decision-making and enabling us to gain valuable insights into various loan parameters. 

Below are the specific chart requirements:

- 1. Monthly Trends by Issue Date (Line Chart):
Chart Type: Line Chart
Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
X-Axis: Month (based on 'Issue Date')
Y-Axis: Metrics' Values

**Objective:** This line chart will showcase how 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received' vary over time, allowing us to identify seasonality and long-term trends in lending activities.

- 2. Regional Analysis by State (Filled Map):
Chart Type: Filled Map
Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
Geographic Regions: States

**Objective:** This filled map will visually represent lending metrics categorized by state, enabling us to identify regions with significant lending activity and assess regional disparities.

- 3. Loan Term Analysis (Donut Chart):
Chart Type: Donut Chart
Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
Segments: Loan Terms (e.g., 36 months, 60 months)

**Objective:** This donut chart will depict loan statistics based on different loan terms, allowing us to understand the distribution of loans across various term lengths.

- 4. Employee Length Analysis (Bar Chart):
Chart Type: Bar Chart
Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
X-Axis: Employee Length Categories (e.g., 1 year, 5 years, 10+ years)
Y-Axis: Metrics' Values

**Objective:** This bar chart will illustrate how lending metrics are distributed among borrowers with different employment lengths, helping us assess the impact of employment history on loan applications.

- 5. Loan Purpose Breakdown (Bar Chart):
Chart Type: Bar Chart
Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
X-Axis: Loan Purpose Categories (e.g., debt consolidation, credit card refinancing)
Y-Axis: Metrics' Values

**Objective:** This bar chart will provide a visual breakdown of loan metrics based on the stated purposes of loans, aiding in the understanding of the primary reasons borrowers seek financing.

- 6. Home Ownership Analysis (Tree Map):
Chart Type: Tree Map
Metrics: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
Hierarchy: Home Ownership Categories (e.g., own, rent, mortgage)

**Objective:** This tree map will display loan metrics categorized by different home ownership statuses, allowing for a hierarchical view of how home ownership impacts loan applications and disbursements.
These diverse chart types will enhance our ability to visualize and communicate loan-related insights effectively, supporting data-driven decisions and strategic planning within our lending operations."


# DASHBOARD 3: DETAILS
In our Bank Loan Report project, we recognize the need for a comprehensive 'Details Dashboard' that provides a consolidated view of all the essential information within our loan data. This Details Dashboard aims to offer a holistic snapshot of key loan-related metrics and data points, enabling users to access critical information efficiently.

**Objective:**
The primary objective of the Details Dashboard is to provide a comprehensive and user-friendly interface for accessing vital loan data. It will serve as a one-stop solution for users seeking detailed insights into our loan portfolio, borrower profiles, and loan performance.

# | FINANCIAL LOAN MySQL REPORT |

## BANK LOAN REPORT | SUMMARY

#### KPI’s:

Total Loan Applications
```sql
SELECT COUNT(id) AS Total_Applications FROM financial_loan
```
![image](https://github.com/user-attachments/assets/526fddca-8833-4696-8877-2b7810105a7b)

 
MTD Loan Applications
```sql
SELECT COUNT(id) AS Total_Applications FROM financial_loan
WHERE MONTH(issue_date) = 12
```
![image](https://github.com/user-attachments/assets/7ad3ab81-c7f1-4868-a805-3feb7a258f79)

 
PMTD Loan Applications
```sql
SELECT COUNT(id) AS Total_Applications FROM financial_loan
WHERE MONTH(issue_date) = 11
```
![image](https://github.com/user-attachments/assets/c271c61f-dcea-407e-912e-cad4e46dca6b)

 

Total Funded Amount
```sql
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial_loan
```
![image](https://github.com/user-attachments/assets/86ba93d0-00d9-4f1c-ba09-108629af9a7c)

 
MTD Total Funded Amount
```sql
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial_loan
WHERE MONTH(issue_date) = 12
```
![image](https://github.com/user-attachments/assets/8028cd10-73a3-4354-b69d-169532935ca7)

 
PMTD Total Funded Amount
```sql
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial_loan
WHERE MONTH(issue_date) = 11
```
![image](https://github.com/user-attachments/assets/0a81ca23-56cd-4549-876a-feba8fb9cd3e)

 


Total Amount Received
```sql
SELECT SUM(total_payment) AS Total_Amount_Collected FROM financial_loan
```
![image](https://github.com/user-attachments/assets/e356bf75-5594-4607-a4da-a7a2d374c06e)

 
MTD Total Amount Received
```sql
SELECT SUM(total_payment) AS Total_Amount_Collected FROM financial_loan
WHERE MONTH(issue_date) = 12
```
![image](https://github.com/user-attachments/assets/a302a269-cab2-44e7-932b-e4176cad0f43)

 
PMTD Total Amount Received
```sql
SELECT SUM(total_payment) AS Total_Amount_Collected FROM financial_loan
WHERE MONTH(issue_date) = 11
```
![image](https://github.com/user-attachments/assets/ac8eb248-340e-4e35-a071-a4a18ea76633)

 

Average Interest Rate
```sql
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM financial_loan
```
![image](https://github.com/user-attachments/assets/746e22b8-4631-438d-95c8-cd987d2ae595)

 
MTD Average Interest
```sql
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM financial_loan
WHERE MONTH(issue_date) = 12
```
![image](https://github.com/user-attachments/assets/e90cde11-329c-46b4-9ca2-6afeb71f439a)

 
PMTD Average Interest
```sql
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM financial_loan
WHERE MONTH(issue_date) = 11
```
![image](https://github.com/user-attachments/assets/4757604b-f782-4b62-89f5-cc1dd71b57d9)

 





Avg DTI
```sql
SELECT AVG(dti)*100 AS Avg_DTI FROM financial_loan
```
![image](https://github.com/user-attachments/assets/8c0719fb-17c3-470b-a2af-5759aaefea12)

 
MTD Avg DTI
```sql
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM financial_loan
WHERE MONTH(issue_date) = 12
```
![image](https://github.com/user-attachments/assets/80fa42ab-14bb-41f6-b654-2a1f8193a7bb)

 
PMTD Avg DTI
```sql
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM financial_loan
WHERE MONTH(issue_date) = 11
 ```
![image](https://github.com/user-attachments/assets/d743a3e4-dc75-4f37-9337-f7f0a1a46fe9)



GOOD LOAN ISSUED
Good Loan Percentage
```sql
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM financial_loan
```
![image](https://github.com/user-attachments/assets/43bb7d6a-51a1-4713-9faf-aebe9f9e68a1)

 
Good Loan Applications
```sql
SELECT COUNT(id) AS Good_Loan_Applications FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
```
![image](https://github.com/user-attachments/assets/08bf7250-03fe-43fd-9985-8fd10b33a6d1)

 
Good Loan Funded Amount
```sql
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
```
![image](https://github.com/user-attachments/assets/0fd0c3e4-feb1-4e6b-8d53-483b4629151b)

 

Good Loan Amount Received
```sql
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
```
![image](https://github.com/user-attachments/assets/0f36b6a7-9d72-4565-925c-dfd6621a45e5)

 

BAD LOAN ISSUED
Bad Loan Percentage
```sql
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM financial_loan
 ```
![image](https://github.com/user-attachments/assets/54ce361c-d5a4-41aa-a534-c2bb75b94f20)


Bad Loan Applications
```sql
SELECT COUNT(id) AS Bad_Loan_Applications FROM financial_loan
WHERE loan_status = 'Charged Off'
```
![image](https://github.com/user-attachments/assets/91511466-5d56-470a-8583-8d89749783e0)

 
Bad Loan Funded Amount
```sql
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM financial_loan
WHERE loan_status = 'Charged Off'
```
![image](https://github.com/user-attachments/assets/82aa3db4-328f-40a4-931d-79cbf649c551)

 
Bad Loan Amount Received
```sql
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM financial_loan
WHERE loan_status = 'Charged Off'
```
 ![image](https://github.com/user-attachments/assets/653d0c05-27f9-4b03-9605-6ccbc7dd5b9a)





LOAN STATUS
```sql
	SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        financial_loan
    GROUP BY
        loan_status
```
![image](https://github.com/user-attachments/assets/2ad160f3-c493-4eff-8f93-4d43d3db4a7d)

 

```sql
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status
 ```
![image](https://github.com/user-attachments/assets/5e5c0cb3-7558-452f-aee2-f1fb17b2da89)


# BANK LOAN REPORT | OVERVIEW
MONTH
```sql
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)
```
![image](https://github.com/user-attachments/assets/cab45976-f07a-419b-b5ec-3a87c5af72f7)

 
STATE
```sql
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state
 ```
![image](https://github.com/user-attachments/assets/7e291e0f-1547-4a8b-b9d1-513d861c917c)


TERM
```sql
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term
 ```
![image](https://github.com/user-attachments/assets/d8e0a1e9-2666-403c-acf3-730e7f4e76f8)


EMPLOYEE LENGTH
```sql
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length
 ```
![image](https://github.com/user-attachments/assets/2e91abaa-ee7d-449a-8256-41802c22647f)


PURPOSE
```sql
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY purpose
 ```
![image](https://github.com/user-attachments/assets/368ca867-1d82-4296-96d2-1c7bda902c77)


HOME OWNERSHIP
```sql
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership
ORDER BY home_ownership
 ```
![image](https://github.com/user-attachments/assets/62cf5cc5-1fda-4f15-b7eb-20b5288d6f7d)


### Note: We have applied multiple Filters on all the dashboards. You can check the results for the filters as well by modifying the query and comparing the results.
For e.g
See the results when we hit the Grade A in the filters for dashboards.
```sql
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose
```
