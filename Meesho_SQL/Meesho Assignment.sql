Candidate Details: 
Name: Mukul Anand
Email ID: anandmukul16@gmail.com
Mb No: 9891028751


				***** Assignement *****
Programming Language Used: MySQL
Assumptions: For Each Question Assumption is mentioned.


Question - 1
*Given an Order Table with the schema (id, user_id, total, created). Write a SQL Query to create a retention plot. The format for the raw data and output are given.
**Week Start Date is the 1st Week in which the User_Id Placed the order, Week 0 is Unique User ids who placed their 1st Order in this week. Out of those ids, Week 1 is unique users who placed an order in 1st Week + 1, Then Week 2 is 1st Week + 2 and so on till Week 10.

*Assumptions -
**Preparing a weekly retention plot showing the number of customers retained in the subsequent weeks who made their first transaction is a particular week.
**For example if a 100 customers made their transaction in the week with the start date 1st December 2020 then how many of those customers were retained in the upcoming weeks.


Solution - 1

with week_first as/*starting week date for first purchase date is calculated for each customer*/
(
select 
dim_event_user_id,
min(date(date_trunc('week',date))) as mindate
from retention_data
group by 1
 
),
start_week /*starting week date for each transaction is calculated*/
as
(
select a.dim_event_user_id,
b.mindate,
date(date_trunc('week',a.date)) as weekorderdate
from retention_data as a
join week_first as b on a.dim_event_user_id=b.dim_event_user_id
),
week_diff as/*calculating the week difference between any transaction and the mindate*/
(
select
*,
(datediff(weekorderdate,mindate)/7) as diff
from start_week
),
 
final_output as/*final count of distinct customers retained in a particular week*/
(
select 
mindate,
count(distinct(if(diff=0,dim_event_user_id,null))) as week0,
count(distinct(if(diff=1,dim_event_user_id,null))) as week1,
count(distinct(if(diff=2,dim_event_user_id,null))) as week2,
count(distinct(if(diff=3,dim_event_user_id,null))) as week3,
count(distinct(if(diff=4,dim_event_user_id,null))) as week4,
count(distinct(if(diff=5,dim_event_user_id,null))) as week5,
count(distinct(if(diff=6,dim_event_user_id,null))) as week6,
count(distinct(if(diff=7,dim_event_user_id,null))) as week7,
count(distinct(if(diff=8,dim_event_user_id,null))) as week8,
count(distinct(if(diff=9,dim_event_user_id,null))) as week9,
count(distinct(if(diff=10,dim_event_user_id,null))) as week10
from week_diff
group by 1
)
select *
from final_output
;









Question - 2
*Given the tables Order_Timeline(schema id,order_id, message, created) & Order_Shipment Table(schema id, order_id,actual_dispatch_date,created) , write a SQL Query to find
**% orders shipped before first message date(OTIF)
**% orders shipped on first message date+1(OTIF+1)
**% orders shipped on first message date+2(OTIF+2)
**%orders shipped after that(OTIF+>2)


Order_Timeline contains the message for expected dispatch date, Order_shipment gives you the real dispatch date. They are combined using order_id.

Assumptions and Understanding
Percentage of orders needs to be computed for the 4 cases which are as follow:
##Orders with actual shipping date before the expected date received in the “Message”.
##Orders with actual shipping date between the expected date received in the “Message” and one day after the expected date.
##Orders with actual shipping date equal to 2 days after the the expected date received in the “Message”
##Orders with actual shipping date more than 2 days after the the expected date received in the “Message”
##Another Edge Case of orders which doesn't have any actual shipping date.
I have given two solutions and approach to proceed towards the problem.


Solution - 2



with order_timeline_base_table
as
(
select *,
if(actual_dispatch_date<expected,"OTIF",
    if(actual_dispatch_date between expected and date_add(expected,1),"`OTIF+1`",
        if(actual_dispatch_date = date_add(expected,2),"`OTIF+2`",
            if(actual_dispatch_date >date_add(expected,2),"`OTIF+>2`",
                 if(actual_dispatch_date is null,"No_Dispatch_Date",null))))) as flag
 
from
(
select *,substring_index(substring_index(message,'""',-2),'""',1) as expected,a.order_id as order_id1
from order_timeline as a
join order_shipment as b on a.order_id=b.order_id
)
),
 
Solution_1 as/*using conditional ifs for each part*/
(
select 
round((count(distinct(if(actual_dispatch_date<expected,order_id1,null)))/count(distinct order_id1))*100,2) as OTIF,
round((count(distinct(if(actual_dispatch_date between expected and date_add(expected,1),order_id1,null)))/count(distinct order_id1))*100,2) as `OTIF+1`,
round((count(distinct(if(actual_dispatch_date = date_add(expected,2),order_id1,null)))/count(distinct order_id1))*100,2) as `OTIF+2`,
round((count(distinct(if(actual_dispatch_date >date_add(expected,2),order_id1,null)))/count(distinct order_id1))*100,2) as `OTIF+>2`,
round((count(distinct if(actual_dispatch_date is null,order_id1,null))/count(distinct order_id1))*100,2) as Cases_not_shipped,
count(distinct order_id1)
 
from order_timeline_base_table
)
,
 
Solution_2 as /*using flag derived from a single if*/
(
select flag,
round((count(distinct(order_id1))/sum(count(distinct(order_id1)))over())*100,2) as percentage
from order_timeline_base_table
group by 1
)
select *
from Solution_2




Question - 3
A company record its employees movement In and Out of office in a table with 3 columns (Employee id, Action (In/Out), Created) There is NO sample data for this question. You only need to submit the queries

##First entry for each employee is “In”
##Every “In” is succeeded by an “Out”
##No data gaps and, employee can work across days

#Find number of employees inside the Office at current time
#Find number of employees inside the Office at “2019-05-01 19:05:00”
#Measure amount of hours spent by each employee inside the office since the day they started (Account for current shift if she/he is working)
#Measure amount of hours spent by each employee inside the office between “2019-04-01 14:00:00” and “2019-04-02 10:00:00”

Solution - 3 (1) and 3 (2)
/*3(1) */
/*total in- total out at any time would give the current employees inside the office*/
 
select
sum(sumin)-sum(sumout) as employees_present
from
(
select
employee_id,
action,
created,
sum(if(action="IN",1,0)) as sumin,
sum(if(action="OUT",1,0)) as sumout,
from employee_sheet
 
group by 1,2,3
)
; 

/*3(2) */
/*for a particular time*/
select
sum(sumin)-sum(sumout) as employees_present
from
(
select
employee_id,
action,
created,
sum(if(action="IN",1,0)) as sumin,
sum(if(action="OUT",1,0)) as sumout,
from employee_sheet
created<=“2019-05-01 19:05:00”
group by1,2,3
)
;



Solution - 3 (3)


with employee_base_table as
(
select
employee_id,
action,
created,
ifnull(lead(created)over(partition by employee_id order by created asc),current_timestamp()) as next_time,
/*if the employee is still inside the office then current time would be considered*/
from employee_sheet
),
 
employee_final_data as
(select
employee_id,
sum(hours)
from
(
select *,
  datediff(hour,created,next_time) as hours
  from employee_base_table
)
where action="IN"     /*only IN hours will be considered*/
group by 1
;



Solution - 3(4)
with employee_max as/*max created for each employee calculated*/
(
select 
employee_id,
max(created) as max_created
from table
group by 1
),
 
employee_one_view as
(
select *,
if(next_time>“2019-04-02 10:00:00”,“2019-04-02 10:00:00”,next_time) as final_next
/*limiting the upper limit of the time till the prescribed limit to avoid extra calculation*/
from
(
select
employee_id,
action,
if(b.max_created<“2019-04-01 14:00:00” and created=max_created and action="IN",“2019-04-01 14:00:00”,created) as final_created
/*considering the employees that are already inside the office before the prescribed limit*/
lead(created)over(partition by employee_id order by created asc) as next_time,
/*calculating the created time for next action*/
from employee_sheet as a
join employee_max as b on a.employee_id=b.employee_id
)
where final_created between     “2019-04-01 14:00:00” and “2019-04-02 10:00:00”
/*limiting the created within the prescribed limits after considering the corner cases*/
 
 
),
 
employee_final as/* final computation*/
(select
employee_id,
sum(hours) as max_hours
from
(
select *,
  datediff(hour,final_created,final_next) as hours
  from employee_one_view
)
where action="IN"
/*considering only “IN” hours*/
group by 1
  )
 
select *
from employee_final
;




Question - 4
Table: T1
(order id,amount,quantity,date,used ID)

Table: T2
(user ID,name,state,city)

Please write sql queries for below points

#MoM (month over month) growth of order from state of Gujarat
#which month of 2019 attributes Highest % change in total amount
#Write query of Point 1 with different logic and compare the performance

Note: You are allowed to make any assumption

Assumptions -
#Transactional data of only 1 year ( 12 month) is available i.e. 2019


Solution - 4(1) and 4(2)

with month_orders_amount as   /*max wise orders*/
(
select date_trunc('month', date) as month,
       state,
       count(distinct t1.order_id) as orders,
       sum(amount) as amount
from 
t1 t1
join
t2 t2 
on t1.user_id = t2.user_id
group by 1,2
order by 1,2
),
 
gujarat_orders as 
(
select
month,
sum(orders) as orders
from 
month_orders_amount
where state = 'Gujarat'
group by 1
),
 
 
growth_orders_month_on_month as /* previous month column using lag function for growth and growth percentage*/
(select 
month,
orders,
previous_month,
100 * ((orders) - (previous_month)) / (previous_month) as growth
100 * ((orders) - (previous_month)) / (previous_month) || '%' as growth_percentage
from 
(
select 
distinct
month,
orders,
lag(orders, 1) over month as previous_month
from gujarat_orders
)
)
 
select *
from growth_orders_month_on_month
  
 
----------------------------------------------   Using Above CTE we will be calculating Growth in Amount ----------------
 
 
 
With
change_in_amount_month_on_month as /* previous month column using lag function for growth and growth percentage*/
(select 
month,
amount,
previous_month,
100 * ((amount) - (previous_month)) / (previous_month) as change_in_amount
100 * ((amount) - (previous_month)) / (previous_month) || '%' as change_in_amount_percentage
from 
(
select 
distinct
month,
sum(amount) as amount,
lag(sum(amount), 1) over month as previous_month
from month_orders_amount
group by 1
order by 1       /* as we have order data of 2019, so no need to put year filter in where clause */
)
),
 
 
select distinct month
from
(select 
distinct momth, 
absolute_change,
RANK() OVER( ORDER BY absolute_change DESC) Rank_Change                    /* Here we have used Rank function, Limit and Order By can also be used to solve the same */
from
(select 
*, ABS(change_in_amount) as absolute_change    /* Change can either be Positive or Negative. Here we are taking ABS() function to get the absolute value  */
from change_in_amount_month_on_month
)
)
where Rank_Change = '1'





***For Different Logic to be used in 4(3) Two CTE function will be same and Instead of windows function LEAD, we will be using Joins to Get the previous month data as a colum value
Solution - 4(3)

with month_orders_amount as   /*max wise orders*/
(
select date_trunc('month', date) as month,
       state,
       count(distinct t1.order_id) as orders,
       sum(amount) as amount
from 
t1 t1
join
t2 t2 
on t1.user_id = t2.user_id
group by 1,2
order by 1,2
),
 
gujarat_orders as 
(
select
month,
sum(orders) as orders
from 
month_orders_amount
where state = 'Gujarat'
group by 1
),
 
 
 
growth_orders_month_on_month as /* previous month column using lag function for growth and growth percentage*/
(select 
month,
this_month_orders,
previous_month_orders,
100 * ((this_month_orders) - (previous_month_orders)) / (previous_month_orders) as growth
100 * ((this_month_orders) - (previous_month_orders)) / (previous_month_orders) || '%' as growth_percentage
from 
(
select 
distinct 
this_month.month as month,
this_month.orders as this_month_orders,
previous_month.orders as previous_month_orders
from
gujarat_orders as this_month
left join
gujarat_orders as previous_month
on this_month.month = ((previous_month.month) + 1)
)
)
 
select *
from growth_orders_month_on_month
;



Conclusion - 4(3)
For the assumption taken into consideration of transactional data of 1 year (2019), there is no significant change in the query execution time and performance is throughout the same. However, if we have more logical self joins compared to the windows function, - Windows functions is more advance where as Self joins are Brute Force. Unless we use the Indexing (Clustered/Non-Clustered), Windows functions will always win the race. Based on IO Statistics and Execution Plan -> More Parallel Processing along with Batching of Windows Aggregate Operator is required to get the Data in required format.


