SELECT * FROM retail_sales_analysis.sales_analysis;

use retail_sales_analysis;

create table  retail_sales (
transactions_id	int primary key,
sale_date date,
sale_time time,
customer_id	int,
gender varchar(10),
age	int,
category varchar(35), 
quantiy	int,
price_per_unit	float,
cogs float,
total_sale float
);


/* Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05 */

select *
from retail_sales
where sale_date like '2022-11-05' ;


 /*Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is
 more than 4 in the month of Nov-2022' */
 
select *
from retail_sales
where 
category ='Clothing'
and
quantiy>=4
and 
DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
 
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale)
from retail_sales
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT category, ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM retail_sales
WHERE total_sale>1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category, count(transactions_id), gender
FROM retail_sales
group by category, gender
order by category;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT round(avg(total_sale),2), YEAR(sale_date) AS sale_year, MONTH(sale_date) AS sale_month
FROM retail_sales
group by sale_year, sale_month
order by sale_year, sale_month

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 


SELECT sum(total_sale), customer_id 
FROM retail_sales
group by customer_id
order by customer_id
limit 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

 
SELECT count(distinct customer_id),category
FROM retail_sales
group by category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT 
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_sale
FROM retail_sales
GROUP BY shift
ORDER BY FIELD(shift, 'Morning', 'Afternoon', 'Evening');
