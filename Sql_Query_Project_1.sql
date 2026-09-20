--- 1.Create Table

Create Table Retail_Sales
           (
            transactions_id INT Primary Key,
			sale_date Date,
			sale_time Time,
			customer_id INT,
			gender Varchar(15),
			age INT,
			category Varchar(15),
			quantiy INT,
			price_per_unit Float,
			cogs Float,
			total_sal Float
           )
--- 2.Import Data from Device or other sources

--- 3.Retrieve Data from Table
Select * From public.retail_sales

--- 4. Retrieve Count of data rows
Select Count(*) From public.retail_sales

--- 5. Find Null value in Transactions_id
Select * From public.retail_sales
Where transactions_id is NULL

--- 6.  Find Null value in Sale_Date
Select * From public.retail_sales
Where category is Null

---- DATA CLEANING
--- 7. Find Null value in All Columns
Select * From public.retail_sales
Where 
     transactions_id is Null
	 or
	 Sale_date is Null
	 or
	 sale_time is Null
	 or
	 customer_id is Null
	 or
	 gender is Null
	 or
	 category is Null
	 or
	 quantiy is Null
	 or
	 price_per_unit is Null
	 or
	 cogs is Null
	 or
	 Total_sal is Null

--- Delete Null Records from every column.

DELETE FROM public.retail_sales
Where 
     transactions_id is Null
	 or
	 Sale_date is Null
	 or
	 sale_time is Null
	 or
	 customer_id is Null
	 or
	 gender is Null
	 or
	 category is Null
	 or
	 quantiy is Null
	 or
	 price_per_unit is Null
	 or
	 cogs is Null
	 or
	 Total_sal is Null

---- Data Exploration

--- How many sales we have?
Select count(transactions_id) AS Sales_count from public.retail_sales

--- How many Unique customers we Have?
Select count(DISTINCT customer_id) AS No_of_customers from public.retail_sales

--- How many Unique category we Have?
Select count(DISTINCT category) AS Category from public.retail_sales

--- Name of Unique category we Have?
Select DISTINCT category AS Category from public.retail_sales

---- Data Analysis & Business Key Problems

--- Que.1 Retrieve All columns for sales made on 2022-11-05
--- Que.2 Retrieve all Transactions where the category is Clothing and the quantity sold is more than 10 in the month of Nov-2022.
--- Que.3 Calculate the total sales for each category
--- Que.4 Find the average age of customers who purchased item from 'beauty' category.
--- Que.5 Find all Transaction where the total sale is greater than is 1000.
--- Que.6 Find the total number of transactions made by each gender in each category.
--- Que.7 Calculate the average sale for each month. Find out best selling month in each year.
--- Que.8 Find the top 5 Customers based on the highest total sales.
--- Que.9 Find the Number of Unique customers Who purchased item from each category.
--- Que.10 Create each shift and Number of Orders. ( Example Morning<=12, Afternoon B/w 12 to 17 and Evening> 17.)


--- Que.1 Retrieve All columns for sales made on 2022-11-05
Select * from public.retail_sales
Where sale_date = '2022-11-05';

--- Que.2 Retrieve all Transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
Select * FROM public.retail_sales
     Where category ='Clothing'
	 AND
	 TO_CHAR(Sale_date, 'YYYY-MM') = '2022-11'
	 AND
	 quantiy >= 4;

--- Que.3 Calculate the total sales for each category
Select
      Category,
	  Sum(Total_sal) as Net_Sale,
	  count(*) as Total_Orders
From public.retail_sales
Group by Category;

--- Que.4 Find the average age of customers who purchased item from 'beauty' category.
Select
      Round(AVG(Age),0) AS Avg_Age
From public.retail_sales
Where Category = 'Beauty'

--- Que.5 Find all Transaction where the total sale is greater than is 1000.
Select
      *
from public.retail_sales
Where Total_sal > 1000;

--- Que.6 Find the total number of transactions made by each gender in each category.
Select
     Category,
	 gender,
     Count(transactions_id) as No_Of_Transactions
From public.retail_sales
Group By Category,gender
Order by category;

--- Que.7 Calculate the average sale for each month. Find out best selling month in each year.
Select
     Years,
	 Months,
	 Avg_sale
From(
	SELECT
	      Extract(YEAR FROM sale_date) AS Years,
		  Extract(MONTH FROM sale_date) AS Months,
		  Avg(total_sal) as avg_sale,
		  Rank() OVER(PARTITION BY  Extract(YEAR FROM sale_date) ORDER BY AVG(total_sal) Desc) AS ranking
	FROM public.retail_sales
	Group by 1, 2 ) as T1
Where Ranking = 1

--- Que.8 Find the top 5 Customers based on the highest total sales.
Select 
      customer_id as Customer,
	  Sum(total_sal) as Total_sales
From public.retail_sales
Group by 1
Order by 2 Desc
Limit 5

--- Que.9 Find the Number of Unique customers Who purchased item from each category.
Select
      category,
	  count(DISTINCT customer_id)
FROM public.retail_sales
GROUP BY category

--- Que.10 Create each shift and Number of Orders. ( Example Morning<=12, Afternoon B/w 12 to 17 and Evening> 17.)
With hourly_sales
AS
(
Select *,
	Case
		When Extract(Hour from sale_time) < 12 then 'Morning'
		when Extract(Hour from sale_time) Between 12 and 17 then 'Afternoon'
		else 'Evening'
	End as Shift
From public.retail_sales
)
Select
     shift,
     count(*) as Total_orders
From Hourly_sales
Group By Shift

--- End of Project