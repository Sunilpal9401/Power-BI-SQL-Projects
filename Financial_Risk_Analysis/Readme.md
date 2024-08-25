# Financial Risk Analysis Project

![RiskAnalysis-ezgif com-optimize](https://github.com/user-attachments/assets/6f548b41-0152-4fdf-b1f5-64be4070825f)



# Project overview vide

https://github.com/user-attachments/assets/1d3882cd-78d8-436f-8e3c-6566394efeb0



## Description:
This repository contains a comprehensive analysis of loan risk factors in the banking sector using two datasets: `application_train.csv` and `previous_application.csv`. The project aims to provide insights into customer demographics, credit types, risk assessment, and business strategies.
### Part 1: Understanding the Bank
- **Total Records**: Determine the total number of records in the 'application_train' table.
```sql
select count(1) as Number_of_records from application_train;
```
![1](https://github.com/user-attachments/assets/d1070982-a4ce-47d5-a2a7-d0f201d9d4e5)

`Insight from Query : The table has more than 3 lakh records of customer credit application data`

- **Credit Types**: Analyze the different types of credits offered by the bank.
```sql
select name_contract_type,cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as percentage 
from application_train
group by NAME_CONTRACT_TYPE;
```
![2](https://github.com/user-attachments/assets/adc247dd-ffed-41cb-af77-075b4b863d8d)
`90% of the loans are Cash Loans while around 10% are Revolving Loans.
 There are 2 kinds of credits namely revolving loans and cash loans. Cash loans are credits given upfront with periodical repayments(car loan),
while revolving loans are loans based on usage having a credit limit like Credit Cards. The company seems to pitch more cash loans. Usually these
 structured and secured loans. One can infer that the company is conservative in giving loans since the earning is usually higher in Revolving Loans. 
 This however depends on the risk appetite of a bank,competition of other banks,sales strategy, training of employees,the legal regulations, economy and credit worthiness of the customer base. 
 `


- **Gender Distribution**: Explore the gender distribution of loan applicants.
```sql
select CODE_GENDER,cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as percentage 
from application_train
group by CODE_GENDER;
```
![3](https://github.com/user-attachments/assets/98f1d6a2-007e-4563-bb85-815c3d8dc1ee)

`65% of the customers are female,34% are males and rest are others.`
`This bank has a larger female customer base! Few reasons why this could be the case is that `
`- Demographic conditions in the region- More working females, Higher financial literacy & education,risk taking appetite`
`- Marketing Strategy - The bank might be targeting more females. One reason could be that the bank has better & loyal female customers.` 
                       `Fraud rate may be lesser in this gender. `
`- Social Image & Initiatives - The bank could be promoting women empowerment. `
`- Government Benefits - The bank might be receiving Government Benefits for having a higher female customer base. `
`- Geographical Conditions - The region where the bank operates might have more females`

- **Gender-wise Credit Distribution**: Analyze the distribution of credits based on gender.
```sql
select name_contract_type,code_gender,count(1) as volume,
cast(count(name_contract_type)*100.0/sum(count(name_contract_type))over(partition by name_contract_type) as decimal(4,2)) as percentage
from application_train
group by name_contract_type,CODE_GENDER
```
![4](https://github.com/user-attachments/assets/5c7bb4f0-3eff-4885-beee-b6ad88b4f6ca)

`The Loans are divided at a 2/3 ratio with females on the higher side. This means that the strategy of the bank is same across both the product offerings
in terms of the gender. 
`


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

`The average income of clients is equal in both the loan segments.
While the Median income is lower in the Revolving Loans type. One reason could be that cash loans require security 
and a higher income level eligibility criteria. 
The Min income in both the loans average around 26000. The Maximum income is much higher incase of cash loans.
With higher credit, banks require higher security.
The Median Income and max income in case of Cash Loans show a huge gap. This gap can be furter analysed by categorizing customers into income_level_flags`

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
`The Average Credit in Cash Loans is twice the Revolving Loan credits, while the Average & Minimum income is similar.
This supports the bank's conservative approach of dealing credits. The Minimum Credit however is much higher for Revolving Loans.
But the Median Credit is half of Cash Loans. 
Also, the bank gives 5 times the income as a revolving loan to the person with lowest income. 
This also supports the bank's risk free approach since clients with less assets can avail the loans. The bank pushes for
secured loans.`


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
`Usually the credit is higher than the goods amount for which the loan is taken. The reasons why it could be so are  `
`- The Loan might cover additional charges`
`- The borrower might have a discretion to use the money acc to their needs`
`- The borrower might be paying off previous dues with a new loan`

`Overall, the bank does not allow a significant gap between the goods being purchased and the loan amount.`



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
`Most of the bank's clients are the Working Class(~52%) & Commercial Associate(23%), followed by Pensioners(18%)
and then State Servants(7%). The bank rarely provides loan to Businessmen, Students and women on Maternity Leave.
This is a vital indicator and confirms that the bank is conservative in nature. 
It also signifies that less Education Loans are being Given. `


- **Basic Housing Type Distribution**: Explore the distribution of housing types among applicants.
```sql
select NAME_HOUSING_TYPE
,count(1) as volume
,cast(count(1)*100.0/sum(count(1))over() as decimal(4,2))as percentage
from application_train
group by NAME_HOUSING_TYPE
```
![8](https://github.com/user-attachments/assets/aa90e367-2525-4985-a812-40598804bed2)
`
88% of the clients have their own House/Apartment. This accounts for the high Cash Loans.`



- **Basic Occupation Distribution**: Analyze the distribution of occupations among applicants.
```sql
select OCCUPATION_TYPE
,cast(count(1)*100.0/sum(count(1))over() as decimal(4,2))as percentage
from application_train
group by OCCUPATION_TYPE
order by percentage desc
```
![9](https://github.com/user-attachments/assets/db3ee1c8-b18d-4242-ad4a-d322ef785473)

`The highest share of 31% of the Occupation type is Null or Unknown. It could happen in cases where the
client has not disclosed their occupation. Incomplete records could be a reason. 
On the plus side, there is wide diversity in the bank's client occupation. It caters to both high-level and
lower-income-level clients.`




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

`The Region & City Ratings are given by the Bank and it seems that 73% of the client are having 2 as the region rating.`
`Only 10% of the clients are from Rank1 Regions. This could be due to many reasons like`
`- Competition from other banks`
`- Less Population in Highly Developed Regions`
`- Bank's presence might be low in those regions(Distance,Online Reach)`
`- Pitching to those regions might need more educated/experienced employees(a direct cost to the bank)`


### Part 2: Understanding the Client Base & Business Operations
- **Family Status**: Analyze the family status of the bank's clients.
```sqlselect NAME_FAMILY_STATUS
,count(1) as volume
,cast(count(1)*100.0/sum(count(1))over() as decimal(4,2))as percentage
from application_train
group by NAME_FAMILY_STATUS
order by percentage desc
```
![1](https://github.com/user-attachments/assets/42189d6f-bc3a-45f6-b2da-869bf3c13d33)

`Around 63% of the Bank's clients are/were married. `
`-This could mean that the bank targets a higher age group.`
`-The people who are Single may be sourcing money from other sources for needs - Parents, Relatives, Friends`
`-They may be a customer of another bank`
`-It shows that banking literacy is higher amongst Married people. Additional responsibilities lead to higher need of credit.`


- **Housing Distribution**: Explore the distribution of housing types among clients.
```sql
select NAME_HOUSING_TYPE
,count(1) as volume
,cast(count(1)*100.0/sum(count(1))over() as decimal(4,2))as percentage
from application_train
group by NAME_HOUSING_TYPE
order by percentage desc
```
![2](https://github.com/user-attachments/assets/ba8c1782-815c-4998-b9b9-adb699cf4fe0)

`88% of the clients have their own House/Apartment. This accounts for the high Cash Loans.`

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
![3](https://github.com/user-attachments/assets/14a17953-00bb-4572-bb4a-d17c4eaee94e)

`37% of the clients are between the age 26 amd 55. 20% of the clients are above 55. 
Only 4% of the clients are below 25. Like iterated earlier, the need for credit comes with more responsibilities.
Few people who get really successful early in their career, tend to avail credit options to accelerate their growth.
Also, very few clients are Students. `



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
![4](https://github.com/user-attachments/assets/01df03ef-e0cb-4319-ac6c-a947477c6485)

`Around 62% of the Clients have provided 2 Contacts, and 19% have given either 1 or all contacts.
There is no client without any contact. The documentation seems clearly executed. `


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
![5](https://github.com/user-attachments/assets/e3e125bb-3708-485a-b717-dc5cf4aace5c)

`In Terms of Documents, Upto 4 Documents were procured at max(100%). These documents vary from loan to loan. 
This could be a good sign in the sense that the bank takes less documentation before providing credit.
A point to check would be that all the necessary information is collected. While less paperwork and online documentation
is a plus point, the bank should ensure that no information is missed. Occupation details are clearly not part of this 
check(Again it depends on the loan type). Would be a plus if most of it is digitised.`


- **Loan Application Day Analysis**: Investigate the distribution of loan applications over days.
```sql
select WEEKDAY_APPR_PROCESS_START,
cast(count(1)*100.0/(select count(1) from application_train) as decimal(4,2)) as Percentage
from application_train
group by WEEKDAY_APPR_PROCESS_START
order by Percentage desc
```

![6](https://github.com/user-attachments/assets/c6d7d538-6b76-4565-96e9-ae5bea92868a)

`More clients prefer applying for credit on weekdays(17% across all weekdays).
Few Clients(11%) applied for credit on Saturdays. The banks are usually closed on each alternative Saturday.
It could also indicate that the clients are not using online channels(Need to analyze the sales channel). 
It could also indicate that the clients are busy with their household chores, family time, leisure,etc.`

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
`43% of Loan Applications come from clients having 0 or 1 cibil checks & 16% from clients having 2 cibil checks. This is a decent sign that the client does not seem to be risky. This could be further analyzed by looking at their cibil reports for 2 years. 
20% of clients have more than 2 enquiries in 1 year. This is further analyzed below by looking at their quarterly and monthly enquiries.
13.5% values are null which i assume are the clients having no credit history/taking credit for the 1st time. This depends on multiple factors like the bank's strategy, legal implications, client relationship(might be a customer having deposits),etc.
Past behavior of clients in that geographical locations need to be checked in order to know if this is risky sign or not. Macro changes in economy(drop in interest rates,Increase in taxes,etc) could also affect this factor.
`
`While there were around 23% clients having 1 enquiry in 1 year, 20% clients having 0 enquries in 1 year, and 20% clients having more than 2 enquries in 1 year, 
70% of clients among the applicants had 0 enquries in the last 3 months. The same 13.5% clients have no history, 11% clients have 1 and 4.5% clients have 2 quarterly enquiries.
`

`Out of the above mentioned enquiry situations, the monthly enquiry is on the safer side as well. 72% clients have 0 enquiry, 13.5% have no credit history,
10% have 1 enquiry and 1.75% have 2 enquiries.
`

`83% clients have no enquiries within a week of their application. 2.67% have 1 enquiry. `

`Around 86% of the clients have no enquiries made on the same day.13.5% clients have no history.`

`Around 86% of the clients have no enquiries made on the same hour.13.5% clients have no history.`












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

![basic avg](https://github.com/user-attachments/assets/f5dc48af-8105-4cc6-9f85-c38eb947d5e0)


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
![image](https://github.com/user-attachments/assets/3788886f-de7d-4d91-88bc-fe394e0ab372)



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
![image](https://github.com/user-attachments/assets/d6703813-647d-4a45-8ea7-8324010bd5b3)



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
![image](https://github.com/user-attachments/assets/a86aed0e-7a9f-49a1-ae7a-dc72d6986536)



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
![image](https://github.com/user-attachments/assets/b19bf762-2d05-4c0e-989d-d1a1b676214c)



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
![image](https://github.com/user-attachments/assets/49bfd8ea-68f5-4d6a-8ba4-96d83f96f1c4)


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
![image](https://github.com/user-attachments/assets/5c6ae940-fa02-40da-b049-5a1fd72b63b5)

