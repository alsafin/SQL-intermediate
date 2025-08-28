/*
--part extraction
1.DAY()  ===  FUNCTION RETURN DAY FROM A DATE
2.MONTH()  ===FUNCTION RETURN MONTH FROM A DATE
3.YEAR() ===FUNCTION RETURN YEAR FROM A DATE
4.DATEPART==return specific part of date as a number(week,quarter)
5.DATENAME== RETURN THE NAME OF MONTH
6.DATETRUNC== TRUNC SPECIFIC YEAR,MOTN AND OTHER RESET
7.EOMONTH== RETURN THE LAST DAY OF THE MONTH

--FORMATE AND CASTING
1.FORMATE---changhing the formate of valu fromone to another but only string
2.CONVERT
3.CAST=== IF DATE COME WITH MONTH ,THEN CAST MAKE IT ONLY DATE WITHOUT TIME ,or change data type any to any

--CALCULATION
1.DATEADD
2.DATEDIFF

--VALIDATION
1.ISDATE
*/
--datepart return specific part of date as a number(week,quarter)

USE SalesDB;

SELECT
ORDERID,
CREATIONTIME,
--datetrunc() function
DATETRUNC(MINUTE,CREATIONTIME) MINUTE_RESET,
DATETRUNC(DAY,CREATIONTIME) DAY_RESET,
DATETRUNC(YEAR,CREATIONTIME) YEAR_RESET,
--date part(),date
YEAR(CREATIONTIME) as year,
month(creationtime) as month,
day(creationTime) as day,
datepart(QUARTER,CreationTime) as quearter_part,
datepart(week,CreationTime) as week_part,
DATENAME(month,CreationTime) as month_name,
DATENAME(WEEKDAY,CreationTime) as week_name,

 --EOMONTH()

 EOMONTH(CREATIONTIME) ENDOFMONTH,
cast(  DATETRUNC(MONTH,CreationTime) as date)   STARTOFMONTH

FROM SALES.Orders



--WHY DATERUNCH IS USE FOR DATAANALYST 
	--LIKE WE NEED TO SHOW ORDER ONLY MONTH,YEAR BASIS
 SELECT
 DATETRUNC(MONTH,CreationTime) MONTH,
 COUNT(*) AS COUNT_ROW

 FROM
 Sales.Orders
 GROUP BY DATETRUNC(MONTH,CreationTime) ;


 --task-1:show all order during the month of february
 select
*


 from sales.orders
 where MONTH(OrderDate)=2

 --which part
 /*
 if need day month in numeric then day(),month(),year()
 if need name of month then datename()
 if need other part like quarter then datepart()
 * /