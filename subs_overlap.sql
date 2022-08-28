use world;
-- making the table in the world database

-- following code will create the database
create table subscriptions(
user_id int,
start_date date,
end_date date,
primary key (user_id)
);

-- i made a mistake using the datetime for the start date end date columns.
-- so the following code will alter the table and modify the column data type. 

alter table subscriptions
modify column  -- this is a default column
start_date date;  -- then we have to mention the column

-- likewise, we will have to change the datatype for end_date column as well. 

alter table subscriptions
modify column 
end_date date ;  


-- we will not insert the values


Insert into subscriptions
Values (1, '2019-01-01', '2019-01-31'), 
(2, '2019-01-15', '2019-01-17'),
(3, '2019-01-29', '2019-02-04'), 
(4, '2019-02-05', '2019-02-10');

-- we want to see the feedback of our work. 
desc subscriptions;

select *
from subscriptions;

/* this is where you will fimd the sql question 
https://www.interviewquery.com/questions/subscription-overlap
 */

with overlapping as
(select 
s1.user_id as first_user, 
s2.user_id as second_user,
s1.start_date, 
s2.end_date
from
subscriptions as s1
cross join subscriptions as s2

/* we will use the cross join because 
it will join the tables on all combinations 
using, in our case we will have total 12 combinations (4X4) cross
later we will remove the same userid from the table, 
we will later only keep the user ids where subscription
days overlap */

where s1.user_id != s2.user_id
and ((s2.start_date between s1.start_date and s1.end_date) 
OR (s2.end_date between s1.start_date and s1.end_date))
),

distinct_user as 
(select first_user from overlapping
union
select second_user from overlapping)


select user_id, 
case when user_id = first_user then '1' else '0' end as overlap
from subscriptions 
Left join distinct_user 
on user_id = first_user; 






/* will not work now but will work later

this is not a part of the code. This will only 
help us understand the code */
select *
from distinct_user; 



