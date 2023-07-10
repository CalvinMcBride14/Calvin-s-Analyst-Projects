
/* Perform Data Cleaning */


/* Convert Date columns to the appropriate data type. */

ALTER table sales
   modify Date DATE;
   
ALTER table stores
   modify Store_Open_Date DATE;
   

/* Product_cost and product_price columns contain '$' remove this special character from all rows. */ 

 UPDATE  products
   SET Product_Cost = REPLACE(Product_Cost,'$',' ');
   
   UPDATE  products
   SET Product_Price = REPLACE(Product_Price,'$',' ');
   
   
   
   /* Now convert these colunns into a decimal data type. */
   
   ALTER TABLE products
   MODIFY Product_Price DECIMAL(10,2);
   
   ALTER TABLE products
   MODIFY Product_Cost DECIMAL(10,2);
   
   

/* Check for any duplicate records in the dataset. */ 

SELECT 
      product_ID,
      COUNT(product_ID) AS ID_appearance
FROM products
GROUP BY product_ID
HAVING ID_appearance > 1;



/* Check for any NULL values in the dataset. */

SELECT  * 
FROM sales
WHERE (Sale_ID OR Date OR Store_ID OR Product_ID OR Units) IS NULL;

--------------------------------------------------------------------------------------------
/* Perfrom Data Exploration */


/* Find the MIN, MAX, & AVG for stock, highest, sales price. */ 

SELECT 
     MAX(Stock_On_Hand) AS Highest_stock,
     MIN(Stock_On_Hand) AS Lowest_stock,
     AVG(Stock_On_Hand) AS Average_stock
FROM inventory;

SELECT 
     MAX(Product_Price) AS Highest_sale_price,
     MIN(Product_Price) AS Lowest_sale_price,
     AVG(Product_Price) AS Average__sale_price
FROM products;

SELECT 
     MAX(Product_Cost) AS Highest_Product_Cost,
     MIN(Product_Cost) AS Lowest_Product_Cost,
     AVG(Product_Cost) AS Average__Product_Cost
FROM products;



/* Find the Sales Units per products for the first five products. */

SELECT
     s.Product_ID AS product_ID,
     p.Product_Name AS name,
     SUM(s.units) AS Units_sold
FROM sales s
     INNER JOIN products p
     ON s.product_ID = p.product_ID
GROUP BY s.Product_ID, p.Product_Name
ORDER BY Units_sold DESC  LIMIT 5;



/* Find the Revenue per product for the first five products. */
SELECT
     s.Product_ID AS product_ID,
     p.Product_Name AS name,
     p.Product_Price,
     SUM(s.units) AS Units_sold,
     p.Product_Price * SUM(s.units) AS revenue_per_product
FROM sales s
     INNER JOIN products p
     ON s.product_ID = p.product_ID
GROUP BY s.Product_ID, p.Product_Name, p.Product_Price
ORDER BY revenue_per_product DESC LIMIT 5;



/* Find how much money Mexico Toys spends on their products. */ 

SELECT
     s.Product_ID AS product_ID,
     p.Product_Name AS name,
     p.Product_Cost,
     SUM(s.units) AS Units_sold,
     p.Product_Cost * SUM(s.units) AS cost_per_product
FROM sales s
     INNER JOIN products p
     ON s.product_ID = p.product_ID
GROUP BY s.Product_ID, p.Product_Name, p.Product_Cost
ORDER BY cost_per_product DESC;



/* Determine how each product performs by calculating profit and profit percentage per product. */

SELECT
     s.Product_ID AS product_ID,
     p.Product_Name AS name,
     p.Product_Cost,
     p.product_price,
     SUM(s.units) AS Units_sold,
     SUM(s.units) * p.Product_Cost AS cost_per_product,
     p.Product_Price * SUM(s.units) AS revenue_per_product,
     p.Product_Price * SUM(s.units) - p.Product_Cost * SUM(s.units) AS profit,
     ROUND(((p.Product_Price * SUM(s.units) - p.Product_Cost * SUM(s.units)) / (p.Product_Price * SUM(s.units))) *100,2) AS profit_percentage
FROM sales s
     INNER JOIN products p
     ON s.product_ID = p.product_ID
GROUP BY s.Product_ID, p.Product_Name, p.Product_Cost, p.product_price
ORDER BY profit_percentage DESC;



/* Find the total cost, total revenue, total profit and profit percentage per type of location to see how the store location can affect strategy. */

SELECT
     Store_Location,
     SUM(revenue_per_product) AS revenue,
     SUM(cost_per_product) AS costs,
     SUM(revenue_per_product) - SUM(cost_per_product) AS profit,
     (SUM(revenue_per_product) - SUM(cost_per_product)) / SUM(revenue_per_product) AS profit_percentage
FROM
     (SELECT
         st.Store_Location,
         s.Product_ID AS product_ID,
         d.Product_Name AS name,
         d.Product_Price,
         d.Product_Cost,
         SUM(s.units) AS Units_sold,
         d.Product_Price * SUM(s.units) AS revenue_per_product,
         SUM(s.units) * d.Product_Cost  AS cost_per_product
     FROM sales s
         INNER JOIN products d
         ON s.product_ID = d.product_ID
         INNER JOIN stores st
         ON st.Store_ID = s.Store_ID
         GROUP BY st.Store_Location, s.Product_ID, d.Product_Name, d.Product_Price, d.Product_Cost
         ) AS revenue_and_costs
GROUP BY Store_Location
ORDER BY profit_percentage DESC;




/* Find the total cost, total revenue, total profit and profit percentage per year and per category of toys. */ 

SELECT
     year,
     SUM(CASE WHEN Product_Category = 'Toys' THEN revenue_per_product ELSE NULL END) AS toys_revenue,
     SUM(CASE WHEN Product_Category = 'Art & Crafts' THEN revenue_per_product ELSE NULL END) AS Art_Crafts_revenue,
     SUM(CASE WHEN Product_Category = 'Games' THEN revenue_per_product ELSE NULL END) AS Games_revenue,
     SUM(CASE WHEN Product_Category = 'Electronics' THEN revenue_per_product ELSE NULL END) AS Electronics_revenue,
     SUM(CASE WHEN Product_Category = 'Sports & Outdoors' THEN revenue_per_product ELSE NULL END) AS Sports_Outdoors_revenue
FROM
     (SELECT
          Year(s.Date) AS year,
          d.Product_Category,
          s.Product_ID AS product_ID,
          d.Product_Name AS name,
          d.Product_Price,
          d.Product_Cost,
          SUM(s.units) AS Units_sold,
          d.Product_Price * SUM(s.units) AS revenue_per_product,
          SUM(s.units) * d.Product_Cost  AS cost_per_product
     FROM sales s
          INNER JOIN products d
          ON s.product_ID = d.product_ID
     GROUP BY Year(s.Date), d.Product_Category, s.Product_ID, d.Product_Name, d.Product_Price, d.Product_Cost
     ) AS revenue_and_costs
GROUP BY year;



/* Determine the total cost, total revenue, total profit and profit percentage per year. */ 

SELECT
     year,
     SUM(revenue_per_product) AS revenue_per_year,
     SUM(cost_per_product) AS costs_per_year,
     SUM(revenue_per_product) - SUM(cost_per_product) AS profit,
     (SUM(revenue_per_product) - SUM(cost_per_product)) / SUM(revenue_per_product) AS profit_percentage
FROM
    (SELECT 
        YEAR(s.Date) AS year,
        s.Product_ID AS product_ID,
        d.Product_Name AS name,
        d.Product_Price,
        d.Product_Cost,
        SUM(s.units) AS Units_sold,
        d.Product_Price * SUM(s.units) AS revenue_per_product,
        SUM(s.units) * d.Product_Cost  AS cost_per_product
    FROM sales s 
         INNER JOIN products d ON s.product_ID = d.product_ID
    GROUP BY YEAR(s.Date), s.Product_ID, d.Product_Name, d.Product_Price, d.Product_Cost 
    ) AS revenue_and_costs
GROUP BY year;



/* Find the total inventory cost. */

SELECT
      SUM(inventory_cost_per_product) AS inv_cost
FROM
      (SELECT
         i.Product_ID,
         p.Product_Name,
         p.Product_Cost,
         SUM(i.Stock_On_Hand),
         SUM(i.Stock_On_Hand) * p.Product_Cost AS inventory_cost_per_product
     FROM inventory i
         LEFT JOIN products p
         USING(Product_ID)
     GROUP BY i.Product_ID, p.Product_Name, p.Product_Cost
     ORDER BY inventory_cost_per_product DESC
     ) AS inv_cost;