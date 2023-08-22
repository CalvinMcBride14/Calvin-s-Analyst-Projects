Goals of the Analysis are as follows:

1. Toys sales in terms of units sold and revenue per product, and also determining which products perform best.
2. Revenue, Cost and Profit per product and also which product performs best.
3. Revenue, Cost and Profit per store location.
4. Revenue, Cost and Profit per toy category.
5. Overall revenue, cost, profit and profit percentage.
6. Overall revenue, cost, profit and profit percentage split in years and months.
7. Current inventory volume and value.
   
Mexico toys company is a fictitious company and data are provided by Maven Analytics. The Dataset will be found using the following link: https://app.mavenanalytics.io/datasets?search=mexi (Need an account on Maven Analytics)

   
/* Perform Data Cleaning */
--------------------------

/* Convert Date columns to the appropriate data type. */

ALTER table sales
   modify date DATE;
   
ALTER table stores
   modify store_open_date DATE;
   
----------------------------------------------------------------------------------------------------------------------------------------------------
/* Product_cost and product_price columns contain '$' remove this special character from all rows. */ 

 UPDATE  products
   SET product_cost = REPLACE(product_cost,'$',' ');
   
   UPDATE  products
   SET product_price = REPLACE(product_price,'$',' ');
   
   
 ----------------------------------------------------------------------------------------------------------------------------------------------------  
   /* Now convert these colunns into a decimal data type. */
   
   ALTER TABLE products
   MODIFY product_price DECIMAL(10,2);
   
   ALTER TABLE products
   MODIFY product_cost DECIMAL(10,2);
   
   
----------------------------------------------------------------------------------------------------------------------------------------------------
/* Check for any duplicate records in the dataset. */ 

SELECT 
      product_ID,
      COUNT(product_ID) AS ID_appearance
FROM products
GROUP BY product_ID
HAVING ID_appearance > 1;


----------------------------------------------------------------------------------------------------------------------------------------------------
/* Check for any NULL values in the dataset. */

SELECT  * 
FROM sales
WHERE (sale_ID OR date OR store_ID OR product_ID OR units) IS NULL;


/* Perfrom Data Exploration */
------------------------------

/* Find the MIN, MAX, & AVG for stock, sales price, and cost. */ 

SELECT 
     MAX(stock_on_hand) AS highest_stock,
     MIN(stock_on_hand) AS lowest_stock,
     AVG(Stock_on_hand) AS average_stock
FROM inventory;

SELECT 
     MAX(product_price) AS highest_sale_price,
     MIN(product_price) AS lowest_sale_price,
     AVG(product_Price) AS average__sale_price
FROM products;

SELECT 
     MAX(product_cost) AS highest_product_cost,
     MIN(product_cost) AS lowest_product_cost,
     AVG(product_cost) AS average__product_cost
FROM products;


----------------------------------------------------------------------------------------------------------------------------------------------------
/* Find the Sales Units per products for the top five products. */

SELECT
     s.product_ID AS prod_ID,
     p.product_name AS name,
     SUM(s.units) AS units_sold
FROM sales s
     INNER JOIN products p
     ON s.product_ID = p.product_ID
GROUP BY s.product_ID, p.product_name
ORDER BY units_sold DESC LIMIT 5;


----------------------------------------------------------------------------------------------------------------------------------------------------
/* Find the Revenue per product for the top five products. */
SELECT
     s.product_ID AS product_ID,
     p.product_name AS name,
     p.product_price,
     SUM(s.units) AS units_sold,
     p.product_price * SUM(s.units) AS revenue_per_product
FROM sales s
     INNER JOIN products p
     ON s.product_ID = p.product_ID
GROUP BY s.Product_ID, p.product_name, p.product_price
ORDER BY revenue_per_product DESC LIMIT 5;


----------------------------------------------------------------------------------------------------------------------------------------------------
/* Find how much money Mexico Toys spends on their products. */ 

SELECT
     s.product_ID AS product_ID,
     p.product_name AS name,
     p.product_cost,
     SUM(s.units) AS units_sold,
     p.product_cost * SUM(s.units) AS cost_per_product
FROM sales s
     INNER JOIN products p
     ON s.product_ID = p.product_ID
GROUP BY s.product_ID, p.product_name, p.product_cost
ORDER BY cost_per_product DESC;


----------------------------------------------------------------------------------------------------------------------------------------------------
/* Determine how each product performs by calculating profit and profit percentage per product. */

SELECT
     s.product_ID AS product_ID,
     p.product_name AS name,
     p.product_cost,
     p.product_price,
     SUM(s.units) AS units_sold,
     SUM(s.units) * p.product_Cost AS cost_per_product,
     p.product_price * SUM(s.units) AS revenue_per_product,
     p.product_price * SUM(s.units) - p.product_cost * SUM(s.units) AS profit,
     ROUND(((p.product_price * SUM(s.units) - p.product_Cost * SUM(s.units)) / (p.product_price * SUM(s.units))) *100,2) AS profit_percentage
FROM sales s
     INNER JOIN products p
     ON s.product_ID = p.product_ID
GROUP BY s.product_ID, p.product_name, p.product_cost, p.product_price
ORDER BY profit_percentage DESC;


----------------------------------------------------------------------------------------------------------------------------------------------------
/* Find the total cost, total revenue, total profit and profit percentage per type of location to see how the store location can affect strategy. */

SELECT
     store_location,
     SUM(revenue_per_product) AS revenue,
     SUM(cost_per_product) AS costs,
     SUM(revenue_per_product) - SUM(cost_per_product) AS profit,
     (SUM(revenue_per_product) - SUM(cost_per_product)) / SUM(revenue_per_product) AS profit_percentage
FROM
     (SELECT
         st.store_location,
         s.product_ID AS product_ID,
         d.product_name AS name,
         d.product_price,
         d.product_cost,
         SUM(s.units) AS units_sold,
         d.product_price * SUM(s.units) AS revenue_per_product,
         SUM(s.units) * d.product_Cost  AS cost_per_product
     FROM sales s
         INNER JOIN products d
         ON s.product_ID = d.product_ID
         INNER JOIN stores st
         ON st.store_ID = s.store_ID
         GROUP BY st.store_location, s.product_ID, d.product_name, d.product_price, d.product_cost
         ) AS revenue_and_costs
GROUP BY store_location
ORDER BY profit_percentage DESC;



----------------------------------------------------------------------------------------------------------------------------------------------------
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
          Year(s.date) AS year,
          d.product_category,
          s.product_ID AS product_ID,
          d.product_name AS name,
          d.product_price,
          d.product_cost,
          SUM(s.units) AS Units_sold,
          d.product_price * SUM(s.units) AS revenue_per_product,
          SUM(s.units) * d.product_Cost  AS cost_per_product
     FROM sales s
          INNER JOIN products d
          ON s.product_ID = d.product_ID
     GROUP BY Year(s.Date), d.product_category, s.product_ID, d.product_name, d.product_price, d.product_cost
     ) AS revenue_and_costs
GROUP BY year;


----------------------------------------------------------------------------------------------------------------------------------------------------
/* Determine the total cost, total revenue, total profit and profit percentage per year. */ 

SELECT
     year,
     SUM(revenue_per_product) AS revenue_per_year,
     SUM(cost_per_product) AS costs_per_year,
     SUM(revenue_per_product) - SUM(cost_per_product) AS profit,
     (SUM(revenue_per_product) - SUM(cost_per_product)) / SUM(revenue_per_product) AS profit_percentage
FROM
    (SELECT 
        YEAR(s.date) AS year,
        s.product_ID AS product_ID,
        d.product_name AS name,
        d.product_price,
        d.product_cost,
        SUM(s.units) AS units_sold,
        d.product_price * SUM(s.units) AS revenue_per_product,
        SUM(s.units) * d.product_Cost  AS cost_per_product
    FROM sales s 
         INNER JOIN products d ON s.product_ID = d.product_ID
    GROUP BY YEAR(s.date), s.product_ID, d.product_name, d.product_price, d.product_cost 
    ) AS revenue_and_costs
GROUP BY year;


----------------------------------------------------------------------------------------------------------------------------------------------------
/* Find the total inventory cost. */

SELECT
      SUM(inventory_cost_per_product) AS inv_cost
FROM
      (SELECT
         i.product_ID,
         p.product_name,
         p.product_cost,
         SUM(i.stock_on_hand),
         SUM(i.stock_on_hand) * p.product_cost AS inventory_cost_per_product
     FROM inventory i
         LEFT JOIN products p
         USING(product_ID)
     GROUP BY i.product_ID, p.product_name, p.product_cost
     ORDER BY inventory_cost_per_product DESC
     ) AS inv_cost;
