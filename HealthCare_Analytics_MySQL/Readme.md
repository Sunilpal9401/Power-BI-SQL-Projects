


##Cleaning the Appointments Table Data##
```sql
select *, datepart(year,appointmentdate)Appointment_Year,
datename(month, appointmentdate)Appointment_Month,
datepart(day, appointmentdate)Appointment_Day,
CONVERT(date, appointmentdate)Appointment_time
from Appointments
```

Cleaning the Billing Table Data
```sql
select *,datepart(year, billingdate)Billing_year,
datepart(month, billingdate)Billing_Month,
datename(weekday, billingdate)Billing_Day
from Billing
```

Cleaning the Doctors Table Data
```sql
select *,
concat(firstname, ' ', lastname)Doctors_FullName
from Doctors
```

Cleaning the HospitalStaff Table Data
```sql

select *,
concat(firstname, ' ', lastname)Staffs_FullName
from HospitalStaff
```

Cleaning the MedicalRecords Table Data
```sql
select *,
datepart(year, recorddate)Record_Year,
datename(month, recorddate)Record_Month,
datename(Weekday, recorddate)Record_Day,
convert(time, recorddate)Record_Time
from MedicalRecords
```

Cleaning the Patients Table Data

```sql
select *,
substring(address,1,CHARINDEX(',', address)-1)Patients_City,
substring(address,CHARINDEX(',', address), len(address) -CHARINDEX(',', address)+1)Patients_State,
concat(firstname, ' ' , lastname)Patients_FullName
from Patients

```
---Exploratory Data Analysis
--Retrieve data from one or more tables.
---Select All Columns from a Table
SELECT * FROM Patients;

---Select Specific Columns from a Table
SELECT FirstName, LastName  FROM Doctors;

--Sorts the result set in ascending or descending order.
SELECT * FROM Patients ORDER BY LastName ASC;

--Groups rows that have the same values in specified columns into summary rows.
--Question: Count the number of patients by gender.
SELECT Gender, COUNT(*) AS NumberOfPatients
FROM Patients
GROUP BY Gender;

--Getting total, average, maximum and minimum of bills
SELECT SUM(Amount) AS TotalBilling FROM Billing;
SELECT Avg(Amount) AS AvgBilling FROM Billing;
SELECT Max(Amount) AS HighestBilling FROM Billing;
SELECT Min(Amount) AS LowestBilling FROM Billing;

--Performing Data Analysis questions

--1.Question: Retrieve patients who have never had an appointment. names for all appointments.
SELECT P.FirstName, P.LastName
FROM Patients P
left JOIN Appointments A ON P.PatientID = A.PatientID
WHERE A.AppointmentDate IS NULL;

--2.Question: Retrieve patients' names along with their doctors' names for all appointments.
SELECT P.FirstName AS PatientFirstName, P.LastName AS PatientLastName, D.FirstName AS DoctorFirstName, D.LastName AS DoctorLastName
FROM Appointments A
INNER JOIN Patients P ON A.PatientID = P.PatientID
INNER JOIN Doctors D ON A.DoctorID = D.DoctorID;

--3.Question: Retrieve names from both the Doctors and Patients tables.
SELECT FirstName, LastName, concat(FirstName, ' ', LastName)FullName FROM Doctors
UNION
SELECT FirstName, LastName, concat(FirstName, ' ', LastName)FullName FROM Patients;


--4.Question: Retrieve doctors and the number of patients they have seen.
WITH PatientCounts AS (
    SELECT DoctorID, COUNT(*) AS NumberOfPatients
    FROM Appointments
    GROUP BY DoctorID
)
SELECT Concat(D.FirstName,' ',D.LastName) as DoctorName, P.NumberOfPatients
FROM Doctors D
JOIN PatientCounts P ON D.DoctorID = P.DoctorID;

--5.Question: Retrieve doctors who have more than 10 appointments.
SELECT DoctorID, COUNT(*) AS AppointmentCount
FROM Appointments
GROUP BY DoctorID
HAVING COUNT(*) > 10;

--6.Question: Assign row numbers to billing records ordered by amount.
SELECT Amount,
ROW_NUMBER() OVER (ORDER BY Amount DESC) AS RowNum,
Rank() OVER (ORDER BY Amount DESC) AS Rank,
Dense_Rank ()  OVER (ORDER BY Amount DESC) AS DenseRank
FROM Billing;

--7.Retrieve patients with pending appointments.
SELECT P.FirstName, P.LastName , concat(P.FirstName, ' ' , P.LastName)Patients_FullName
FROM Patients P
WHERE EXISTS (SELECT 1 FROM Appointments A WHERE A.PatientID = P.PatientID AND A.Status = 'Pending');

--8.Question: List all patients' names and their contact numbers.
SELECT FirstName, LastName,concat(FirstName, ' ' , LastName)Patients_fullName, ContactNumber
FROM Patients;

--9.Question: Retrieve the details of Active patients who had appointments scheduled in the last 7 days.
SELECT P.PatientID, P.FirstName, P.LastName, P.DOB, P.Gender, P.ContactNumber, P.Address
FROM Patients P
INNER JOIN Appointments A ON P.PatientID = A.PatientID
WHERE P.Status = 'Active' and AppointmentDate >= DATEADD(DAY, -7, GETDATE());

--10.Question: List all doctors along with their specialties.
SELECT FirstName, LastName, Specialty
FROM Doctors;

--11.Question: Retrieve the details of doctors who have more than 1 appointments in the current month.
SELECT D.FirstName, D.LastName, COUNT(A.AppointmentID) AS AppointmentCount
FROM Doctors D
JOIN Appointments A ON D.DoctorID = A.DoctorID
WHERE MONTH(A.AppointmentDate) = MONTH(GETDATE())
  AND YEAR(A.AppointmentDate) = YEAR(GETDATE())
GROUP BY D.FirstName, D.LastName
HAVING COUNT(A.AppointmentID) > 1;

--12.Question: List the appointments that are still pending (status 'Pending').
SELECT *
FROM Appointments
WHERE Status = 'Pending';

--13.Question: Find the most common diagnosis given by doctors.
SELECT Diagnosis, COUNT(*) AS Frequency
FROM MedicalRecords
GROUP BY Diagnosis
ORDER BY Frequency DESC

--14.Question: Find the total billing amount for the current month.
SELECT SUM(Amount) AS TotalBilling
FROM Billing
WHERE MONTH(BillingDate) = MONTH(GETDATE())
  AND YEAR(BillingDate) = YEAR(GETDATE());

 --15.Question: Find the number of staff members in each department.
SELECT Dept.DepartmentName, COUNT(*) AS StaffCount
FROM HospitalStaff HS
JOIN Departments Dept ON HS.DepartmentID = Dept.DepartmentID
GROUP BY Dept.DepartmentName;

--16.Question: Find the number of male and female Active patients.
SELECT Gender, COUNT(*) AS NumberOfPatients
FROM Patients
Where Status = 'Active'
GROUP BY Gender;

--17.Question: Retrieve the details of ACTIVE patients who have appointments scheduled in the next 7 days.
SELECT P.FirstName, P.LastName, A.AppointmentDate
FROM Patients P
JOIN Appointments A ON P.PatientID = A.PatientID
WHERE P.Status = 'Active' AND A.AppointmentDate BETWEEN GETDATE() AND DATEADD(DAY, 7, GETDATE());

--18.Question: Find the number of doctors in each specialty.
SELECT Specialty, COUNT(*) AS NumberOfDoctors
FROM Doctors
GROUP BY Specialty;

--19.Question: Find the total number of appointments scheduled in the current year.
SELECT COUNT(*) AS TotalAppointments
FROM Appointments
WHERE YEAR(AppointmentDate) = YEAR(GETDATE());

--20.Question: Retrieve the details of appointments along with patient and doctor names.
SELECT A.AppointmentID, P.FirstName AS PatientFirstName, P.LastName AS PatientLastName,
       D.FirstName AS DoctorFirstName, D.LastName AS DoctorLastName, A.AppointmentDate
FROM Appointments A
JOIN Patients P ON A.PatientID = P.PatientID
JOIN Doctors D ON A.DoctorID = D.DoctorID;

--21.Question: Find the medications that have been prescribed the most.
SELECT Medication, COUNT(*) AS PrescriptionCount
FROM Prescriptions
GROUP BY Medication
ORDER BY PrescriptionCount DESC;

--22.Question: Retrieve the details of unpaid bills.
SELECT *
FROM Billing
WHERE PaymentStatus = 'Pending';

--23.Question: List the top 3 doctors with the highest number of appointments.
WITH DoctorAppointments AS (
    SELECT DoctorID, COUNT(*) AS NumberOfAppointments
    FROM Appointments
    GROUP BY DoctorID
)
    SELECT TOP 3 DA.DoctorID,Concat(FirstName,' ',LastName) AS DoctorName, DA.NumberOfAppointments
    FROM DoctorAppointments DA
    INNER JOIN Doctors D ON DA.DoctorID = D.DoctorID
    ORDER BY DA.NumberOfAppointments DESC
