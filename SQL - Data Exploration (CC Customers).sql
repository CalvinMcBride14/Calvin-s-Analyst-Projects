Goals of the Analysis are as follows:

1. Age ranges for customers that were attrited.
2. Compare the number of customers who either attrited or remained, who used a dependent.
3. Compare the education status for both attrited and existing customers.
4. Compare the card category count for both attrited and existing customers.
5. Gender counts for both attrited and existing customers.
6. Months on book range for both attrited and existing customers. 

Dataset found on Kaggle.com

    
/* Perform Data Exploration */
-----------------------------


/* Find the Distibution of customers who were lost(attrited) by age. */

SELECT 
CASE WHEN customer_age < 20 THEN '0-20' WHEN customer_age BETWEEN 20 and 30 THEN '20-30'
WHEN customer_age BETWEEN 30 and 40 THEN '30-40' WHEN customer_age BETWEEN 40 AND 50 THEN '40-50'
WHEN customer_age BETWEEN 50 and 60 THEN '50-60' WHEN customer_age BETWEEN 60 AND 70 THEN '60-70'
WHEN customer_age BETWEEN 70 and 80 THEN '70-80' WHEN customer_age > 80 THEN 'Above 80' END AS Age_Range, Count(*) AS Cust_num
FROM 
banking_database.cc_customers
WHERE	
attrition_flag = 'attrited customer' 
GROUP BY age_range 
ORDER BY age_range;

----------------------------------------------------------------------------------------------------------------------------------------------------

/* Find the number(count) of both "attrited and exitising" customers who used a dependent */

SELECT dependent_count, count(*) AS total_existing
FROM 
banking_database.cc_customers
WHERE 
attrition_flag = 'existing customer'
GROUP BY dependent_count
ORDER BY dependent_count
;

SELECT dependent_count, count(*) AS total_attrited
FROM 
banking_database.cc_customers
WHERE 
attrition_flag = 'attrited customer'
GROUP BY dependent_count
ORDER BY dependent_count
;


----------------------------------------------------------------------------------------------------------------------------------------------------

/* Find the Education Level count for both "attrited" and "exitising" customers */

SELECT education_level, count(*) AS existing_customer_count
FROM 
banking_database.cc_customers
WHERE 
attrition_flag = 'existing customer'
GROUP BY education_level
ORDER BY education_level
;

SELECT education_level, count(*) AS attrited_customer_count
FROM 
banking_database.cc_customers
WHERE 
attrition_flag = 'attrited customer'
GROUP BY education_level
ORDER BY education_level
;

----------------------------------------------------------------------------------------------------------------------------------------------------

/* Find the count for each Card Categoties used by both "existing" and "attrited" customers. */

SELECT card_category, count(*) AS attrited_cardcat_count
FROM 
banking_database.cc_customers
WHERE 
attrition_flag = 'attrited customer'
GROUP BY card_category
ORDER BY card_category
;

SELECT card_category, count(*) AS existing_cardcat_count
FROM 
banking_database.cc_customers
WHERE 
attrition_flag = 'existing customer'
GROUP BY card_category
ORDER BY card_category
;

----------------------------------------------------------------------------------------------------------------------------------------------------

/* Find the number of male and female "exisiting" and "attrited" customers */

SELECT 
    SUM(IF(gender = 'M', 1, 'null')) AS male_exisiting_customer,
    SUM(IF(gender = 'F', 1, 'null')) AS female_existing_customer
FROM 
banking_database.cc_customers
WHERE attrition_flag = 'existing customer'
;

SELECT 
    SUM(IF(gender = 'M', 1, 'null')) AS male_attrited_customer,
    SUM(IF(gender = 'F', 1, 'null')) AS female_attrited_customer
FROM 
banking_database.cc_customers
WHERE attrition_flag = 'attrited customer'
;

----------------------------------------------------------------------------------------------------------------------------------------------------

/* Find the month on book (number of months that have completed since the loan origination date) range for both "existing" and "attrited" customers. */

SELECT CASE WHEN months_on_book < 20 THEN '0-20' WHEN months_on_book BETWEEN 20 and 30 THEN '20-30'
WHEN months_on_book BETWEEN 30 and 40 THEN '30-40' WHEN months_on_book BETWEEN 40 and 50 THEN '40-50'
WHEN months_on_book BETWEEN 50 and 60 THEN '50-60' WHEN months_on_book > 60 THEN 'Above 60' END AS months_on_book_range, count(*) AS existing_customer_count
FROM
banking_database.cc_customers
WHERE
attrition_flag = 'existing customer'
GROUP BY months_on_book_range
ORDER BY months_on_book_range
;


SELECT CASE WHEN months_on_book < 20 THEN '0-20' WHEN months_on_book BETWEEN 20 and 30 THEN '20-30'
WHEN months_on_book BETWEEN 30 AND 40 THEN '30-40' WHEN months_on_book BETWEEN 40 and 50 THEN '40-50'
WHEN months_on_book BETWEEN 50 AND 60 THEN '50-60' WHEN months_on_book > 60 THEN 'Above 60' END AS months_on_book_range, count(*) AS attrited_customer_count
FROM
banking_database.cc_customers
WHERE
attrition_flag = 'attrited customer'
GROUP BY months_on_book_range
ORDER BY months_on_book_range
;

