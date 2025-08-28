/*
count()---return numbers of row within each window

*/
use SalesDB
--task-1: find the total number of  orders

select
	count(*) as totalOrder
from Sales.Orders

--task-2: find the total number of orders additionally provide details such order id and order date

select
	orderid,
	orderdate,
	count(*) over() as totalOrder
from Sales.Orders

--task-3: find the total number of order for each customer 
--use case: group wise analysis to understand patterns with different categories

select
	CustomerID,
	orderid,
	orderdate,
	count(*) over( partition by customerid) as totalOrder
from Sales.Orders
 

 --task-4: find the total number of customers and additionally provide all customers detail

 select
	 *,
	 count(*) over() total_Number_Of_Customer
 from Sales.Customers

 --task-5: 
 --find the total number of scores for the customers
 --check the quality of data(5-4=1 null in score)
 --check the quality of data(5-5=0 null in country)

  select
	 *,
	 count(*) over() total_Number_Of_Customer,
	  count(country) over() total_Number_Of_country,
	  count(score) over() total_Number_Of_score
 from Sales.Customers

 --task-6: 
 --check whether the table orders contain any duplicate rows
 --duplicacy of orderid

 select 
	 OrderID,
	 count(*) over(partition by orderId) checkpk
 from Sales.Orders

 select
 *
 from(
	 select 
	 OrderID,
	 count(*) over(partition by orderId) checkpk
	 from Sales.OrdersArchive
	 )t where checkpk>1

 /*
 -main usages of window function is check data quality
 -check the duplicates
 ---count usecase----
 1.overall analysiis
 2.category analysis
 3.qualitity check nulls
 4.check duplicate
 */

 --sum function use case and task

  
  --task-7: find the total sales across all orders and the total sales for each product and additionally provide details orderif , orderdate

select
	  OrderID,
	  OrderDate,
	  Sales,
	  PRODUCTID,
	  SUM(Sales) over() totalSales,
	  SUM(SALES) OVER( PARTITION BY PRODUCTID) PRODUCT_WISE_SALES
 from Sales.Orders

 /*
 COMPARISON ANALYSIS
 --compare the current  value and aggregate value of  window function
 --compaare to extreme analysis: compare current sales to the highest or lowest sales
 --compare to average analysis: help to evaluate whether value is above or below average

 */

 --task-8: find the percentage contribution of each product sales to the total sales
 select
	 orderid,
	 productid,
	 sales,
	 SUM(sales) over() TotalSales,
	round(CAST( Sales as float)/ SUM(sales) over() *100 ,2)percantgeOfsales
from
	sales.orders

---avg() function----
--task-9: 
--find the average sales for across all orders 
--find the average sales for each product
--provide orderid and orderdate

select
orderid,
OrderDate,
productid,
sales,
AVG(coalesce(sales,0)) over( ) AvgOrders,
AVG(coalesce(sales,0)) over( partition by productid) productAvg
from 
sales.orders

--task-10: 
--find the average scores of all customers
--provide  customerid and lastName
select
	CustomerID,
	LastName,
	Score,
	AVG(coalesce(score,0) ) over( ) avgScoreCustomer
from
Sales.Customers

--task-11:
--find all orders where sales are higher than the average sales across all orders
select
*
from(

	select
		orderid,
		productid,
		sales,
		avg(sales) over() avgSales
	from
		Sales.Orders
)t where sales>avgSales;

--task-12:
--find the highest and lowest sales of all orders
--find the highest and lowest sales for each product
--additionaly provide orderid ,order date

--task-13:
--show the employee with highest salaries

--task-14:
--calculate the deviation of each sale from both minimum and maximum sales amount
select

	orderId,
	orderDate,
	productId,
	sales,
max(sales) over() highestSales,
min(sales) over() lowestSales,
sales -min(sales) over() DeviationFromMin,
max(sales) over() - sales DeviationFromMax
from
sales.orders

/*
---analytical use case:---
--running total and rolling total
------they aggregate sequence of members ,and the aggregation is update each time new member is added

--analysis over time
--running total:
aggregate all values from the beggining up to the current point without dropping off older data

--rolling total:
aggregate all values within a fixed time windows (30 days)
as new data added the ,the oldest data point will be dropped 

----------use case-----
Tracking: Tracking current sales with target sales
Trend analysis: provide insight into historical patterns
*/ 

--task15: calculate the moving average of sales for each product over time
select
	OrderId,
	ProductId,
	OrderDate,
	Sales,
	AVG( Sales ) over(partition by productid) avgProdyct ,
	AVG( Sales ) over(partition by productid order BY OrderDate) MovingAverage  -- over time analysis means sorting dates in ascending order


from
sales.Orders

--task16: calculate the moving average of sales for each product over time,inlcuding next order only
select
	OrderId,
	ProductId,
	OrderDate,
	Sales,
	AVG( Sales ) over(partition by productid) avgProdyct ,
	AVG( Sales ) over(partition by productid order BY OrderDate) MovingAverage ,-- over time analysis means sorting dates in ascending order
	AVG( Sales ) over(partition by productid order BY OrderDate rows between current row and 1 following ) RollingAvg 
from
sales.Orders