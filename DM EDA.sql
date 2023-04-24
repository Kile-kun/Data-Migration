USE dm_db;
/*EXPLORATORY DATA ANALYSIS*/

/*DATA FREQUENCY DISTRIBUTION*/
/*Geography Distribution of Customers*/
USE dm_db;
SELECT 
    g.Country, COUNT(g.Country) AS NoOfCustomers
FROM
    geography g
INNER JOIN
	transaction t
    ON g.GeoId = t.GeoId
INNER JOIN 
	customer c
    ON t.CustomerId = c.CustomerId
GROUP BY g.Country
ORDER BY NoOfCustomers;

/*Gender Distribution of Customers*/
USE dm_db;
SELECT 
    Gender, COUNT(Gender) AS NoOfCustomers
FROM
    customer
GROUP BY Gender
ORDER BY NoOfCustomers;

/*Age Distribution of Customers*/
USE dm_db;
SELECT 
    Age, COUNT(Age) AS NoOfCustomers
FROM
    customer
GROUP BY Age
ORDER BY Age;

/*Group Age of Customers Into Clusters*/
SELECT
CASE
  WHEN Age BETWEEN 10 AND 19 THEN 'Teenages'
  WHEN Age BETWEEN 20 AND 29 THEN '20s'
  WHEN Age BETWEEN 30 AND 39 THEN '30s'
  WHEN Age BETWEEN 40 AND 49 THEN '40s'
  WHEN Age BETWEEN 50 AND 59 THEN '50s'
  WHEN Age BETWEEN 60 AND 69 THEN '60s'
  ELSE '70+'
END AS AgeGrp,
COUNT(*) NoOfCust
FROM customer
GROUP BY AgeGrp
ORDER BY AgeGrp * 1, AgeGrp DESC;

/*Customers Year of Patronage Distribution*/
SELECT 
    Tenure, COUNT(Tenure) AS NoOfCustomers
FROM
    customer
GROUP BY Tenure
ORDER BY Tenure;

/*Product Purchase Distribution*/
SELECT 
    t.NumOfProducts, COUNT(t.NumOfProducts) AS NoOfCustomers
FROM
transaction t
INNER JOIN 
    customer c
    ON t.CustomerId = c.CustomerId
GROUP BY NumOfProducts
ORDER BY NoOfCustomers;

/*Customers Credit Card Ownership Distribution*/
SELECT 
    CASE HasCrCard
        WHEN '1' THEN 'Yes'
        ELSE 'No'
    END AS HasCrCard,
    COUNT(HasCrCard) AS NoOfCustomers
FROM
    customer
GROUP BY HasCrCard;

/*Customers Patronage Activeness Distribution*/
SELECT CASE IsActiveMember
           WHEN '1' THEN 'Active' 
           ELSE 'Inactive' 
       END AS IsActiveMember,
		COUNT(IsActiveMember) AS NoOfCustomers
FROM customer
GROUP BY IsActiveMember;

/*CREDIT SCORE ANALYSIS*/

/*Average Credit Score Per Country*/
SELECT 
    g.Country, AVG(c.CreditScore) AS AvgCrdScore
FROM
    geography g
        INNER JOIN
    transaction t ON g.GeoId = t.GeoId
        INNER JOIN
    customer c ON t.CustomerId = c.CustomerId
GROUP BY g.Country
ORDER BY AvgCrdScore;

/*Average Credit Score Per Country Per Ages*/
SELECT 
    c.Age,
    AVG(CASE
        WHEN g.Country LIKE '%France%' THEN c.CreditScore
        ELSE NULL
    END) AS France,
    AVG(CASE
        WHEN g.Country LIKE '%Germany%' THEN c.CreditScore
        ELSE NULL
    END) AS Germany,
    AVG(CASE
        WHEN g.Country LIKE '%Spain%' THEN c.CreditScore
        ELSE NULL
    END) AS Spain,
    AVG(c.CreditScore) AS AvgCrdScore
FROM
    customer c
        INNER JOIN
    transaction t ON c.CustomerId = t.CustomerId
        INNER JOIN
    geography g ON t.GeoId = g.GeoId
GROUP BY c.Age
ORDER BY c.Age;
USE dm_db;

/*Average Credit Score Per Gender*/
SELECT 
    c.Age,
    AVG(CASE
        WHEN c.gender = "Female" THEN c.CreditScore
        ELSE NULL
    END) AS Female,
    AVG(CASE
        WHEN c.gender = "Male" THEN c.CreditScore
        ELSE NULL
    END) AS Male,
    AVG(c.CreditScore) AS AvgCrdScore
FROM
    customer c
GROUP BY c.Age
ORDER BY c.Age;

/*Average Credit Score Per Customer Tenure and Active Status*/
SELECT c.Tenure, 
AVG(CASE WHEN c.IsActiveMember LIKE '%0%' THEN c.CreditScore END) AS ActiveCustomer,
AVG(CASE WHEN c.IsActiveMember LIKE '%1%' THEN c.CreditScore END) AS InActiveCustomer
FROM customer c
GROUP BY c.Tenure
ORDER BY c.Tenure;

/*Credit Score Dependence on Customer Balance*/
SELECT (CASE 
	WHEN c.CreditScore BETWEEN 299 AND 400 THEN "300s"
    WHEN c.CreditScore BETWEEN 399 AND 500 THEN "400s"
    WHEN c.CreditScore BETWEEN 499 AND 600 THEN "500s"
    WHEN c.CreditScore BETWEEN 599 AND 700 THEN "600s"
    WHEN c.CreditScore BETWEEN 699 AND 800 THEN "700s"
    ELSE '800s' END) AS CrdScore,
   ROUND(AVG(t.Balance),2) AS AvgBalance
   FROM customer c
INNER JOIN transaction t
ON c.CustomerId = t.CustomerId
GROUP BY CrdScore
ORDER BY CrdScore;

/*Product Sales Analysis*/
/*Total Product Sales Per Country*/
SELECT g.Country, SUM(t.NumOfProducts) AS TotProdSales
FROM geography g
JOIN transaction t ON g.GeoId = t.GeoId
GROUP BY g.Country
ORDER BY g.Country;

/*Product Sales Vs Age and Gender*/
SELECT
CASE
  WHEN c.Age BETWEEN 10 AND 19 THEN 'Teenages'
  WHEN c.Age BETWEEN 20 AND 29 THEN '20s'
  WHEN c.Age BETWEEN 30 AND 39 THEN '30s'
  WHEN c.Age BETWEEN 40 AND 49 THEN '40s'
  WHEN c.Age BETWEEN 50 AND 59 THEN '50s'
  WHEN c.Age BETWEEN 60 AND 69 THEN '60s'
  ELSE '70+'
END AS AgeGrp,
SUM(t.NumofProducts) AS TotProdSales
FROM customer c
JOIN transaction t ON c.CustomerId = t.CustomerId
GROUP BY AgeGrp
ORDER BY AgeGrp * 1, AgeGrp DESC;

/*Average Credit Score Per Customer Tenure and Active Status*/
SELECT c.Gender, 
SUM(CASE WHEN c.IsActiveMember LIKE '%0%' THEN t.NumOfProducts END) AS ActiveCustomer,
SUM(CASE WHEN c.IsActiveMember LIKE '%1%' THEN t.NumOfProducts END) AS InActiveCustomer
FROM customer c
JOIN transaction t
ON c.CustomerId = t.CustomerId
GROUP BY c.Gender
ORDER BY c.Gender;

/*Top Product Sales Among Countries*/
SELECT g.Country, SUM(t.NumOfProducts) AS TotProdSales
FROM geography g 
INNER JOIN transaction t
ON g.GeoId = t.GeoId
GROUP BY g.Country
ORDER BY TotProdSales;

/*LOYALTY ANALYSIS*/
/*Customers whose has been transacting with the business for more than 3 years and have traded more than twice*/
CREATE VIEW LoyCust AS
SELECT c.Surname, c.Tenure, t.NumOfProducts, g.Country
FROM customer c
INNER JOIN transaction t ON c.CustomerId = t.CustomerId
INNER JOIN geography g ON t.GeoId = g.GeoId
WHERE c.Tenure > 3 AND t.NumOfProducts > 2;

ALTER VIEW loycust (Surname, Tenure, NumOfProducts, Country)
AS
SELECT Surname, Tenure, NumOfProducts, Country 
FROM customer c
INNER JOIN transaction t ON c.CustomerId = t.CustomerId
INNER JOIN geography g ON t.GeoId = g.GeoId
WHERE c.Tenure > 3 AND t.NumOfProducts > 2
ORDER BY NumOfProducts DESC;
SELECT * FROM loycust;
