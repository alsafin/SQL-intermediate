use MyDatabase
--sql join basic
--when to need sql join
/*
	1.recombine data
	2.data enrichment to get extra data 
	3.check for existence filtering
*/
--join types(basic)
/*
	1. No join
	2. Inner Join
	3. Left Join
	4. Righ Join
	5. Full join

*/
--join types(advance)
/*
	1. Left anti  join
	2. Righ anti Join
	3. Full anti Join
	4. Cross  Join
*/
/*-----------------------------------------------------------------------*/
--1. No join
	--return data from table without joining them

	--1.Retrive all data from customer and order in two different result 

select * from customers

select * from orders

--2. Inner join 
	-- only matching rows as output
	-- in this join the order of tables dosent matter

	--1 .get all customner along with their orders,but only for customers who have placed and order

select 
	C.id,
	C.first_name,
	O.order_id,
	O.sales
from customers as C
inner join orders as O
on  C.id = O.customer_id

--	3. Left Join
/*
--returns all rows from left table and matching only right table
--the order of table is important 
-- left table always from clause
*/
--1.get all customer along with their order ,including those without orders

select 
	C.id,
	C.first_name,
	O.order_id,
	O.sales
from customers as C
left  join orders as O
on  C.id = O.customer_id

--	4. Right Join
/*
--returns all rows from right table and matching only left table
--the order of table is important 
*/
	--1.get all customer along with their order ,including order without matching customer
select 
	C.id,
	C.first_name,
	O.order_id,
	O.sales
from customers as C
right  join orders as O
	on  C.id = O.customer_id

--2.get same result: get all customer along with their order ,including order without matching customer using left join

select 
	C.id,
	C.first_name,
	O.order_id,
	O.sales
from orders as O
left  join customers as c
on  O.customer_id=C.id 


--	5. full Join
/*
--returns all rows from right table and left tables
*/
--1.get all customer and all orders
select 
	C.id,
	C.first_name,
	O.order_id,
	O.sales
from customers as C
full  join orders as O
on  C.id = O.customer_id