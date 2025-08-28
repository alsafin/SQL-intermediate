/*
--function DO
	1.accepet an input value
	2.processes it
	3.returns an output value
_____________________________________________
--two types of function:

1.single row function(ROW LEVEL FUNCTION)
*  IT IS USE TO PREPARE DATA FOR MULTI ROW FUNCTION  
	--STRING
	--DATE AND TIME
	--NULL
	--NUMERIC


2.multirow function(AGGREGATION FUNCTION)

	--AGGREGATE FUNCTION (BASIC)
	--WINDOWS FUNCTION (WINDOWS FUNCTION)
_________________________________________________

--STRING FUNCTION
	--MANUPILATION:
		1.CONCATE
		2.UPPER
		3.LOWER
		4.TRIM 
		5.REPLACE
	--CALCULATION
		1.LENGTH
	--STRING EXTRACTION
		1.LEFT
		2.RIGHT
		3.SUBSTRING
______________________________
*/

--CONCAT() FUNCTION:
--*USE FOR COMBINE MULTIPLE STRING

--TASK-1: CONCATE FIRST NAME AND COUNTRY IN ONE COLUMN
USE MyDatabase;

SELECT

FIRST_NAME,
COUNTRY,
CONCAT(FIRST_NAME, ' ' ,COUNTRY) AS NAME_COUNTRY

FROM customers;

--UPPER (USE TO CAPITALISE STRING) LOWER(USED TO EVERYTHING IN LOWER CASE)

--TASK-2: CONVERT CUSTOMER FIRST NAME TO A  LOWER CASE

SELECT 
FIRST_NAME,
LOWER(FIRST_NAME) AS LOWER_CASE_NAME
FROM customers

--trim() functon is used for remove unnecessary white space from string

--TASK-3: find customer whose firstname is containing leading or trailing space

select 
first_name
from 
customers
where first_name != trim(first_name)

--replace('main valu; what need replace,what i place in replace position) is used to replace specific charecter with a new charecter

--Date Time function
use SalesDB;


select
*

from Sales.Orders

select
OrderID,
OrderDate,
ShipDate,
CreationTime

from Sales.Orders