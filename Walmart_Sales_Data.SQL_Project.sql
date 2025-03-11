How many distinct cities are present in the dataset?
select distinct City from `walmart_sales_data.csv`;
In which city is each Branch situated?
select distinct Branch,City from `walmart_sales_data.csv`;
How many distinct product lines are there in the dataset?
select distinct Product_line from `walmart_sales_data.csv`; 
What is the most common payment method?
Select Payment, count(Payment) as Common_Payment from `walmart_sales_data.csv`
group by Payment
order by Common_Payment desc limit 1;
What is the most selling product line?
select Product_line, sum(Total) as Total_sale from `walmart_sales_data.csv`
group by Product_line
order by Total_sale desc limit 1;
What is the total revenue by month?
SELECT * FROM sudipta.`walmart_sales_data.csv`;
select monthname(date) as month_name from `walmart_sales_data.csv`;
alter table `walmart_sales_data.csv`rename column Date ;
select Date, sum(Total) as Total_Revenue from `walmart_sales_data.csv`
Group by Date
order by Total_Revenue desc;

SELECT STR_TO_DATE(Date, '%d-%m-%y') AS date
FROM `walmart_sales_data.csv`;
describe `walmart_sales_data.csv`;
SELECT MONTHNAME(STR_TO_DATE(Date, '%d-%m-%Y')) AS month_name
FROM `walmart_sales_data.csv`
WHERE STR_TO_DATE(Date, '%d-%m-%Y') IS NOT NULL;
SELECT MONTHNAME(STR_TO_DATE(Date, '%d-%m-%Y')) AS month_name,
       SUM(Total) AS total_revenue
FROM `walmart_sales_data.csv`
WHERE STR_TO_DATE(Date, '%d-%m-%Y') IS NOT NULL
GROUP BY month_name
ORDER BY total_revenue DESC;
Which month recorded the highest Cost of Goods Sold (COGS)?
select MONTHNAME(STR_TO_DATE(Date, '%d-%m-%Y')) AS month_name, max(cogs)  from `walmart_sales_data.csv`
WHERE STR_TO_DATE(Date, '%d-%m-%Y') IS NOT NULL
group by month_name
order by max(cogs) desc limit 1;
Which product line generated the highest revenue?
select Product_line, sum(Total) as highest_revenue from `walmart_sales_data.csv`
group by Product_line
order by highest_revenue desc limit 1;
Which city has the highest revenue?
select City, sum(Total) as highest_revenue from `walmart_sales_data.csv`
group by City
order by highest_revenue desc limit 1;
Which product line incurred the highest VAT?
alter table `walmart_sales_data.csv` add VAT1 decimal(10,2);
 update `walmart_sales_data.csv` set VAT1 = Unit_price + Unit_price*Tax_5%
 where VAT1 is not null
SELECT Product_line, SUM(vat) as VAT 
FROM `walmart_sales_data.csv` GROUP BY product_line ORDER BY VAT DESC LIMIT 1;
Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,' based on whether its sales are above the average
alter table `walmart_sales_data.csv` modify product_category varchar(10);
alter table `walmart_sales_data.csv` modify Average_sales double(10,2) ;
SET @avg_total = (SELECT AVG(Total) FROM `walmart_sales_data.csv`);
select @avg_total from `walmart_sales_data.csv`;
SET SQL_SAFE_UPDATES = 0;
update `walmart_sales_data.csv` 
set Average_sales = @avg_total;
select Average_sales from `walmart_sales_data.csv`;
SET SQL_SAFE_UPDATES = 1;
UPDATE `walmart_sales_data.csv` 
SELECT product_category, Total,
CASE 
	WHEN Total >= Average_sales THEN "Good"
    ELSE "Bad"
END FROM `walmart_sales_data.csv`;
SELECT Branch, sum(Quantity) as Quantity from `walmart_sales_data.csv` 
group by Branch having sum(Quantity) > (select Avg(Quantity))
order by Quantity desc limit 1;
select Product_line, count(Gender) as Gender from `walmart_sales_data.csv`
group by Product_line
order by Gender desc limit 1;
What is the average rating of each product line?
Select Product_line, Avg(Rating) as Rating from `walmart_sales_data.csv`
group by Product_line
order by Rating desc;
Number of sales made in each time of the day per weekday
SELECT dayname(STR_TO_DATE(Date, '%d-%m-%y')) AS Day, Time, count(Quantity) as total_sales from `walmart_sales_data.csv`
group by Date,Time having Day not in ('Saturday','Sunday');
Identify the customer type that generates the highest revenue
select Customer_type, Sum(Total) as total_sales from `walmart_sales_data.csv`
group by Customer_type
order by total_sales desc;
Which city has the largest tax percent/ VAT (Value Added Tax)?
ALTER TABLE `walmart_sales_data.csv` 
CHANGE COLUMN `Tax_5%` Tax_5 DOUBLE;
select City, sum(Tax_5) as Total_VAT from `walmart_sales_data.csv`
group by City
order by Total_VAT desc limit 1;
Which customer type pays the most in VAT?
Select Customer_type, sum(Tax_5) as Total_VAT from `walmart_sales_data.csv`
group by Customer_type
order by Total_VAT desc limit 1;
How many unique customer types does the data have?
select count(distinct (Customer_type)) from `walmart_sales_data.csv`;
How many unique payment methods does the data have?
select count(distinct(Payment)) from `walmart_sales_data.csv`;
Which is the most common customer type?
select max(distinct(Customer_type)) from `walmart_sales_data.csv`;
Which customer type buys the most?
select Customer_type, sum(Total) as Total_purchase from `walmart_sales_data.csv`
group by Customer_type
order by Total_purchase desc limit 1;
What is the gender of most of the customers?
select Gender, Count(Customer_type) as Customer_type1 from `walmart_sales_data.csv`
group by Gender
order by Customer_type1 desc limit 1;
What is the gender distribution per branch?
select Branch, Gender, Count(Gender) as Gender1 from `walmart_sales_data.csv`
group by Branch,Gender
order by Branch;
Which time of the day do customers give most ratings?
select Time, avg(Rating) as Rating1 from `walmart_sales_data.csv`
group by Time
order by Rating1 desc limit 1;
Which time of the day do customers give most ratings per branch?
select Branch,Time, avg(Rating) as Rating1 from `walmart_sales_data.csv`
group by Branch,Time
order by Rating1 desc limit 1;
Which day of the week has the best avg ratings?
select Dayname(str_to_date(Date,'%d-%m-%y'))as Day, avg(Rating) as Rating1 from `walmart_sales_data.csv`
group by Day
order by Rating1 desc limit 1;
Which day of the week has the best average ratings per branch?
select Branch,Dayname(str_to_date(Date,'%d-%m-%y'))as Day, avg(Rating) as Rating1 from `walmart_sales_data.csv`
group by Branch,Day
order by Rating1 desc limit 1;
Which product line incurred the highest VAT?
select Product_line , sum(Tax_5) as VAT from `walmart_sales_data.csv`
group by Product_line
order by VAT desc limit 1;