select * -----count(*)
from [portfolio project]..hoteldataset
WHERE [Destination Country] = 'New zealand'

DELETE FROM hoteldataset
WHERE [Booking ID] IS NULL;



select [Date of Booking],
YEAR( [Date of Booking]) As year,
MONTH( [Date of Booking]) as month
from [portfolio project]..hoteldataset



ALTER TABLE hoteldataset
ADD year nvarchar(255);


Update hoteldataset
SET year =YEAR( [Date of Booking]) 



ALTER TABLE hoteldataset
ADD month nvarchar(255);


Update hoteldataset
SET month =MONTH( [Date of Booking])




Select month,
	case when month ='1' Then 'January'
			when month ='2' Then 'February'
			when month ='3' Then 'March'
			when month ='4' Then 'April'
			when month ='5' Then 'May'
			when month ='6' Then 'June'
			when month ='7' Then 'July'
			when month ='8' Then 'August'
			when month ='9' Then 'september'
			when month ='10' Then 'October'
			when month ='11' Then 'November'
			when month ='12' Then 'December'
			ELSE month
			END
from hoteldataset

Update hoteldataset
SET month = case when month ='1' Then 'January'
			when month ='2' Then 'February'
			when month ='3' Then 'March'
			when month ='4' Then 'April'
			when month ='5' Then 'May'
			when month ='6' Then 'June'
			when month ='7' Then 'July'
			when month ='8' Then 'August'
			when month ='9' Then 'september'
			when month ='10' Then 'October'
			when month ='11' Then 'November'
			when month ='12' Then 'December'
			ELSE month
			END




---------Analyzing Booking pattern Across different Month


Select month,COUNT(*) AS 'Booking count'
from [portfolio project]..hoteldataset
group by month
order by 2 desc






-----------assign seasons to each booking date
select 
    [Date of Booking],
    CASE 
        WHEN MONTH([Date of Booking]) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH([Date of Booking]) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH([Date of Booking]) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH([Date of Booking]) IN (9, 10, 11) THEN 'Autumn'
        ELSE NULL
    END AS Season
FROM
   [portfolio project]..hoteldataset

ALTER TABLE hoteldataset
ADD Season nvarchar(255);

Update hoteldataset
SET Season =   CASE 
        WHEN MONTH([Date of Booking]) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH([Date of Booking]) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH([Date of Booking]) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH([Date of Booking]) IN (9, 10, 11) THEN 'Autumn'
        ELSE NULL
    END 

---------Analyzing booking pattern by Destination Country and season 
select [Destination Country],season,count(*) AS 'Booking count'
from [portfolio project]..hoteldataset
group by [Destination Country],season
order by [Destination Country],season



---------Exporing the distribution of booking by age group, gender,origon counry/state
SELECT
    CASE
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        WHEN Age >= 65 THEN '65+'
        ELSE 'Unknown'
    END AS AgeGroup,
   ---Gender,
    ---[Origin Country],
   ----State,
    COUNT(*) AS BookingCount
FROM
   [portfolio project]..hoteldataset
GROUP BY
    CASE
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        WHEN Age >= 65 THEN '65+'
        ELSE 'Unknown'
    END--,
    ---Gender,
    ---[Origin Country],
    -----State
ORDER BY
    AgeGroup------, Gender, [Origin Country],State;



---------Investigate if there are any correlations between demographics and preferred room type or destination countries

SELECT
    CASE
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        WHEN Age >= 65 THEN '65+'
        ELSE 'Unknown'
    END AS AgeGroup,
    Gender,
    [Origin Country],
    State,Rooms,[Destination Country],
    COUNT(*) AS BookingCount
FROM
   [portfolio project]..hoteldataset
GROUP BY
    CASE
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        WHEN Age >= 65 THEN '65+'
        ELSE 'Unknown'
    END,
    Gender,
    [Origin Country],
    State,Rooms,[Destination Country]
ORDER BY
    AgeGroup, Gender, [Origin Country],State,Rooms,[Destination Country]

----------Payment method used by customer 
select [Payment Mode],count(*) AS 'Booking count'
from [portfolio project]..hoteldataset
group  by [Payment Mode]
order by  'Booking count' desc




---------------
Select [Payment Mode],sum([Booking Price(SGD)]),sum(GST), COUNT(*)
from [portfolio project]..hoteldataset
GROUP BY [Payment Mode]
order by [Payment Mode]



Select [Hotel Rating], count(*) AS 'Booking count'
from [portfolio project]..hoteldataset
group by [Hotel Rating]
order by 'Booking count' desc




Select [Hotel Rating],[Origin Country],count(*) AS 'Booking count'
from [portfolio project]..hoteldataset
group by [Hotel Rating],[Origin Country]
order by [Hotel Rating],[Origin Country]




-- Analyze the number of room occupants per booking and its correlation with room type, origin, and destination
Select Rooms,[Origin Country],[Destination Country],AVG([No# Of People]) As AVGOCCUPANT, COUNT(*) AS 'Booking Count'
from [portfolio project]..hoteldataset
group by  Rooms,[Origin Country],[Destination Country]
order by  Rooms,[Origin Country],[Destination Country]



-------To determine if there are trend in number of occupant based on time of the year
select Year,SUM([No# Of People]) AS 'Total occupant',COUNT(*) 'Booking count'
from [portfolio project]..hoteldataset
group by Year
order by year



----------To know the country of destination with most booking 
select max([Destination Country]) AS 'most visit destination country'
from [portfolio project]..hoteldataset


----------Total Revenue
select SUM([Booking Price(SGD)]) as 'Total revenue'
from [portfolio project]..hoteldataset

-------------------
-----------Most book hotel
select [Hotel Name],count(*) as 'Booking count'
from [portfolio project]..hoteldataset
group by [Hotel Name]
order by  'Booking count' desc

--------To get No of days 
select DATEDIFF(day,[Check-in date],[Check-Out Date])
from [portfolio project]..hoteldataset

-------To update No of Days
Update [portfolio project]..hoteldataset
SET [No of Days] = DATEDIFF(day,[Check-in date],[Check-Out Date])


-----------AVERAGE NUMBER OF DAYS SPENT BY CUSTOMER 
select AVG(cast([No of Days]as int)) AS 'Avg of days'
from [portfolio project]..hoteldataset



select SUM([profit Margin]) as profit 
from [portfolio project]..hoteldataset



-----------Top 10 hoterl with highest revenue 
select top(10) [Hotel Name],SUM([Booking Price(SGD)]) As Revenue 
from [portfolio project]..hoteldataset
group BY [Hotel Name]
order by  Revenue desc



---------INSIGHTS
------Grand Hyatt Hotel has the most booking and highest revenue generated
--------Payment Mode the customer used most is internet banking 
---------Average number of days spent by customer is 3
------------Age group 25-34 are the customer with most booking 
