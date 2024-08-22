#Hotel_Analytics


##Project Goal:
To analyze a dataset of a hotel's operations using SQL queries to gain insights into customer behavior, revenue performance, and overall business trends.

Key Objectives:

- Data Exploration: Understand the structure, content, and relationships within the dataset.
- Query Development: Write SQL queries to extract relevant information and answer specific business questions.
- Data Analysis: Analyze the results to identify patterns, trends, and insights.

###Bussiness quries 

- Find the guest who has made the most bookings.
```sql
WITH GuestBookings AS (
    SELECT Guests.guest_id,
        CONCAT(Guests.first_name, ' ', Guests.last_name) AS full_name,
        COUNT(Bookings.booking_id) AS booking_count
    FROM Guests INNER JOIN Bookings ON
        Guests.guest_id = Bookings.guest_id
    GROUP BY
        Guests.guest_id,
        Guests.first_name,
        Guests.last_name
),
RankedGuests AS (
    SELECT guest_id,full_name,booking_count,
        rank() OVER (ORDER BY booking_count DESC) AS rank FROM GuestBookings)
SELECT guest_id,full_name,booking_count FROM RankedGuests
WHERE rank = 1;
```
![1](https://github.com/user-attachments/assets/d986a346-cb4d-420c-9564-c66c9050347f)

- List the guests who have bookings from 25-June to 1 -July.
```sql
SELECT DISTINCT B.Guest_id,
 CONCAT(first_name, ' ', last_name) AS Guest_Name
FROM Guests G
INNER JOIN Bookings b ON G.guest_id = B.guest_id
WHERE check_in_date BETWEEN '2024-05-25' AND '2024-06-01';
```
![image](https://github.com/user-attachments/assets/54c3b902-5422-4883-8912-2ff9cbd52847)

- Find the total revenue generated from all bookings.
  ```sql
  SELECT
    SUM(
          --As Some people check out on same day
            CASE WHEN DATEDIFF(day, check_in_date, check_out_date) = 0  THEN 1
            ELSE DATEDIFF(day, check_in_date, check_out_date)
            END * amount
    ) AS total_revenue FROM
    Bookings;
```
-total_revenue
-41400.00



- Find the average stay duration of guests.
```sql
WITH Stay AS (
    SELECT
        CASE
            WHEN DATEDIFF(day, check_in_date, check_out_date) = 0
            THEN 1
            ELSE DATEDIFF(day, check_in_date, check_out_date)
        END AS stay_duration
    FROM
        Bookings
)
SELECT
    FORMAT(AVG(stay_duration * 1.0), 'N2') AS average_stay_duration
FROM
    Stay;
```
![image](https://github.com/user-attachments/assets/57b145de-f029-4e5c-9d82-5c56d136bbec)

- Find the guest who booked/Get the same room multiple times.
  ```sql
  SELECT  
    CONCAT(g.first_name, ' ', g.last_name) AS full_name,
    b.guest_id,
    b.room_number,
    COUNT(*) AS booking_count FROM  Bookings b INNER JOIN Guests g ON b.guest_id = g.guest_id
  GROUP BY
  g.first_name, g.last_name, b.guest_id, b.room_number
  HAVING COUNT(*) > 1;
```

-There are no such guests.

- List the top 2 guests by total amount spent.
```sql
SELECT TOP 2
    G.guest_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    SUM(CASE
            WHEN DATEDIFF(day, check_in_date, check_out_date) = 0
            THEN 1
            ELSE DATEDIFF(day, check_in_date, check_out_date)
            END * Amount) AS total_amount_spent
FROM Guests G
INNER JOIN Bookings b ON G.guest_id = b.guest_id
GROUP BY G.guest_id, G.first_name, G.last_name
ORDER BY total_amount_spent DESC;
```
![image](https://github.com/user-attachments/assets/29efe0c6-2fed-4413-8052-d49bc9d6f512)

- Find the average total amount spent by guests who stayed more than 3 days.
  ```sql
  WITH LongStays AS (
    SELECT
    guest_id,
    CASE
        WHEN DATEDIFF(day, check_in_date, check_out_date) = 0 THEN 1
        ELSE DATEDIFF(day, check_in_date, check_out_date)
        END AS stay_duration,
        amount
    FROM Bookings
  )
  SELECT
    avg(stay_duration* Amount) AS total_amount_spent
    FROM LongStays
    WHERE stay_duration > 3;
    ```
    ![image](https://github.com/user-attachments/assets/97903fd7-539d-43ae-adfd-50e04b3ecdba)

    - List all guests along with their total stay duration and amount across all bookings
    ```sql
    WITH LongStays AS
    (
   SELECT
   a.guest_id,
   CONCAT(first_name, ' ', last_name) AS full_name,
   CASE
   WHEN DATEDIFF(day, check_in_date, check_out_date) = 0 THEN 1
   ELSE DATEDIFF(day, check_in_date, check_out_date)
   END AS stay_duration,
   amount
   FROM Bookings a
   INNER JOIN Guests b on a.guest_id = b.guest_id
    )
    SELECT
    guest_id,
    full_name,
    Sum(stay_duration) AS TotalStayDays,
    Sum((stay_duration* Amount)) AS total_amount_spent
    FROM LongStays
	group by guest_id, full_name
	order by TotalStayDays desc, total_amount_spent desc, guest_id desc
 ```
guest_id	full_name	TotalStayDays	total_amount_spent
   10	   Sunil Chopra	5	     5               6000.00
   9	Kavita Joshi	5	     5               6000.00
   8	Amit Verma	5	     5               6000.00
   7	Vikas Reddy	5	     5               6000.00
   5	Rahul Patel	5	     5               5000.00
   3	Anil Mehta	5	     5               5000.00
   2	Sita Sharma	5	     5               4500.00
   6	Priya Nair	1	     1               1000.00
   4	Pooja Singh	1	     1               1000.00
   1	Ravi Kumar	1	     1               900.00

-Find the city from where the most guests have stayed
```sql
SELECT TOP 1
    G.city,
    COUNT(G.guest_id) AS guest_count
FROM  Guests G
INNER JOIN Bookings B
ON G.guest_id = B.guest_id
GROUP BY G.city
ORDER BY guest_count DESC;
```
![image](https://github.com/user-attachments/assets/afae73d4-44c0-4292-83da-2ee0e563db79)










