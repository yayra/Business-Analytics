# **Cohort Analysis: Evaluating the Impact of Promotional Discounts on Retention**

<div style="text-align: justify;">

## Objective
This project examines the impact of a new customer acquisition strategy — offering promotional discounts (promocodes) to first-time shoppers — on customer retention.

Customer acquisition and retention are critical components of the AARRR Framework (Acquisition, Activation, Retention, Referral, Revenue), often referred to as the "Pirate Framework." Growth strategists, or "growth hackers," develop strategies to attract and retain customers while employing data-driven methods to evaluate their effectiveness.

The goal of this analysis is to determine whether providing a promocode to first-time customers increases their likelihood of remaining engaged with the business over time.

---

## Scope and Metrics
This project focuses on two key metrics of the AARRR Framework:

1. **Customer Acquisition**: Analyze the effectiveness of first-purchase promocode discount strategy in attracting new customers to the platform.
2. **Customer Retention**: Evaluate whether this strategy improves the retention rate of first-time customers over a 4-week period. 

---

## Test Scenario
The marketing team of an e-commerce platform introduced a promotional discount strategy by offering promocodes to first-time customers as a means of boosting customer acquisition. They now intend to assess the effectiveness of this approach through data-driven analysis to determine whether funding promocodes remains a worthwhile investment. Specifically, they aim to address the following question:

 - **Does providing promotional discounts to first-time customers result in higher retention rates compared to those who do not receive such discounts?**

### Key Assumptions and Scope
- The analysis is limited to determining the retention impact of the promocode strategy.
- Factors such as discount size, revenue generated, and other metrics are outside the scope of this project.

### Hypothesis
Customers who received a promocode discount for their first purchase exhibit higher retention rates than those who did not.

### Variables
- **Dependent Variable**: Customer retention rate (calculated cumulatively).
- **Independent Variable**:
  - Customers who used a promocode for their first purchase (1).
  - Customers who did not use a promocode for their first purchase (0).

---

## Test Setup
- **Sample Size**:
    The customers who made their first purchase during January 2024 will be divided into two cohorts:
     - **Cohort 1**: Customers who made their purchase with a promocode (denoted as 1) - 1,000 customers.
     - **Cohort 2**: Customers who made their purchase without a promocode (denoted as 0)- 1,000 customers.
- **Retention Measurement**: Weekly retention rates over four weeks following the first purchase.
- **Tools Used**
     - **MySQL**: Data cleaning, transformation, and retention calculation.
     - **Python**: Data manipulation with Pandas and visualization with Plotly.
---

## Analysis Workflow

### SQL Query and Data Visualization
- **Generate SQL queries** to calculate retention for each cohort.
- **Load the SQL output into Python** using the `mysql.connector` library.
- **Convert the output to a Pandas DataFrame**, calculate retention rates.
- **Visualize** the results using Python's Plotly library.

 ---
 
### **STEP 1**: Data Preparation and Analysis Using MySQL 
- **Exploration**: Clean and convert dataset columns (first_ord_dt, ord_dt) to appropriate date formats using SQL's `STR_TO_DATE()` function.
- **Week Number Assignment**: Calculate the purchase week using SQL's `DATE_ADD(column, INTERVAL [] DAY)` function.
- **Sequence Assignment**: Assign sequence numbers to purchases using the `ROW_NUMBER()` window function, partitioned by each customer.
- **Cumulative retention calculation**: Measure cumulative retention over four weeks using a cumulative retention method.

  The retention period for each customer is measured from the date of their first purchase (**Week 0**) through the end of a 4-week period (**Week 4**). Only customers who make 
  purchases in consecutive weeks are included in the retention calculation. For example, if a customer made their first purchase on January 1 and then made purchases in Weeks 1, 2, and 4, their retention will be included only for Weeks 1 and 2. Starting from Week 3, the customer's purchases are excluded from the retention calculation, even if they made a purchase in Week 4.
   
---
**MySQL Code Snippet**:
```sql
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

```

</div>

*Output:*

![SQL output](https://github.com/yayra/Business-Analytics/blob/9aa121bbb98931290aeca98a065e40b8c7ca4b48/Cohort-Analysis/images/Output.png)

<div style="text-align: justify;">
From the output, we can observe that the number of customers started at 1000 in both cohorts in <b>Week 0</b>, and as we calculate cumulative retention, the number of retained customers steadily decreased each week, forming a funnel. It is clear from the SQL output that the retention rate is much higher in the cohort of first-time customers who received a promocode discount compared to those who did not.

---

### **STEP 2**: Database Connection Setup
To access the SQL query output and generate graphical representations of the analysis results, the database connection will be established using the `mysql.connector` library.

---

### **STEP 6**: Data Transformation
After retrieving the SQL output, the data will be converted into a Pandas DataFrame, and a new column labeled **`retention`** will be added to reflect the retention rates.

---

### **STEP 7**: Data Visualization
The retention rate analysis results will be visualized using Python’s Plotly library, which provides interactive charts and graphs for clear insights.

---

## Cohort Analysis Findings 

![Result visualization](https://github.com/yayra/Business-Analytics/blob/60696cf0ecebb95c69f6c89b96e3c94105f00f97/Cohort-Analysis/images/Retention_rate_result.png)

- **Retention Trends**: The cohort receiving promocode discounts showed higher retention rates starting from Week 1, with retention rates consistently higher throughout the four-week period.
- **Conclusion**: The hypothesis that promocode discounts for first-time purchases lead to higher retention was supported by the data.
- **Recommendation**: Continue offering first-purchase promocode discounts as part of the customer acquisition strategy.

</div>
