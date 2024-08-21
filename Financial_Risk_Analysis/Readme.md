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
