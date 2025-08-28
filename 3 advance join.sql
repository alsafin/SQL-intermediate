use MyDatabase
--left anti join
/*
1.return row from left table that has no match in right table
2.right table work only as filter the data
3.the order of table is important
*/
use MyDatabase;
--1.get all customer who havent any order

select 
*
from customers as c
left join orders as o

on c.id = o.customer_id
where o.customer_id is null;

--right  anti join
/*
1.return row from right table that has no match in left table
2.left table work only as filter the data
3.the order of table is important
*/
--1.get all orders without matching order 
select 
*
from customers as c
right join orders as o

on c.id = o.customer_id
where c.id is null;

--full  anti join
/*
1.return only rows that didnt match on the table
2.only unmatching data show
*/
--1.find customers without orders and orders without customers
select 
*
from orders as o
full  join customers as c

on c.id = o.customer_id
where c.id is null or o.customer_id is null ;

--2.get all customers along with their order but only for customer who have placed an order (without using inner join)
select
*
from customers as c
left join orders as o
on c.id = o.customer_id
where o.order_id is not null;

--cross join
/*
1. combine every row from left with every row from right all possible combination
2.we want everything fromm A and everything from B
3.the order of table dosent matter
*/
--1.generate all possible combination of customers and orders

select 
*
from customers
cross join orders;

--how to choose join types
/*
1.if only need to show matching data then use inner join
2.if one side data is more importan (master table) then use left join****
3.if we need both data we use full join
4.if need unmatching data then use left antijoin

*/

--Task
--using sales db,retrive a list of orders along with the related customers,product and employee details

/*

for each order display the following:
1.order id
2.customer name	
3.product name
4.sales amount
5.product price
6.sales person name

*/

use SalesDB;

select
*
from sales.Orders

select 
O.OrderID,
O.SALES,
C.FirstName AS CUSTOMER_FIRST_NAME,
C.LastName AS CUSTOMER_LAST_NAME,
P.Product AS PRODUCT_NAME,
P.PRICE,
E.FirstName AS EMPLYEE_NAME
from Sales.Orders as O


left join Sales.Customers as C
on o.CustomerID = C.CustomerID
LEFT JOIN Sales.Products AS P
ON O.ProductID = P.ProductID

LEFT JOIN SALES.Employees AS E
ON O.SalesPersonID = E.EmployeeID;