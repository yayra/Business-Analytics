use portfolio;

select* from first_ord_table;
select* from order_master_cohort;

-- Count of rows 
select count(*)
from first_ord_table;

-- -- Count of rows 
select count(*)
from order_master_cohort;

-- Count of members of the each cohort
select is_promotion, count(*)
from first_ord_table
group by is_promotion;

-- Check the dates of first orders. They should be within January 2024.
select first_ord_dt, count(*)
from first_ord_table
group by first_ord_dt
order by first_ord_dt;

-- Join tables
select* 
from first_ord_table fot
left join order_master_cohort omc on fot.mem_no = omc.mem_no;


-- Change the datatype from varchar into date      
update first_ord_table
set first_ord_dt = str_to_date(first_ord_dt, '%d/%m/%Y');

update order_master_cohort
set ord_dt = str_to_date(ord_dt, '%d/%m/%Y');

-- Data aggregation for cohort analysis
select distinct 
       fot.mem_no,
       is_promotion,
       case
           when ord_dt = first_ord_dt then 0 -- The first purchase (week 0)
           when ord_dt > first_ord_dt and ord_dt <= date_add(first_ord_dt, interval 7 day) then 1 -- Purchases within the first week
           when ord_dt > date_add(first_ord_dt, interval 7 day) and ord_dt <= date_add(first_ord_dt, interval 14 day) then 2 -- Purchases within the second week
           when ord_dt > date_add(first_ord_dt, interval 14 day) and ord_dt <= date_add(first_ord_dt, interval 21 day) then 3 -- Purchases within the third week
           when ord_dt > date_add(first_ord_dt, interval 21 day) and ord_dt <= date_add(first_ord_dt, interval 28 day) then 4 -- Purchases within the fourth week
           else null
       end as week_number
from first_ord_table fot
left join order_master_cohort omc 
    on fot.mem_no = omc.mem_no;

with 
T1 as(
	select distinct fot.mem_no,
	       is_promotion,
	       case
	           when ord_dt = first_ord_dt then 0 -- The first purchase (week 0)
	           when ord_dt > first_ord_dt and ord_dt <= date_add(first_ord_dt, interval 7 day) then 1 -- Purchases within the first week
	           when ord_dt > date_add(first_ord_dt, interval 7 day) and ord_dt <= date_add(first_ord_dt, interval 14 day) then 2 -- Purchases within the second week
	           when ord_dt > date_add(first_ord_dt, interval 14 day) and ord_dt <= date_add(first_ord_dt, interval 21 day) then 3 -- Purchases within the third week
	           when ord_dt > date_add(first_ord_dt, interval 21 day) and ord_dt <= date_add(first_ord_dt, interval 28 day) then 4 -- Purchases within the fourth week
	           else null
	       end as week_number
	from first_ord_table fot
	left join order_master_cohort omc 
	     on fot.mem_no = omc.mem_no
)
select mem_no,
       is_promotion,
       week_number,
       row_number() over(partition by mem_no order by week_number) as seq
from T1
where week_number is not null
order by 1,2,3,4;
	

with 
T1 as(
	select distinct fot.mem_no,
	       is_promotion,
	       case
	           when ord_dt = first_ord_dt then 0 -- The first purchase (week 0)
	           when ord_dt > first_ord_dt and ord_dt <= date_add(first_ord_dt, interval 7 day) then 1 -- Purchases within the first week
	           when ord_dt > date_add(first_ord_dt, interval 7 day) and ord_dt <= date_add(first_ord_dt, interval 14 day) then 2 -- Purchases within the second week
	           when ord_dt > date_add(first_ord_dt, interval 14 day) and ord_dt <= date_add(first_ord_dt, interval 21 day) then 3 -- Purchases within the third week
	           when ord_dt > date_add(first_ord_dt, interval 21 day) and ord_dt <= date_add(first_ord_dt, interval 28 day) then 4 -- Purchases within the fourth week
	           else null
	       end as week_number
	from first_ord_table fot
	left join order_master_cohort omc 
	     on fot.mem_no = omc.mem_no
),
T2 as(
	select mem_no,
	       is_promotion,
	       week_number,
	       row_number() over(partition by mem_no order by week_number) as seq
	from T1
	where week_number is not null
	order by 1,2,3,4
)
select is_promotion, -- cohort of customers (who made their purchse with promocode discount/without promocode discount)
       case
       	when week_number = 0 then 'w-0'
       	when week_number = 1 and seq = 2 then 'w-1'
       	when week_number = 2 and seq = 3 then 'w-2'
       	when week_number = 3 and seq = 4 then 'w-3'
       	when week_number = 4 and seq = 5 then 'w-4'
       end as week_range, 
       count(mem_no) as cust_cnt
from T2
group by 1, 2
having week_range is not null
order by 1, 2;
