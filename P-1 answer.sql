create database practice;
use practice;

select*from retail_sales
limit 10;

ALTER TABLE retail_sales
CHANGE COLUMN `ï»¿transactions_id` transactions_id INT;

ALTER TABLE retail_sales
CHANGE COLUMN `quantiy` quantity INT;
 
select count(*) from retail_sales;

-- how many customers we have--
select count(distinct customer_id) from retail_sales;
-- how many category we have--
select count(distinct category) from retail_sales;

-- how many category type we have--
select distinct category from retail_sales;

-- reteive all columns for sale made on 2022-11-05--
select * from retail_sales
where sale_date = "2022-11-05" ;

select count(*) from retail_sales
where sale_date = "2022-11-05";

-- retrive all transaction where the category is clothing and the quantity sold is more than 10 in the month of november-2022--
select category, sum(quantity)
from retail_sales
group by category;

SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
  AND sale_date LIKE '2022-11%' 
  AND quantity >= 4;

-- calculate total sale for all category --
SELECT category, 
       SUM(total_sale) AS net_sale, 
       COUNT(*) AS total_order
FROM retail_sales
GROUP BY category
ORDER BY net_sale DESC;

-- FIND THE CUSTOMER AVG CUSTOMER WHO PURCHASED ITEM FROM BEAUTY--
select 
round(avg(age),2)
from retail_sales
where category="Beauty";

-- find all transaction where the total sale is greater than 1000--
select * from retail_sales
where total_sale > 1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.--
select category, gender, count(*) as total_transaction
from retail_sales 
group by category, gender
order by category; 

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rnk
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS ranked_months
WHERE rnk = 1
ORDER BY year;


-- Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as unique_customer
FROM retail_sales
GROUP BY category;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

----------------------------------------------
-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
with hourly as(
select*,
 case 
  when HOUR(sale_time) < 12 then "Morning"
  when HOUR(sale_time) between 12 and 17 then "Afternoon"
  else "evening"
  end as shift
  from retail_sales
)
select shift,
count(*) as total_orsers
from hourly
group by shift;




