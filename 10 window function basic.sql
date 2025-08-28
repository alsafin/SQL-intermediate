/*
what and why window(window vs group)?
= perform calculation(aggregatopn) on a specific subset of data,withous losing level of details of row
*why we need windw function?
*why group by is not anough
*/
use SalesDB
--task-1: find the total sales across all orders

select
SUM(sales) as total_sales
from Sales.Orders

--task-2:find the total sales for each product
select
ProductID,
SUM(sales) as total_sales
from 
Sales.Orders
Group BY ProductID

-----window function and partition by-----------------

--task-3:find the total sales for each product and add additional info like orderid,orderdate
select
ProductID,
orderdate,
orderid,
SUM(sales) over(partition by productid) as total_sales
from 
Sales.Orders

--task-4: find the total sales for each combination of product and order status
select
ProductID,
orderdate,
orderid,
orderstatus,
SUM(sales) over(partition by productid) as total_sales,
SUM(sales) over(partition by productid,orderstatus) as total_sales_by_orderstatus
from 
Sales.Orders

-----window function and order by-----------------

--task-5:rank each order  based on their sales from highest to lowest
select
ProductID,
orderdate,
orderid,
orderstatus,
sales,

RANK() over(partition by productid order by sales desc) as rank_sales
from 
Sales.Orders


-----window function and rows unbounded preceding(windows frame)-----------------
/*
1.frame types- Rows and Range
2.Frame boundary(lower value)- current row and n preceding
3.frame boundary(higher value)- current row,n followeing, unbounded following
---rules---

* we can not use frame clause without orderby
* lower value must be before the higher value

*/
