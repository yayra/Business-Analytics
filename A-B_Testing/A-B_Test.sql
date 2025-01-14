use portfolio;

select* from order_master_did;
select* from coupon_target_table;

-- CNT of customers in each group
select group_class, count(*)
from coupon_target_table
group by group_class;

-- Joining 2 tables
select*
from coupon_target_table c
left join order_master_did o on c.mem_no = o.mem_no;

-- Assigning 'before treatment' and 'after treatment' period for each group
select c.mem_no, 
       c.group_class,
       o.ord_dt,
       case when o.ord_dt between '05-06-2024' and '12-06-2024' then 'before treatment'
            when o.ord_dt between '12-06-2024' and '19-06-2024' then 'after treatment' end as period
 from coupon_target_table c
 left join order_master_did o on c.mem_no = o.mem_no;

-- DiD analysis
with T1 as(
         select c.mem_no, 
                c.group_class,
                o.ord_dt,
                case 
	              when o.ord_dt between '05-06-2024' and '12-06-2024' then 'before treatment'
                  when o.ord_dt between '12-06-2024' and '19-06-2024' then 'after treatment' end as period
         from coupon_target_table c
         left join order_master_did o on c.mem_no = o.mem_no
           )
select group_class,
       period,
       count(distinct mem_no) as ord_cnt
from T1
where period is not null
group by 1, 2;
