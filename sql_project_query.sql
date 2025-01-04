--sql retails sales analysis-p1
create database sql_project2;


--create table
create table retails_sales(
   transactions_id	int primary key,
   sale_date	date,
   sale_time	time,
   customer_id	int,
   gender varchar(15),
   age	int,
   category varchar(15),
   quantiy	int,
   price_per_unit	float,
   cogs	float,
   total_sale float

);
select*from retails_sales;

select count(*)
from retails_sales

---data cleaning

select * from retails_sales
where transactions_id is null
       or
      sale_date is null
	  or
	  sale_time is null
       or
	  customer_id is null
	  or
	  gender is null
	  or 
	  age is null
	  or
	  category is null
	  or 
	  quantiy is null
	  or
	  price_per_unit is null
	  or
	  cogs is null
	  or
	  total_sale is null;
	  
delete from retails_sales
where transactions_id is null
       or
      sale_date is null
	  or
	  sale_time is null
       or
	  customer_id is null
	  or
	  gender is null
	  or 
	  age is null
	  or
	  category is null
	  or 
	  quantiy is null
	  or
	  price_per_unit is null
	  or
	  cogs is null
	  or
	  total_sale is null;
	  
	  
--data exploration

--how many sales we have
select count(*) as total_sales from retails_sales;

--how many uniuque customers we have

select count( distinct customer_id) as customer from retails_sales

----how many uniuque category we have
select distinct category  from retails_sales

---data analysis & business key problems and answers

--Q1.write a sql query to retrive all columns for sales made on '2022-11-05'
select * from retails_sales
where sale_date='2022-11-05'

--Q2.write a sql query to retrieve all trasactions where the category is "clothing" and the auantity sold is more than 4 in the month of nov-2022
select * 
from retails_sales
where 
category ='Clothing'
and 
to_char(sale_date,'YYYY-MM')='2022-11'
and 
quantiy>= 4

--Q3.wite a sql query to calculate the total sales (total_sale)for each category
select category,
sum(total_sale) as net_sale
from retails_sales
group by 1

--Q4 write a sql query to find the average age of customer who purchased items from the the 'Beauty'category
select 
avg(age) as avg_age
from retails_sales
where category='Beauty'

---Q5 write a sql query to find all transaction where the total_sale is greater than 1000
select transactions_id ,total_sale from retails_sales
where total_sale >= 1000

---Q6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select category,gender,count(*) as total_transaction
from retails_sales
group by 
category,
gender
order by 1

---	Q7.Write a SQL query to calculate the average sale for each month. 
-------Find out best selling month in each year:
select
extract(year from sale_date)as year,
extract(month from sale_date)as month,
avg(total_sale) as avg_sale
from retails_sales
group by 1,2
order by 1,3 desc

---Q8.Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id,
sum(total_sale) as total_sale
from retails_sales
group by 1
order by 2 desc
limit 5;

---Q9.Write a SQL query to find the number of unique customers who purchased items from each category.
select 
category,
count(distinct customer_id) as unique_customer
from retails_sales
group by category

---10.Write a SQL query to create each shift and number of orders 
----(Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with hourly_sale
as(
select * ,
  case
  when extract(hour from sale_time)< 12 then 'morning'
  when extract(hour from sale_time) between 12 and 17 then 'afternoon'
  else 'evening'
end as shift
from retails_sales)
select shift,
count(*) as total_orders
from hourly_sale
group by shift


