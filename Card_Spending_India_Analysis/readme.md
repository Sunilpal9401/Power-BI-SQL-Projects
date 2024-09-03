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









