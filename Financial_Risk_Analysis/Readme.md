# Financial Risk Analysis Project
## Description:
This repository contains a comprehensive analysis of loan risk factors in the banking sector using two datasets: `application_train.csv` and `previous_application.csv`. The project aims to provide insights into customer demographics, credit types, risk assessment, and business strategies.
### Part 1: Understanding the Bank
- **Total Records**: Determine the total number of records in the 'application_train' table.
```sql
select count(1) as Number_of_records from application_train;
```
![1](https://github.com/user-attachments/assets/d1070982-a4ce-47d5-a2a7-d0f201d9d4e5)

- **Credit Types**: Analyze the different types of credits offered by the bank.
```sql
select name_contract_type,cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as percentage 
from application_train
group by NAME_CONTRACT_TYPE;
```
![2](https://github.com/user-attachments/assets/adc247dd-ffed-41cb-af77-075b4b863d8d)


- **Gender Distribution**: Explore the gender distribution of loan applicants.
```sql
select CODE_GENDER,cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as percentage 
from application_train
group by CODE_GENDER;
```
![3](https://github.com/user-attachments/assets/98f1d6a2-007e-4563-bb85-815c3d8dc1ee)

- **Gender-wise Credit Distribution**: Analyze the distribution of credits based on gender.
```sql
select name_contract_type,code_gender,count(1) as volume,
cast(count(name_contract_type)*100.0/sum(count(name_contract_type))over(partition by name_contract_type) as decimal(4,2)) as percentage
from application_train
group by name_contract_type,CODE_GENDER
```
![4](https://github.com/user-attachments/assets/5c7bb4f0-3eff-4885-beee-b6ad88b4f6ca)


- **Income Distribution**: Analyze income distribution and descriptive statistics concerning credit type.
```sql
SELECT distinct name_contract_type AS name_contract_type
,cast(count(1)over(partition by name_contract_type) *100.0/(select count(1) from application_train) as decimal(4,2)) as percentage 
,cast(avg(amt_income_total)over(partition by name_contract_type) as int) as average_income
,min(amt_income_total) over(partition by name_contract_type) as min_income
,max(amt_income_total) over(partition by name_contract_type) as max_income
,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY amt_income_total) OVER (PARTITION BY name_contract_type) AS Median_Income
FROM application_train 
```
![5](https://github.com/user-attachments/assets/e248c13c-c6cb-4b6e-b229-4c2df6a9e61c)

- **Income & Credit Distribution**: Explore the relationship between income and credit amounts based on credit type.
```sql
SELECT distinct name_contract_type AS name_contract_type
,cast(count(1)over(partition by name_contract_type) *100.0/(select count(1) from application_train) as decimal(4,2)) as percentage 
,cast(avg(amt_income_total)over(partition by name_contract_type) as int) as average_income
,cast(avg(AMT_CREDIT)over(partition by name_contract_type) as int) as average_credit
,min(amt_income_total) over(partition by name_contract_type) as min_income
,min(AMT_CREDIT) over(partition by name_contract_type) as min_credit
,max(amt_income_total) over(partition by name_contract_type) as max_income
,max(AMT_CREDIT) over(partition by name_contract_type) as max_credit
,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY amt_income_total) OVER (PARTITION BY name_contract_type) AS Median_Income
,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY AMT_CREDIT) OVER (PARTITION BY name_contract_type) AS Median_Credit
FROM application_train 
```
![6](https://github.com/user-attachments/assets/251570e7-17f6-4330-b5f8-ccdaa6405d5f)

- **Goods Amount Analysis**: Analyze the goods amount for which loans are given in the case of cash loans.
```sql
SELECT distinct name_contract_type AS name_contract_type
,cast(count(1)over(partition by name_contract_type) *100.0/(select count(1) from application_train) as decimal(4,2)) as percentage 
,cast(avg(AMT_GOODS_PRICE)over(partition by name_contract_type) as int) as average_goods_amt
,cast(avg(AMT_CREDIT)over(partition by name_contract_type) as int) as average_credit
,min(AMT_GOODS_PRICE) over(partition by name_contract_type) as min_goods_amt
,min(AMT_CREDIT) over(partition by name_contract_type) as min_credit
,max(AMT_GOODS_PRICE) over(partition by name_contract_type) as max_goods_amt
,max(AMT_CREDIT) over(partition by name_contract_type) as max_credit
,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY AMT_GOODS_PRICE) OVER (PARTITION BY name_contract_type) AS Median_goods_amt
,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY AMT_CREDIT) OVER (PARTITION BY name_contract_type) AS Median_Credit
FROM application_train 
where NAME_CONTRACT_TYPE = 'Cash Loans'
```
![4](https://github.com/user-attachments/assets/4d836622-584b-4a77-8089-7f9c43a63146)



- **Basic Income Type Distribution**: Investigate the distribution of income types among applicants.
```sql
select name_income_type
,count(1) as volume
,cast(count(1)*100.0/sum(count(1))over() as decimal(4,2))as percentage
from application_train
group by NAME_INCOME_TYPE
order by percentage desc
```
![7](https://github.com/user-attachments/assets/095361a2-12c2-4c60-925d-818ce7034fac)


- **Basic Housing Type Distribution**: Explore the distribution of housing types among applicants.
```sql
select NAME_HOUSING_TYPE
,count(1) as volume
,cast(count(1)*100.0/sum(count(1))over() as decimal(4,2))as percentage
from application_train
group by NAME_HOUSING_TYPE
```
![8](https://github.com/user-attachments/assets/aa90e367-2525-4985-a812-40598804bed2)



- **Basic Occupation Distribution**: Analyze the distribution of occupations among applicants.
```sql
select OCCUPATION_TYPE
,cast(count(1)*100.0/sum(count(1))over() as decimal(4,2))as percentage
from application_train
group by OCCUPATION_TYPE
order by percentage desc
```
![9](https://github.com/user-attachments/assets/db3ee1c8-b18d-4242-ad4a-d322ef785473)




- **Region & City Rating Distribution**: Investigate the distribution of region and city ratings among applicants.
```sql
select REGION_RATING_CLIENT,
count(1) as Frequency,
cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as Percentage
from application_train
group by REGION_RATING_CLIENT

select REGION_RATING_CLIENT_W_CITY,
count(1) as Frequency,
cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as Percentage
from application_train
group by REGION_RATING_CLIENT_W_CITY
```
![10](https://github.com/user-attachments/assets/da33b8ef-d755-4fa7-b538-42cc9bc3787f)


### Part 2: Understanding the Client Base & Business Operations
- **Family Status**: Analyze the family status of the bank's clients.
```sqlselect NAME_FAMILY_STATUS
,count(1) as volume
,cast(count(1)*100.0/sum(count(1))over() as decimal(4,2))as percentage
from application_train
group by NAME_FAMILY_STATUS
order by percentage desc
```
- **Housing Distribution**: Explore the distribution of housing types among clients.
```sql
select NAME_HOUSING_TYPE
,count(1) as volume
,cast(count(1)*100.0/sum(count(1))over() as decimal(4,2))as percentage
from application_train
group by NAME_HOUSING_TYPE
order by percentage desc
```
- **Age Brackets**: Investigate the age brackets of the clients.
```sql
with age_application as (
select 
case when datediff(year,DATEADd(dd,DAYS_BIRTH,getdate()),GETDATE()) <=25 then '18-25' 
	when datediff(year,DATEADd(dd,DAYS_BIRTH,getdate()),GETDATE()) between 26 and 40 then '26-40' 
	when datediff(year,DATEADd(dd,DAYS_BIRTH,getdate()),GETDATE()) between 41 and 55 then '41-55' 
	when datediff(year,DATEADd(dd,DAYS_BIRTH,getdate()),GETDATE()) between 56 and 65 then '56-65' else '65above' end as age_bracket
from application_train)
select age_bracket
,count(1) as Frequency
,cast(count(1)*100.0/(select count(1) from application_train)as decimal(4,2)) as Percentage
from age_application
group by age_bracket
order by Percentage desc
```

- **Contacts Availability**: Analyze the availability of contact information for clients.
```sql
with contact_data as
(select
case when FLAG_MOBIL+FLAG_EMP_PHONE+FLAG_WORK_PHONE =3 then 'All Contacts Available'
when FLAG_MOBIL+FLAG_EMP_PHONE+FLAG_WORK_PHONE =2 then 'Two Contacts Available'
when FLAG_MOBIL+FLAG_EMP_PHONE+FLAG_WORK_PHONE =1 then '1 Contact Available'
else 'No Contact Available' end as contacts_provided
from application_train)
select contacts_provided,
count(1) as Frequency,
cast(count(1)*100.0/(select count(1) from contact_data) as decimal(4,2)) as percentage
from contact_data
group by contacts_provided
```

- **Documents Submission Analysis**: Analyze the submission of required documents by clients.
```sql
with Documents_data as
(select
case when FLAG_DOCUMENT_2+FLAG_DOCUMENT_3+FLAG_DOCUMENT_4+FLAG_DOCUMENT_5+FLAG_DOCUMENT_6+FLAG_DOCUMENT_7+FLAG_DOCUMENT_8+FLAG_DOCUMENT_9+FLAG_DOCUMENT_10+FLAG_DOCUMENT_11+FLAG_DOCUMENT_12+FLAG_DOCUMENT_13+FLAG_DOCUMENT_14+FLAG_DOCUMENT_15+FLAG_DOCUMENT_16+FLAG_DOCUMENT_17+FLAG_DOCUMENT_18+FLAG_DOCUMENT_19+FLAG_DOCUMENT_20+FLAG_DOCUMENT_21
between 15 and 20 then '15-20 Documents Available'
when FLAG_DOCUMENT_2+FLAG_DOCUMENT_3+FLAG_DOCUMENT_4+FLAG_DOCUMENT_5+FLAG_DOCUMENT_6+FLAG_DOCUMENT_7+FLAG_DOCUMENT_8+FLAG_DOCUMENT_9+FLAG_DOCUMENT_10+FLAG_DOCUMENT_11+FLAG_DOCUMENT_12+FLAG_DOCUMENT_13+FLAG_DOCUMENT_14+FLAG_DOCUMENT_15+FLAG_DOCUMENT_16+FLAG_DOCUMENT_17+FLAG_DOCUMENT_18+FLAG_DOCUMENT_19+FLAG_DOCUMENT_20+FLAG_DOCUMENT_21
between 10 and 14 then '10-14 Documents Available'
when FLAG_DOCUMENT_2+FLAG_DOCUMENT_3+FLAG_DOCUMENT_4+FLAG_DOCUMENT_5+FLAG_DOCUMENT_6+FLAG_DOCUMENT_7+FLAG_DOCUMENT_8+FLAG_DOCUMENT_9+FLAG_DOCUMENT_10+FLAG_DOCUMENT_11+FLAG_DOCUMENT_12+FLAG_DOCUMENT_13+FLAG_DOCUMENT_14+FLAG_DOCUMENT_15+FLAG_DOCUMENT_16+FLAG_DOCUMENT_17+FLAG_DOCUMENT_18+FLAG_DOCUMENT_19+FLAG_DOCUMENT_20+FLAG_DOCUMENT_21
between 5 and 9 then ' 5-9 Documents Available'
else 'Less than 5 Documents Available' end as Documents_provided
from application_train)
select Documents_provided,
count(1) as Frequency,
cast(count(1)*100.0/(select count(1) from documents_data) as decimal(5,2)) as percentage
from documents_data
group by Documents_provided
```
- **Loan Application Day Analysis**: Investigate the distribution of loan applications over days.
```sql
select WEEKDAY_APPR_PROCESS_START,
cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as Percentage
from application_train
group by WEEKDAY_APPR_PROCESS_START
order by Percentage desc
```
### Part 3: Target Variable & Risk Analysis
- **Credit Enquiries Analysis**: Analyze credit enquiries on clients before the loan application.
In general the banks check the credit profile of a client as a whole. There are multiple factors which affect the Cibil Score of an individual.
Credit Enquiry is just one of them. These Enquiries are of two types. 
Examples - Soft Enquiry - Employer checking your credit report, Hard Enquiry - Bank checking your credit report for approving credits
It is assumed that these are Hard Enquiries.
```sql
--- 1 Year before the application

select AMT_REQ_CREDIT_BUREAU_YEAR
,count(1) as Frequency
,cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as Percentage
from application_train
group by AMT_REQ_CREDIT_BUREAU_YEAR
order by percentage desc

--- 1 Quarter before the application

select top 5 AMT_REQ_CREDIT_BUREAU_QRT
,cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as Percentage
from application_train
group by AMT_REQ_CREDIT_BUREAU_QRT
order by percentage desc

--- 1 Month before the application

select top 5 AMT_REQ_CREDIT_BUREAU_MON
,cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as Percentage
from application_train
group by AMT_REQ_CREDIT_BUREAU_MON
order by percentage desc

--- 1 Week before the application

select top 5 AMT_REQ_CREDIT_BUREAU_WEEK
,cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as Percentage
from application_train
group by AMT_REQ_CREDIT_BUREAU_WEEK
order by percentage desc

--- 1 Day before the application

select top 5 AMT_REQ_CREDIT_BUREAU_DAY
,cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as Percentage
from application_train
group by AMT_REQ_CREDIT_BUREAU_DAY
order by percentage desc

--- 1 Hour before the application

select top 5 AMT_REQ_CREDIT_BUREAU_HOUR
,cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as Percentage
from application_train
group by AMT_REQ_CREDIT_BUREAU_HOUR
order by percentage desc
```
- **Risk Classification**: Classify clients based on risk factors such as default percentages.
```sql
--Basic enquiry averages
select avg(AMT_REQ_CREDIT_BUREAU_HOUR) as avg_hour_enquiry
,avg(AMT_REQ_CREDIT_BUREAU_DAY ) as avg_day_enquiry
,avg(AMT_REQ_CREDIT_BUREAU_WEEK) as avg_week_enquiry
,avg(AMT_REQ_CREDIT_BUREAU_MON ) as avg_month_enquiry
,avg(AMT_REQ_CREDIT_BUREAU_QRT ) as avg_quarter_enquiry
,avg(AMT_REQ_CREDIT_BUREAU_YEAR) as avg_year_enquiry
from application_train
```
Analysis of individual applications based on the credit enquiries
```sql
with enquiry_table as
(select 
case when AMT_REQ_CREDIT_BUREAU_YEAR is null then 'No Credit History'
when AMT_REQ_CREDIT_BUREAU_YEAR = 0 then 'No Enquiry in the past year'
when AMT_REQ_CREDIT_BUREAU_QRT = 0 then 'Had Enquiries within the year'
when AMT_REQ_CREDIT_BUREAU_MON = 0 then 'Had Enquiries within the quarter'
when AMT_REQ_CREDIT_BUREAU_WEEK = 0 then 'Had Enquiries within the month'
when AMT_REQ_CREDIT_BUREAU_DAY = 0 then 'Had Enquiries within the week'
when AMT_REQ_CREDIT_BUREAU_HOUR = 0 then 'Had Enquiries within the day' end as Enquiry_Status
from application_train)
select Enquiry_Status
,count(Enquiry_Status) as Frequency
,cast(count(Enquiry_Status)*100.0/(select count(1) from enquiry_table)as decimal(4,2)) as Percentage
from enquiry_table
group by Enquiry_Status
order by Percentage desc
```
Analysis of individual applications based on the credit enquiries
```sql
with default_scope as
(select isnull(cast(DEF_60_CNT_SOCIAL_CIRCLE*100.0/NULLIF(OBS_60_CNT_SOCIAL_CIRCLE,0) as decimal(5,2)),0) as Percentage
from application_train)
,risk_scope as
(select
case when Percentage=100 then 'Very High Risk'
when Percentage between 75 and 99 then 'High Risk'
when Percentage between 50 and 74 then 'Moderate Risk'
when Percentage between 25 and 49 then 'Low Risk'
when Percentage <25 then 'Very Low Risk' end as Risk_category_60_Days
from default_scope)
select Risk_category_60_Days,
count(1) as Frequency,
cast(count(1)*100.0/(select count(1) from risk_scope) as decimal(5,2)) as Percentage
from risk_scope
group by Risk_category_60_Days
order by Percentage desc
```

Analysis of individual applications based on the credit enquiries

```sql
with default_scope as
(select isnull(cast(DEF_30_CNT_SOCIAL_CIRCLE*100.0/NULLIF(OBS_30_CNT_SOCIAL_CIRCLE,0) as decimal(5,2)),0) as Percentage
from application_train)
,risk_scope as
(select
case when Percentage=100 then 'Very High Risk'
when Percentage between 75 and 99 then 'High Risk'
when Percentage between 50 and 74 then 'Moderate Risk'
when Percentage between 25 and 49 then 'Low Risk'
when Percentage <25 then 'Very Low Risk' end as Risk_category_30_Days
from default_scope)
select Risk_category_30_Days,
count(1) as Frequency,
cast(count(1)*100.0/(select count(1) from risk_scope) as decimal(5,2)) as Percentage
from risk_scope
group by Risk_category_30_Days
order by Percentage desc
```
Analysis of individual applications based on the credit enquiries

```sql
with default_scope as
(select target, isnull(cast(DEF_30_CNT_SOCIAL_CIRCLE*100.0/NULLIF(OBS_30_CNT_SOCIAL_CIRCLE,0) as decimal(5,2)),0) as Percentage
from application_train)
,risk_scope as
(select target,
case when Percentage=100 then 'Very High Risk'
when Percentage between 75 and 99 then 'High Risk'
when Percentage between 50 and 74 then 'Moderate Risk'
when Percentage between 25 and 49 then 'Low Risk'
when Percentage <25 then 'Very Low Risk' end as Risk_category_30_Days
from default_scope)
select case when target = 0 then 'Never had Payment Difficulties'
else 'Had Payment Difficulties' end as Target
,Risk_category_30_Days
,count(1) as Frequency
,cast(count(1)*100.0/(select count(1) from risk_scope) as decimal(5,2)) as Percentage
from risk_scope
group by case when target = 0 then 'Never had Payment Difficulties'
else 'Had Payment Difficulties' end, Risk_category_30_Days
order by Target
```



- **Deeper Risk Analysis**: Conduct a deeper analysis of clients with payment difficulties and low-risk surroundings.
```sql
with default_scope as
(select target
,case when FLAG_MOBIL+FLAG_EMP_PHONE+FLAG_WORK_PHONE =3 then 'All Contacts Available'
when FLAG_MOBIL+FLAG_EMP_PHONE+FLAG_WORK_PHONE =2 then 'Two Contacts Available'
when FLAG_MOBIL+FLAG_EMP_PHONE+FLAG_WORK_PHONE =1 then '1 Contact Available'
else 'No Contact Available' end as contacts_provided
, isnull(cast(DEF_30_CNT_SOCIAL_CIRCLE*100.0/NULLIF(OBS_30_CNT_SOCIAL_CIRCLE,0) as decimal(5,2)),0) as Percentage
from application_train)
,risk_scope as
(select target,contacts_provided,
case when Percentage=100 then 'Very High Risk'
when Percentage between 75 and 99 then 'High Risk'
when Percentage between 50 and 74 then 'Moderate Risk'
when Percentage between 25 and 49 then 'Low Risk'
when Percentage <25 then 'Very Low Risk' end as Risk_category_30_Days
from default_scope)
,risk_based_on_contact_reach as
(select case when target = 0 then 'Never had Payment Difficulties'
else 'Had Payment Difficulties' end as Target
,contacts_provided
,Risk_category_30_Days
,count(1) as Frequency
,cast(count(1)*100.0/(select count(1) from risk_scope) as decimal(5,2)) as Percentage
from risk_scope
group by case when target = 0 then 'Never had Payment Difficulties'
else 'Had Payment Difficulties' end, Risk_category_30_Days,contacts_provided)
select Target,contacts_provided,
Risk_category_30_Days,
Frequency,
cast(Frequency*100.0/sum(frequency)over() as decimal(5,2)) as Percentage
from risk_based_on_contact_reach
where Target = 'Had Payment Difficulties' and Risk_category_30_Days = 'Very Low Risk'
order by Percentage desc
```
![image](https://github.com/user-attachments/assets/029e1339-36e1-44a0-86fc-bad3c2f0a55e)

- **Integration of Previous Application Data**: Integrate insights from previous loan application data.
```sql
with default_scope as
(select target
,case when REG_REGION_NOT_LIVE_REGION = 1 then 'Address Mismatch' else 'Address Match' end as Address_city_match
,case when FLAG_MOBIL+FLAG_EMP_PHONE+FLAG_WORK_PHONE =3 then 'All Contacts Available'
when FLAG_MOBIL+FLAG_EMP_PHONE+FLAG_WORK_PHONE =2 then 'Two Contacts Available'
when FLAG_MOBIL+FLAG_EMP_PHONE+FLAG_WORK_PHONE =1 then '1 Contact Available'
else 'No Contact Available' end as contacts_provided
, isnull(cast(DEF_30_CNT_SOCIAL_CIRCLE*100.0/NULLIF(OBS_30_CNT_SOCIAL_CIRCLE,0) as decimal(5,2)),0) as Percentage
from application_train)
,risk_scope as
(select target,contacts_provided,Address_city_match,
case when Percentage=100 then 'Very High Risk'
when Percentage between 75 and 99 then 'High Risk'
when Percentage between 50 and 74 then 'Moderate Risk'
when Percentage between 25 and 49 then 'Low Risk'
when Percentage <25 then 'Very Low Risk' end as Risk_category_30_Days
from default_scope)
,risk_based_on_contact_reach as
(select case when target = 0 then 'Never had Payment Difficulties'
else 'Had Payment Difficulties' end as Target
,Address_city_match
,contacts_provided
,Risk_category_30_Days
,count(1) as Frequency
,cast(count(1)*100.0/(select count(1) from risk_scope) as decimal(5,2)) as Percentage
from risk_scope
group by case when target = 0 then 'Never had Payment Difficulties'
else 'Had Payment Difficulties' end, Risk_category_30_Days,contacts_provided,Address_city_match)
select Target,contacts_provided,
Address_city_match,
Risk_category_30_Days,
Frequency,
cast(Frequency*100.0/sum(frequency)over() as decimal(5,2)) as Percentage
from risk_based_on_contact_reach
where Target = 'Had Payment Difficulties' and Risk_category_30_Days = 'Very Low Risk'
order by Percentage desc
```
![image](https://github.com/user-attachments/assets/c30825fd-b99c-4252-bf61-c686113a308f)
