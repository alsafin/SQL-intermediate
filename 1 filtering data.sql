use MyDatabase
--filtering data(where operator)
	--comparison operators(=,>,<,!=, etc)
	--logical operator(And,Or,Not)
	--range (Between)
	--membership operator(IN,NOT IN)

--comparison operators(=,>,<,!=, etc)
	--1.Retrive all customer from GERMANY
		select * 
		from
			customers
		where
			country = 'GERMANY'

	--2. retrive all customer who are not in GERMANY
		select * 
		from
			customers
		where
			country != 'GERMANY'

	--3. retrive all customer whose score greater than 500
		select * 
		from
			customers
		where
			score >500

	--4. retrive all customer whose score 500 or more
		select * 
		from
			customers
		where
			score >=500

	--5. retrive all customer whose score less than 500 

		select * 
		from
			customers
		where
			score <500

	--6. retrive all customer whose score less than 500 or equal
		select * 
		from
			customers
		where
			score <=500

--logical operator(And,Or,Not)

	/* 
	1.And use for all condition must be true
	2.OR use for at least one condition can be true 
	3.NOT  use for reverse or excluding values

	*/

	--7.retrive all customer who are from usa and have score greater than 500

	select 
		*
	from
		customers
	where country ='USA'
				and score >500

	--8. retirve all customer who are either from usa or have a score is greter than 500

	select 
		*
	from
		customers
	where country ='USA'
				or  score >500

	--9. retirve all customer with a score not less than 500

	select 
		*
	from
		customers
	where NOT score <500

--range (Between)

/*
range need lower boundary and upper boundary
*/

--10. retirve all customer whose  a score falls in range berween 100-500

	select *
	from customers
	where score between 100 and 500


	--membership operator(IN,NOT IN)
	--use IN insted of OR operator to show multiple value in one column
	--11.retrive all customer from germany either usa

	select *
	from customers
	where country='USA' or country= 'GERMANY'

	--using member ship operator
	select *
	from customers
	where country in ('GERMANY' , 'USA')

--like operator
	--use for find pattern in text
	--12.find all customer whose name start with M

	select * 
	from customers
	where first_name like 'M%';

	--13.find all customer whose name end with N

	select * 
	from customers
	where first_name like '%N';

	--14.find all customer whose name contain with r
	select * 
	from customers
	where first_name like '%r%';

	--15.find all customer whose name has r in the third position

	select * 
	from customers
	where first_name like '__r%';
