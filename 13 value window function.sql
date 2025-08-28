use SalesDB
/*
---------value window function----------
Lag()-lag(sale,2,0) over(order by month) here 2 represent the sales of 2 month ago by default it is 1,0 represent if not find any valu then 0 by default it is null
-compare sales current month vs previous month / within a windows
lead()
-compare sales current month vs next month / winthin a window
first_value()
-compare sales current month vs first month
last_valu()
-compare sales current month vs last month
****order by required
*/

/*
-----value window function(min/max)--------
Time series analysis-the process of analyzing the data to understand patterns , trendsand the behaviors over time

-- year over year(YoY) analysis:
analyze the overall growth or decline of the business perfomance over time




-month over month(MoM) analysis:
analyze short term trends and discover patterns in seasonality
*/

--task-1: analyze the month over month perfomance by finding the percentage change in sales between the current and previous month

select
OrderID,
OrderDate,
Sales
from 
Sales.Orders;

--now main 
select
*,
currentMonthSales - previousMonthSales as MoM_change,
concat(round(cast((currentMonthSales - previousMonthSales) as float)/previousMonthSales*100 ,2),'%') as MoM_percentage_sales
from(
select
MONTH(OrderDate) as OrderMonth ,
sum(Sales) currentMonthSales ,
lag(sum(Sales)) over(order by MONTH(OrderDate) ) previousMonthSales
from 
Sales.Orders
group by MONTH(OrderDate)
)t

/*
--customer retention analysis:
Measure Customer Behaviour and loyality to help business build strong relationships with customer
*/
--task-2: analyze customer loyality by ranking customers based on the average number of days between orders

select
CustomerID,
AVG(DaysUntill_NextOrder) AvgDays,
RANK() over(  order by coalesce( AVG(DaysUntill_NextOrder),999999)  )  RankAvg
from
(
	select
	OrderID,
	CustomerID,
	OrderDate currentOrder_Date,
	lead(OrderDate) over(partition by customerid order by orderdate) nextOrder_date,
	--datediff() calculate the difference between two date values
	datediff(
	day,OrderDate,lead(OrderDate) over(partition by customerid order by orderdate) 
	) DaysUntill_NextOrder
	from
	Sales.Orders
)t
group by CustomerID


/*

*/

--task-3: find the highest sales for each product

select
OrderID,
ProductID,
Sales,
FIRST_VALUE(Sales) over( partition by productid order by sales asc) lowestSale,
FIRST_VALUE(Sales) over( partition by productid order by sales desc) HighestSale
from
Sales.Orders


