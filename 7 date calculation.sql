use SalesDB;
select 
*
from 
Sales.Employees

--Task-1:calculate the age of employeee
select 
EmployeeID,
CONCAT(FirstName,+ ' ' +LastName) as FullName ,
DATEDIFF(year,BirthDate,GETDATE()) as age
from Sales.Employees

--Task-2:find the average shipping duration in days for each month

select 
MONTH(OrderDate) orderMonth,
avg(DATEDIFF(Day,OrderDate,ShipDate)) as DayToShip
from sales.Orders
Group By MONTH(OrderDate);

--Time GAp analysis
--TAsk-3: find the number of days between each order and the previous order

select 
OrderID,
OrderDate as CurrentOrderDate,
LAG( OrderDate) over (order by OrderDate) as PreviousOrderDate,
DATEDIFF( day, LAG( OrderDate) over (order by OrderDate),OrderDate) as OrderGap
from Sales.Orders