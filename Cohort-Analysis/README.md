# **Cohort Analysis: Evaluating the Impact of Promotional Discounts on Retention for First-Time Shoppers**

<div style="text-align: justify;">

## Objective
This project examines the impact of a new customer acquisition strategy—offering promotional discounts (promocodes) to first-time shoppers—on customer retention.

Customer acquisition and retention are critical components of the AARRR Framework (Acquisition, Activation, Retention, Referral, Revenue), often referred to as the "Pirate Framework." Growth strategists, or "growth hackers," develop innovative approaches to attract and retain customers while employing data-driven methods to evaluate their effectiveness.

The goal of this analysis is to determine whether providing a promocode to first-time customers increases their likelihood of remaining engaged with the business over time.

---

## Scope and Metrics
This project focuses on two key metrics of the AARRR Framework:

1. **Acquisition**: Assess the effectiveness of using first-purchase promocode discounts in attracting new customers.
2. **Retention**: Evaluate whether this strategy improves the retention rate of first-time customers over a 4-week period.

---

## Test Scenario
The marketing team of an e-commerce platform introduced a promocode discount for first-time customers to increase acquisition. They aim to answer:
- Does offering promotional discounts to first-time customers lead to higher retention compared to not offering them?

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
  - 1,000 customers who made their first purchase with a promocode.
  - 1,000 customers who made their first purchase without a promocode.
- **Test Period**: First-time purchases during January 2024.
- **Retention Measurement**: Weekly retention rates over four weeks following the first purchase.

---

## Analysis Workflow

### Step 1: Data Preparation
- **Exploration**: Clean and convert dataset columns (first_ord_dt, ord_dt) to appropriate date formats using SQL's `STR_TO_DATE()` function.
- **Week Number Assignment**: Calculate the purchase week using SQL's `DATE_ADD()` function.
- **Sequence Assignment**: Assign sequence numbers to purchases using the `ROW_NUMBER()` window function, partitioned by each customer.

### Step 2: Cumulative Retention Calculation
- **Define two cohorts**:
  1. Customers with promocode (Cohort 1).
  2. Customers without promocode (Cohort 2).
- **Measure retention over four weeks using a cumulative retention method**. Customers who fail to make consecutive purchases are excluded from subsequent weeks.

### Step 3: SQL Query and Data Visualization
- **Generate SQL queries** to calculate retention for each cohort.
- **Load the SQL output into Python** using the `mysql.connector` library.
- **Convert the output to a Pandas DataFrame**, calculate retention rates, and visualize the results using Python's Plotly library.

---

## Findings
- **Retention Trends**: The cohort receiving promocode discounts showed higher retention rates starting from Week 1, with retention rates consistently higher throughout the four-week period.
- **Conclusion**: The hypothesis that promocode discounts for first-time purchases lead to higher retention was supported by the data.
- **Recommendation**: Continue offering first-purchase promocode discounts as part of the customer acquisition strategy.

---

## Tools Used
- **SQL**: Data cleaning, transformation, and retention calculation.
- **Python**: Data manipulation with Pandas and visualization with Plotly.
## Test’s Logic

### **STEP 1**: Customer Cohort Division
The customers who made their first purchase during January 2024 will be divided into two cohorts:
- **Cohort 1**: Customers who made their purchase with a promocode (denoted as 1).
- **Cohort 2**: Customers who made their purchase without a promocode (denoted as 0).

The retention period for each customer will be measured based on subsequent purchases after their first purchase date (denoted as **Week 0**) and until the end of a 4-week period (denoted as **Week 4**). This 4-week period after the first purchase will be divided into 4 weeks, each lasting 7 days.

**Note**: Multiple purchases during the same week will be counted as 1 purchase.

### **STEP 2**: Sequence Numbering & Retention Calculation
Sequence numbering will be applied to every order after the first order for cumulative order confirmation. Since we are using a cumulative retention method, only customers who made at least one purchase each consecutive week will be included in the calculation.

For example, if a customer made their first purchase on January 1 and then made purchases in the first, second, and fourth weeks after the first purchase, their retention will only be included in the first and second week’s retention. They will no longer be considered in the retention calculation from Week 3 onwards, even though they made a purchase in Week 4.

---

## Workflow

### **STEP 1**: Data Exploration
The first step is to explore the datasets. The data type of the **`first_ord_dt`** and **`ord_dt`** columns will be converted from `varchar` to `date` using the `STR_TO_DATE(column, '%d/%m/%Y')` function.

### **STEP 2**: Week Number Assignment
The week number of each purchase will be determined using the `DATE_ADD(column, INTERVAL [] DAY)` function.

### **STEP 3**: Sequence Assignment
A sequence will be assigned to each purchase, grouped by week number, using the `ROW_NUMBER()` window function partitioned by each customer.

### **STEP 4**: Cumulative Retention Calculation
To measure cumulative retention over 4 consecutive weeks, the number of customers retained will be summed up, grouped by cohort and week range.

**MySQL Code Snippet**:
```sql
-- Example SQL code for calculating cohort retention
SELECT cohort, week_range, COUNT(DISTINCT customer_id) AS retained_customers
FROM retention_data
GROUP BY cohort, week_range;
```
</div>

<div style="text-align: justify;">
From the output, we can observe that the number of customers started at 1000 in both cohorts in **Week 0**, and as we calculate cumulative retention, the number of retained customers steadily decreased each week, forming a funnel. It is clear from the SQL output that the retention rate is much higher in the cohort of first-time customers who received a promocode discount compared to those who did not.

---

### **STEP 5**: Database Connection Setup
To access the SQL query output and generate graphical representations of the analysis results, the database connection will be established using the `mysql.connector` library.

---

### **STEP 6**: Data Transformation
After retrieving the SQL output, the data will be converted into a Pandas DataFrame, and a new column labeled **`retention`** will be added to reflect the retention rates.

---

### **STEP 7**: Data Visualization
The retention rate analysis results will be visualized using Python’s Plotly library, which provides interactive charts and graphs for clear insights.

---

## **Cohort Analysis Result Summary**
- The cohort that was provided with a promocode discount showed higher retention starting from the first week onwards.
- Based on the analysis, the hypothesis that customers who received a promocode discount for their first purchase would have higher retention is supported.
- The decision was made to continue offering the first-purchase promocode discount as part of the customer acquisition strategy.

</div>
