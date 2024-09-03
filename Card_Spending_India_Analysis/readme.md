# Project Goal : 
Card spend analysis using SQL involves examining transaction data from credit or debit card records to gain insights into spending patterns, trends, and anomalies in India.
The Dataset was Extracted from Kaggle : 

## Understanding the Data

Before we start writing SQL queries, it's essential to understand the structure of our data. Typically, our card transaction data is stored in tables with the following columns:

`transaction_id` : Unique identifier for each transaction.

`city` : Geographical location of the transaction.

`transaction_date` : Date time of the transaction done.

`card_type` : Type of card through which the transaction has been done by the user.

`exp_type` : On what type of expenses are done from card.

`gender` : Male or Female who has done the transaction, "M" denotes Male and "F" denotes Female.

`amount` : Amount spent in the transaction by the user.


## Raw_Data

![image](https://github.com/user-attachments/assets/ba6ca02a-7525-4c63-8508-112685cdd029)



## Cleaning_data :
- Removed/renamed columns as per need.
- Fixed Date coloumn as it showing general format to Date format
- Converted date format to the standard form.
- Did data standardization
- Checked for Null/missing values
- Checked for duplicates
- Checked Query Execution Plan
- Did Query Optimization
- Created index on required coloums so that queries run faster.


## Cleaned_Data
![1](https://github.com/user-attachments/assets/276d3473-8f96-4e50-8ddf-00e28c204c81)



### By leveraging these SQL techniques, we'll gain valuable insights into card spending patterns and make data-driven decisions based on our analysis specific to the Indian market.



## Here is the Analysis we did :


Write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 

```sql
with cte1 as (
select city,sum(amount) as total_spend
from credit_card_transcations
group by city)
,total_spent as (select sum(cast(amount as bigint)) as total_amount from credit_card_transcations)
select top 5 cte1.*, round(total_spend*1.0/total_amount * 100,2) as percentage_contribution from 
cte1 inner join total_spent on 1=1
order by total_spend desc
```
![image](https://github.com/user-attachments/assets/adaa943c-a026-4119-997a-c209bbbfba29)

write a query to print highest spend month and amount spent in that month for each card type

```sql
with cte as (
select card_type,datepart(year,transaction_date) yt
,datepart(month,transaction_date) mt,sum(amount) as total_spend
from credit_card_transcations
group by card_type,datepart(year,transaction_date),datepart(month,transaction_date)
)
select * from (select *, rank() over(partition by card_type order by total_spend desc) as rn
from cte) a where rn=1
```

![image](https://github.com/user-attachments/assets/64487a47-0983-48a5-835c-37d2adab952e)

write a query to print the transaction details(all columns from the table) for each card type when
it reaches a cumulative of  1,000,000 total spends(We should have 4 rows in the o/p one for each card type)

```sql
with cte as (
select *,sum(amount) over(partition by card_type order by transaction_date,transaction_id) as total_spend
from credit_card_transcations
)
select * from (select *, rank() over(partition by card_type order by total_spend) as rn  
from cte where total_spend >= 1000000) a where rn=1
```
![image](https://github.com/user-attachments/assets/b34dda97-f038-42ac-b09a-7ef5161a515a)

write a query to find city which had lowest percentage spend for gold card type

```sql
with cte as (
select top 1 city,card_type,sum(amount) as amount
,sum(case when card_type='Gold' then amount end) as gold_amount
from credit_card_transcations
group by city,card_type)
select 
city,sum(gold_amount)*1.0/sum(amount) as gold_ratio
from cte
group by city
having count(gold_amount) > 0 and sum(gold_amount)>0
order by gold_ratio;
```
![image](https://github.com/user-attachments/assets/afe1337e-0989-4fbb-8bd2-871fd38a27c0)


write a query to retrieve highest and lowest expense type per city
```sql
with cte as (
select city,exp_type, sum(amount) as total_amount from credit_card_transcations
group by city,exp_type)
select
city , max(case when rn_asc=1 then exp_type end) as lowest_exp_type
, min(case when rn_desc=1 then exp_type end) as highest_exp_type
from
(select *
,rank() over(partition by city order by total_amount desc) rn_desc
,rank() over(partition by city order by total_amount asc) rn_asc
from cte) A
group by city;
```
![image](https://github.com/user-attachments/assets/91461f4c-7c10-4355-b92b-ceafd89f0093)

write a query to find percentage contribution of spends by females for each expense type
```sql
select exp_type,
sum(case when gender='F' then amount else 0 end)*1.0/sum(amount) as percentage_female_contribution
from credit_card_transcations
group by exp_type
order by percentage_female_contribution desc;
```
![image](https://github.com/user-attachments/assets/5ba0294e-0026-4ed3-ac69-c327334e46eb)

which card and expense type combination saw highest month over month growth in Jan-2014
```sql
with cte as (
select card_type,exp_type,datepart(year,transaction_date) yt
,datepart(month,transaction_date) mt,sum(amount) as total_spend
from credit_card_transcations
group by card_type,exp_type,datepart(year,transaction_date),datepart(month,transaction_date)
)
select  top 1 *, (total_spend-prev_mont_spend) as mom_growth
from (
select *
,lag(total_spend,1) over(partition by card_type,exp_type order by yt,mt) as prev_mont_spend
from cte) A
where prev_mont_spend is not null and yt=2014 and mt=1
order by mom_growth desc;
```
![image](https://github.com/user-attachments/assets/ea57ae37-d6a1-4612-9980-a67bce86d2c5)

during weekends which city has highest total spend to total no of transcations ratio 

```sql
select top 1 city , sum(amount)*1.0/count(1) as ratio
from credit_card_transcations
where datepart(weekday,transaction_date) in (1,7)
group by city
order by ratio desc;
```
![image](https://github.com/user-attachments/assets/38f57dd7-628f-4b47-9ac0-7d6dd9b715d6)

which city took least number of days to reach its 500th transaction after the first transaction in that city

```sql
with cte as (
select *
,row_number() over(partition by city order by transaction_date,transaction_id) as rn
from credit_card_transcations)
select top 1 city,datediff(day,min(transaction_date),max(transaction_date)) as datediff1
from cte
where rn=1 or rn=500
group by city
having count(1)=2
order by datediff1 
```

![image](https://github.com/user-attachments/assets/6ac6df09-b0e7-435c-9d18-f97971a450f8)

















