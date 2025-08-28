use SalesDB
--syntax and rules
--join and set operator use to combine the table
/*
1.set operators canbe used with all  clause where and join like where ,join,groupby,having
2.order by allowed only once at the end of the query
3.the number of columns in each query must be same
4.the order of column in each query must be same
5.the column name in the result set are determined by the column names  specified in the first query
6.even if all rules are met and sql shows no errors the result maybe incorrect
--incorrect aolumn section leads to in accurate results
*/

--union
/*
1. returns all distinct rows from both queries
2.remove duplicate rows from the reuslt

*/
--task-1: combine the data from employees and customers into one table

select 
FirstName,
LastName
from sales.Customers
union
select 
FirstName,
LastName
from Sales.Employees;

--union all
/*
1.returns all rows from both queries including duplicate
2.if you sure there is no duplicates then use union all
*/
--tsk-2:combine the data from employee and customer into one table including duplicates
select 
FirstName,
LastName
from sales.Customers
union all
select 
FirstName,
LastName
from Sales.Employees;

--except operator
/*
1.returns all distinct rows from the first query that are not found in second query
2.it is the only one where the order of queries affect the final reult
*/

--task-3: find the employees who are not customer at the same time
select 
FirstName,
LastName
from sales.Employees
except
select 
FirstName,
LastName
from Sales.Customers;

--intersect operator
/*
1.returns only the rows that  are common in both queries

*/
--task-4: find the employees who are customer at the same time
select 
FirstName,
LastName
from sales.Employees
intersect
select 
FirstName,
LastName
from Sales.Customers;

--union  use  cases
/*
1.combine similar information before analyse data
*/

--task-4: order data are stored in separate tables(orders and orders archive)
--combine all orders data into one report without duplicates
select
*
from Sales.Orders
union
select 
*
from Sales.OrdersArchive;

--but this is not good practice

select
'orders' as sourceTable,
       [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from Sales.Orders

union
select 
'ordersArchive' as sourceTable,
       [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from Sales.OrdersArchive
order by OrderID;

--except use cases(Delta detection)

/*
1.indentifying the differences or changes (delta) between two batche of data
2.data completeness check
--except operator can be used to compare tables to detect discrepancies between database
*/