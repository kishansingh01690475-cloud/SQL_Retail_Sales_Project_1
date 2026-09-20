# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `my_project_1`.
- **Table Creation**: A table named `Retail_Sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE my_project_1;

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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
Select Count(*) From public.retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM public.retail_sales;
SELECT DISTINCT category FROM public.retail_sales;

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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve Retrieve All columns for sales made on 2022-11-05**:
```sql
Select * from public.retail_sales
Where sale_date = '2022-11-05';
```

2. **Write a SQL query to Retrieve all Transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.**:
```sql
Select * FROM public.retail_sales
     Where category ='Clothing'
	 AND
	 TO_CHAR(Sale_date, 'YYYY-MM') = '2022-11'
	 AND
	 quantiy >= 4;
```

3. **Write a SQL query to Calculate the total sales for each category.**:
```sql
Select
      Category,
	  Sum(Total_sal) as Net_Sale,
	  count(*) as Total_Orders
From public.retail_sales
Group by Category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
Select
      Round(AVG(Age),0) AS Avg_Age
From public.retail_sales
Where Category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
Select
      *
from public.retail_sales
Where Total_sal > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
Select
     Category,
	 gender,
     Count(transactions_id) as No_Of_Transactions
From public.retail_sales
Group By Category,gender
Order by category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
Select 
      customer_id as Customer,
	  Sum(total_sal) as Total_sales
From public.retail_sales
Group by 1
Order by 2 Desc
Limit 5
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
Select
      category,
	  count(DISTINCT customer_id)
FROM public.retail_sales
GROUP BY category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


## Author - Kishan.

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!
