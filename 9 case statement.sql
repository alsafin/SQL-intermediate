--case statement is use when we transfer data 
--condition stop if first conditon is meet

--1.use case to categorized data,create new column

--Task-1:Generating report showing the total sales of each category,sort the category highest to lowest(sales over 50 higher,21-50 medium eilse lower)

use SalesDB

select 
category,
sum(sales) as TotalSales
from
	(select 
	OrderID,
	sales,
	case	
		when sales >50 then 'higher '
		when sales>20 then 'medium'
		else 'low'

	end as category
	from sales.orders
)t

group by category
order by TotalSales desc

--2.use case: for mapping values(transfer values from one form to another form)
--task-2: retrive employee details with gender display as full text

select 
*
from(
	select
*,
	case
	when gender = 'M' then 'male'
	when Gender = 'F' then 'female'

	end as fullGender
	from Sales.Employees
	)t

--task-2: retrive customer details with abbriviate country code

--3.case use when handling null value
--task-3:find the average scores of customers and treat nulls as 0.and additinal provide details such customer id and last name
--score clean
select
LastName,
CustomerID,
score ,


case
	when score is null then 0
	else score
 end  scoreClean




from sales.Customers;
--final query
SELECT
  LastName,
  CustomerID,
  score,

  AVG(CASE
        WHEN score IS NULL THEN 0
        ELSE score
      END) OVER () AS AvgCustomers,

  AVG(score) OVER () AS AvgCustomer

FROM sales.Customers;

--4.use case for conditional aggregation
--apply aggregate functions only on subset of data that fulfill certain cndition

--task 4: count how many times each customer has made an order with sales greater than 30

 --first create flag that has greater than 30 order

 select 
 OrderID,
 CustomerID,
Sales,
case
	when sales > 30 then 1
	else 0
end  as flag

 from Sales.Orders
 order by CustomerID
 --summerize the binary number

select 

 CustomerID,

sum(case
	when sales > 30 then 1
	else 0
end  ) total_sales,
count(*) as Total_orders
 from Sales.Orders
 group by CustomerID