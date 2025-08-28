use SalesDB
/*
Window Rak() Function:

Distribution Analysis:

-Find top 20% product 
---Cume_dist(),Percent_rank()

-find top 3 product (top/bottom N analysis)
---Row_number(),Rank(),Dense_rank(),Ntil
*/

--Row_Number()
/*
-assign a unique number to each row
-it doesnt handle ties
*/
--task-1: rank the order based on their sales from highest to lowest
select

OrderID,
ProductID,
Sales,
ROW_NUMBER() over( order by sales desc) sales_rank_row
from
Sales.Orders

-----rank()------
/*
-asign a rank to each row
-it handles ties
-it leaves gap in ranking
*/
select

OrderID,
ProductID,
Sales,
ROW_NUMBER() over( order by sales desc) sales_rank_row,
Rank() over( order by sales desc) sales_rank
from
Sales.Orders

----Dense_rank()----
/*
-assign a rank to each row
-it handle ties
-it doesn't leaves gap in ranking
*/

select
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() over( order by sales desc) sales_rank_row,
	Rank() over( order by sales desc) sales_rank,
	Dense_rank() over( order by sales desc) sales_Dense_rank
from
Sales.Orders

-----row_number use cases:-----
--Top N analysis
--analysis the top perfomers to do targeted marketing

--task-2: find the top highest sales for each product
select
* 
from(
	select
	orderid,
	productid,
	sales,
	ROW_NUMBER() over( partition by productid order by sales desc) rankByProduct
	from
	Sales.Orders)t
where rankByProduct=1

----Bottom N analysis:-----
--Help analysis the underperfomance to manage risk and to do optimizations

--task-3: find the lowest 2 customer based on their total sales
select
*
from(
select
CustomerID,
sum(sales) total_sales,
ROW_NUMBER() over (order by sum(sales)   ) rankCustomer
from sales.Orders
group by CustomerID)t where  rankCustomer<=2



-------row_number() use case------
/*

1.generate unique ids
2.identify duplicate-identify and remove duplicate rows to improve data quality
*/
--task-3:assign unique ids to the rows of the archive orders table

select
ROW_NUMBER() over( order by orderId , orderDate ) unique_id,
*
from sales.OrdersArchive

--task-4: identify duplicate rows in the tble orderArchive and return a clean result without any duplicates
select
ROW_NUMBER() over( partition by orderid order by creationTime desc) as rn,
*
from sales.OrdersArchive --by this we check the duplicate and by order creaton time wee make the latest one first

--now by this we only select which rank only 1
select
*
from(
select
ROW_NUMBER() over( partition by orderid order by creationTime desc) as rn,
*
from sales.OrdersArchive
)t where rn=1

--Rank window function-Ntile---
/*
--------use case-
1.Divides the rows into specified number of bucket approximately equal groups(buckets)
2. data categories
3.equalizing load -

*/
--task-5:  segment all orders into 3 categories high,medium,low sales

select
*,
case when bucket = 1 then 'High'
			when	 bucket  = 2 then 'Medium'
				  when bucket = 3 then 'Low'
end as segmentation
from(
select
OrderID,
Sales,
NTILE(3) over( order by sales desc) bucket
from Sales.Orders
)t

--task-6: in order to export the data dividethe orders into 2 groups

select
NTILE(2) over( order by orderId) buckets,
*
from Sales.Orders

--percantage based ranking
/*
cume_dist()
percent_rank()-calculate the relative position of each row
*/
--task-7:find the product that fall within the highest 40% of prices

select
*,
CONCAT(distRank*100, '%') DistRankPer
from(

select
Product,
price ,
cume_dist() over( order by price desc) distRank
from
Sales.Products
)t where distRank <= 0.4