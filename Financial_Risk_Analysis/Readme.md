# Financial Risk Analysis Project
## Description:
This repository contains a comprehensive analysis of loan risk factors in the banking sector using two datasets: `application_train.csv` and `previous_application.csv`. The project aims to provide insights into customer demographics, credit types, risk assessment, and business strategies.
### Part 1: Understanding the Bank
- **Total Records**: Determine the total number of records in the 'application_train' table.
```sql
select count(1) as Number_of_records from application_train;
```
- **Credit Types**: Analyze the different types of credits offered by the bank.
```sql
select name_contract_type,cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as percentage 
from application_train
group by NAME_CONTRACT_TYPE;
```

- **Gender Distribution**: Explore the gender distribution of loan applicants.
```sql
select CODE_GENDER,cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as percentage 
from application_train
group by CODE_GENDER;
```
- **Gender-wise Credit Distribution**: Analyze the distribution of credits based on gender.
```sql
select name_contract_type,code_gender,count(1) as volume,
cast(count(name_contract_type)*100.0/sum(count(name_contract_type))over(partition by name_contract_type) as decimal(4,2)) as percentage
from application_train
group by name_contract_type,CODE_GENDER
```

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

- **Basic Income Type Distribution**: Investigate the distribution of income types among applicants.
```sql
select name_income_type
,count(1) as volume
,cast(count(1)*100.0/sum(count(1))over() as decimal(4,2))as percentage
from application_train
group by NAME_INCOME_TYPE
order by percentage desc
```
- **Basic Housing Type Distribution**: Explore the distribution of housing types among applicants.
```sql
select NAME_HOUSING_TYPE
,count(1) as volume
,cast(count(1)*100.0/sum(count(1))over() as decimal(4,2))as percentage
from application_train
group by NAME_HOUSING_TYPE
```

- **Basic Occupation Distribution**: Analyze the distribution of occupations among applicants.
```sql
select OCCUPATION_TYPE
,cast(count(1)*100.0/sum(count(1))over() as decimal(4,2))as percentage
from application_train
group by OCCUPATION_TYPE
order by percentage desc
```

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
