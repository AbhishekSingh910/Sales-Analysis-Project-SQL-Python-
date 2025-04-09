use portfolio_project1;
select * from orders_data;



select * from orders_data;

# List all distinct cities
select count(distinct city) from orders_data;
#531


# Find the average order value
select round(avg(total_sales),2) from orders_data;
#1108.6


#Find the city with the highest total quantity of products ordered
select city , sum(quantity)as total_quantity  from orders_data
group by city
order by total_quantity desc limit 1;
#New York City	3417

# Total sale in each region
select region , round(sum(total_sales),2) as sale from orders_data
group by region;
--  region   sale
-- South	1966053.6
-- West	3467409.6
-- Central	2387881.2
-- East	3257983.8

-- Calculate the total selling price and profits for all orders.
select `Order Id`, round(sum(Total_sales),2) AS `Total Selling Price`, 
round(SUM(quantity * unit_profit),2) as  `Total Profit`
from orders_data
group by `Order Id`
ORDER BY `Total Profit`desc;

-- Order Id	Total Selling Price		Total Profit
-- 2698		130406.4				21746.4
-- 6827		84875					14875
-- 9040		122141.5				12811.5
-- 4278		61789					8309
-- 166		62668.8					7868.8
-- 7667		46656					7776
-- 9640		53105					7215
-- 4298		53969.5					6779.5
-- 7244		38586.6					6726.6



-- Write a query to find all orders from the 'Technology' category 
-- that were shipped using 'Second Class' ship mode, ordered by order date.

SELECT `Order Id`, `Order Date`
FROM orders_data
WHERE Category = 'Technology'
  AND `Ship Mode` = 'Second Class'
ORDER BY `Order Date`;

-- OrderId	 Order Date
-- 5421		2022-01-01 00:00:00
-- 1088		2022-01-04 00:00:00
-- 3272		2022-01-05 00:00:00
-- 3527		2022-01-06 00:00:00
-- 9950		2022-01-07 00:00:00
-- 183		2022-01-10 00:00:00
-- 5941		2022-01-10 00:00:00
-- 20		2022-01-11 00:00:00




-- Use a window function to rank orders in each region by quantity in descending order.

SELECT 
  `Order Id`, 
  Region, 
  Quantity, 
  DENSE_RANK() OVER (PARTITION BY Region ORDER BY `Order Id` DESC) AS rnk
FROM orders_data
order by region,Quantity desc;

-- `Order Id` 	Region 	Quantity	rnk
-- 7388		Central		14			628
-- 9516		Central		14			111
-- 1046		Central		14			2072
-- 8075		Central		14			485
-- 661		Central		14			2156
-- 9040		Central		13			238
-- 9064		Central		13			237
-- 3243		Central		13			1586
-- 6159		Central		12			913
-- 1109		Central		12			2060


-- Write a SQL query to list all orders placed in the first quarter of any year (January to March), including the total cost for these orders.
-- select * from orders_data where [order id] = 137

select `Order Id` , `Order Date`, Total_sales
from orders_data
where Month in (1,2,3)
order by Total_sales desc;

-- `Order Id`     `Order Date`  			Total_sales
-- 9040			2023-02-25 00:00:00			122141.5
-- 4278			2023-01-03 00:00:00			61789
-- 4099			2023-02-27 00:00:00			46305
-- 8489			2023-02-22 00:00:00			42875
-- 7244			2022-02-27 00:00:00			38586.6
-- 6536			2023-02-08 00:00:00			38095
-- 684			2023-02-05 00:00:00			31360
-- 9057			2022-02-07 00:00:00			28243.6
-- 9661			2023-01-22 00:00:00			26092.8
-- 9271			2022-03-07 00:00:00			25084.199999999997


########################################################################################################3
-- Q1. find top 10 highest profit generating products 
SELECT `Product Id`, SUM(`Total Profit`) AS profit
FROM orders_data
GROUP BY `Product Id`
ORDER BY profit DESC
LIMIT 10;

-- `Product Id`			profit
-- TEC-CO-10004722		24816
-- TEC-MA-10002412		21746.40000000001
-- OFF-BI-10000545		17867.7
-- TEC-CO-10001449		15948
-- FUR-CH-10002024		13930.699999999997
-- OFF-BI-10003527		12792.899999999998
-- TEC-PH-10001459		11481.900000000001
-- TEC-MA-10000822		10102.300000000001
-- FUR-TA-10000198		10015.099999999999
-- TEC-MA-10001047		9989

# using Window function: 
WITH cte AS (
  SELECT 
    `Product Id`, 
    SUM(`Total Profit`) AS profit,
    DENSE_RANK() OVER (ORDER BY SUM(`Total Profit`) DESC) AS rn
  FROM orders_data
  GROUP BY `Product Id`
)
SELECT `Product Id`, profit
FROM cte
WHERE rn <= 10;


# find top 3 highest selling products in each region
with cte as 
(SELECT 
  `Product Id`,
  Region,
  DENSE_RANK() OVER (PARTITION BY Region ORDER BY Total_Sales DESC) AS rnk
FROM orders_data)
SELECT * 
FROM cte
WHERE rnk <= 3;

-- `Product Id`			Region 		rnk
-- OFF-BI-10000545		Central		1
-- TEC-CO-10004722		Central		2
-- TEC-MA-10000822		Central		3
-- TEC-MA-10001047		East		1
-- TEC-CO-10001449		East		2
-- TEC-CO-10004722		East		3
-- TEC-MA-10002412		South		1
-- TEC-PH-10001459		South		2
-- FUR-TA-10000198		South		3


-- Find month over month growth comparison for 2022 and 2023 sales eg : jan 2022 vs jan 2023
WITH cte AS (
  SELECT 
    SUM(Total_sales) AS sale, 
    Year, 
    Month 
  FROM orders_data
  GROUP BY Year, Month
)

SELECT 
  Month,
  ROUND(SUM(CASE WHEN Year = 2022 THEN sale ELSE 0 END), 1) AS sales_2022,
  ROUND(SUM(CASE WHEN Year = 2023 THEN sale ELSE 0 END), 1) AS sales_2023
FROM cte
GROUP BY Month
ORDER BY Month;

-- Month 	sales_2022 sales_2023
-- 1		437431.3	434765.5
-- 2		444011.1	731638.8
-- 3		394105.2	393051.9
-- 4		476400.9	543231.5
-- 5		413625.5	410707.9
-- 6		465300.3	328939
-- 7		375278.4	422533.7
-- 8		534562.4	465010.3
-- 9		433887		420620.5
-- 10		601707.8	626498.3
-- 11		451809.6	334940.6
-- 12		447421.8	491848.9



select * from orders_data;


-- now we can also calculate % of growth
WITH cte AS (
  SELECT 
    SUM(Total_sales) AS sale, 
    Year, 
    Month 
  FROM orders_data
  GROUP BY Year, Month
)

SELECT 
  Month,
  ROUND(SUM(CASE WHEN Year = 2022 THEN sale ELSE 0 END), 1) AS sales_2022,
  ROUND(SUM(CASE WHEN Year = 2023 THEN sale ELSE 0 END), 1) AS sales_2023,
  ROUND(
    (SUM(CASE WHEN Year = 2023 THEN sale ELSE 0 END) - SUM(CASE WHEN Year = 2022 THEN sale ELSE 0 END)) 
    / SUM(CASE WHEN Year = 2022 THEN sale ELSE 0 END)* 100, 
    2
  ) AS YoY_Growth_Percentage
FROM cte
GROUP BY Month
ORDER BY Month;

-- Month	sales_2022	sales_2023	YoY_Growth_Percentage
-- 1		437431.3	434765.5	-0.61
-- 2		444011.1	731638.8	64.78
-- 3		394105.2	393051.9	-0.27
-- 4		476400.9	543231.5	14.03
-- 5		413625.5	410707.9	-0.71
-- 6		465300.3	328939		-29.31
-- 7		375278.4	422533.7	12.59
-- 8		534562.4	465010.3	-13.01
-- 9		433887		420620.5	-3.06
-- 10		601707.8	626498.3	4.12
-- 11		451809.6	334940.6	-25.87
-- 12		447421.8	491848.9	9.93


-- for each category which month had highest sales 

WITH cte AS (
  SELECT 
    category, 
    DATE_FORMAT(`Order Date`, '%Y-%m') AS order_year_month,
    SUM(quantity * Unit_selling_price) AS sales,
    ROW_NUMBER() OVER (PARTITION BY category ORDER BY SUM(quantity * Unit_selling_price) DESC) AS rn
  FROM orders_data
  GROUP BY category, DATE_FORMAT(`Order Date`, '%Y-%m')
)

SELECT 
  category AS Category, 
  order_year_month AS `Order Year-Month`, 
  ROUND(sales, 2) AS `Total Sales`
FROM cte
WHERE rn = 1;

-- Category			Order Year-Month 	Total Sales
-- Furniture			2023-08				230523.5
-- Office Supplies		2023-02				287244.6
-- Technology			2023-10				295586.5


select * from orders_data;
-- which sub category had highest growth by sales in 2023 compare to 2022

with cte1 as
(select `sub Category`,year, sum(quantity*Unit_selling_price) AS sales
from orders_data
group by `sub Category`,year
order by year),

cte2 as(

select `sub Category`, 
round(sum(case when year = 2022 then sales end),0) as sales_2022,
round(sum(case when year = 2023 then sales end),0) as sales_2023
from cte1
group by `sub Category`)


select `sub Category`, sales_2022, sales_2023, 
 ROUND(((sales_2023 - sales_2022) / sales_2022) * 100, 2)as `growth%`
from cte2
order by (sales_2023 - sales_2022) DESC 
LIMIT 1;

-- sub Category	sales_2022	sales_2023	growth%
-- Machines		335316		548220		63.49



select * from orders_data;

# Year and Quarter wise Total Sales

select year, quarter(`Order Date`) as order_quarter, round(sum(Total_sales),1) as sales
from orders_data
group by year, order_quarter
order by year, order_quarter
;
-- year	 order_quarter	sales
-- 2022	 1				1275547.6
-- 2022	 2				1355326.7
-- 2022	 3				1343727.8
-- 2022	 4				1500939.2
-- 2023	 1				1559456.2
-- 2023	 2				1282878.4
-- 2023	 3				1308164.5
-- 2023	 4				1453287.8

##################################################################################################











