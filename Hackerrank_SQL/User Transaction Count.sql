

A bank wants to know how many transactions were made by each of their customers in
the years 2019, 2020, and 2021.
The first two characters of the transaction id in the table transactions represent the year
the transaction was made. For example, transaction id 20345 would have been made in
2020. Write an SQL query that returns all the users and the number of transactions
made by them in years 2019, 2020, and 2021 in different columns.


select
	user_name
	,sum(case when year = '19' then transactions end) as 19_transactions
	,sum(case when year = '20' then transactions end) as 20_transactions
	,sum(case when year = '21' then transactions end) as 21_transactions
from(
	select
		T.user_id
		,U.user_name
		,left(transaction_id, 2) as year
		,count(transaction_id) as transactions
	from
		transactions T 
	left join 
		users U 
	on T.user_id = U.user_id
	where left(transaction_id, 2) in ('19', '20', '21')
	group by 1,2,3
	)
group by 1
;