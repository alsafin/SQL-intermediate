/*
replace values of null:
is null ---then coalesce--it replace null with value
null if --then null --it replace value with null
check for null:
is null--true
is null ---false
-------------
is null conain only two values where coalesce containunlimited value
is null if faster then coalesce
---use case----
1.handle null before to data aggregation()
2.handle  null before any mathematical operation
3.handle null before joining table
4.hanlde nullbefore sorting data
 
*/

--task-1: find the avg score of customer
use SalesDB

select 
customerid,
score,
avg(score) over() avg_score,
avg(coalesce(score,0)) over() avg_score_2

from sales.Customers

--task-2: display the full name of customers in a single field by merging their firs name and last name ,and added 10 bonus point to each customer's score

select
	customerid,
	firstname,
	lastname,
	CONCAT(firstname , '  ' , lastname ) as fullName,
	score,
	coalesce(score,0) + 10 as BonusScore
from 
	sales.Customers

--handle the null before joining  table
--handle null before sorting the data

--task 3: sort customers from lowest to highest scores with null apearing last
 select
 CustomerID,
 Score
 from Sales.Customers
 order by Score desc

 --null if use case division by zero 

 --task-4:find tthe sales price for each order by dividing thesales by quantity
 
 select
 OrderID,
 sales,
 quantity,
 Sales/nullif(Quantity, 0) as EachSalesPrice
 from Sales.Orders

 --is null use case filtering data
