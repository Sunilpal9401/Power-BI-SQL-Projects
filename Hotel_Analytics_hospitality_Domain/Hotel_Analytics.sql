--Question 1: Find the guest who has made the most bookings.
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

--Question 2 : List the guests who have bookings from 25-June to 1 -July.
SELECT DISTINCT B.Guest_id,
 CONCAT(first_name, ' ', last_name) AS Guest_Name
FROM Guests G
INNER JOIN Bookings b ON G.guest_id = B.guest_id
WHERE check_in_date BETWEEN '2024-05-25' AND '2024-06-01';

--Question 3 : Find the total revenue generated from all bookings.
SELECT
    SUM(
          --As Some people check out on same day
            CASE WHEN DATEDIFF(day, check_in_date, check_out_date) = 0  THEN 1
            ELSE DATEDIFF(day, check_in_date, check_out_date)
            END * amount
    ) AS total_revenue
FROM
    Bookings;

--Question 4 : Find the average stay duration of guests.

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

--Question 5 : Find the guest who booked/Get the same room multiple times.
SELECT  
    CONCAT(g.first_name, ' ', g.last_name) AS full_name,
    b.guest_id,
    b.room_number,
    COUNT(*) AS booking_count
FROM  Bookings b
INNER JOIN Guests g ON b.guest_id = g.guest_id
GROUP BY
g.first_name, g.last_name, b.guest_id, b.room_number
HAVING COUNT(*) > 1;

--Question 6 : List the top 2 guests by total amount spent.

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

--Question 7 : Find the average total amount spent by guests who stayed more than 3 days.
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

--Question 8 : List all guests along with their total stay duration and amount across all bookings
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

--Question 9 : find the city from where the most guests have stayed
SELECT TOP 1
    G.city,
    COUNT(G.guest_id) AS guest_count
FROM  Guests G
INNER JOIN Bookings B
ON G.guest_id = B.guest_id
GROUP BY G.city
ORDER BY guest_count DESC;