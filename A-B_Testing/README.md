# Evaluating the Impact of Discount Coupon Types on Order Conversion Rates: *A/B Testing with Difference-in-Differences (DiD) Method*

## Background
<p align="justify">In the competitive world of online business, customer retention and order conversion rates are critical objectives for e-commerce companies. A widely used strategy to achieve these goals is offering discount coupons. These incentives help keep customers engaged and encourage them to place orders, ultimately driving higher conversion rates. Discount coupons typically come in two main forms: fixed-amount discounts and percentage-off discounts. This project aims to answer the following question: Which type of discount coupon yields a higher order conversion rate: a <b>50,000 UZS fixed amount discount</b> or a <b>5% off discount</b>?</p>

## Test Scenario
<p align="justify"> The Marketing Department of an e-commerce platform in Uzbekistan is particularly interested in determining which of these two discount strategies is more effective in driving order conversion rates. To assess this, they have implemented an <b>A/B testing</b> and utilized the <b>Difference-in-Differences (DiD)</b> methodology to measure the impact of the two coupon types while excluding potential confounding variables and underlying trends that could affect the results.</p>

### 1. Test Participants (300 in total)
The test involves a total of 300 customers of the e-commerce website, divided into two groups:
- **Control group**: 100 customers who did not receive any discount coupons during the testing period.
- **Treatment group**: 200 customers who received one of the two types of discount coupons:
    - 100 customers: *50,000 UZS fixed amount discount* coupon;
    - 100 customers: *5% off discount* coupon (with a maximum discount of 70,000 UZS).

**Note**: *Discount coupons were offered only to customers who made purchases exceeding 1 million UZS in the month preceding the test.* 

The following table summarizes the setup:

| Group classification | Discount Type                           | Number of Customers |
|---------------------|-----------------------------------------|---------------------|
| Control Group       | No discount                             | 100                 |
| Treatment Group 1   | 50,000 UZS fixed amount discount        | 100                 |
| Treatment Group 2   | 5% off discount coupon (up to 70,000 UZS)| 100                |

### 2. Budget Allocated for Conducting the A/B Test
The Marketing Department secured a budget of no more than **1,000 USD (approximately 12 million UZS)**, which was allocated as follows:
- **5 million UZS** for 100 coupons offering a 50,000 UZS fixed amount discount;
- **7 million UZS** for 100 coupons offering a 5% off discount, with a maximum discount cap of 70,000 UZS per coupon.

### 3. Test Period
<p align="justify">The A/B test was conducted from <b>June 5 to June 18, 2024</b>, with both types of discount coupons being distributed on June 12, 2024.</p>
The timeline is as follows: 

- June 5–11, 2024: Pre-treatment period;
- June 12, 2024: Treatment date (coupon distribution);
- June 12–18, 2024: Post-treatment period.

### 4. Hypothesis testing
*Fixed amount discount* coupon (50,000 UZS) will result in a higher order conversion rate compared to the *5% off discount* coupon.

### 5. Dependent Variable
<p align="justify">The dependent variable in this study is the <b>order conversion rate (CVR)</b>, defined as the proportion of customers who placed at least one order either before or after the treatment period(recorded as 1).</p>

### 6. Independent Variable
The independent variable is the type of discount coupon provided:
- 50,000 UZS fixed amount discount coupon;
- 5% off discount coupon.

### 7. A/B Testing Evaluation Method – Difference-in-Differences (DiD)
<p align="justify">The <b>Difference-in-Differences (DiD)</b> method measures the change in order conversion rates for the treatment group before and after the treatment, as well as the change in order conversion rates for the control group over the same period. By comparing these changes, DiD isolates the effect of the other variables which can affect the order conversion rate.</p>

The formula for calculating the DiD is as follows:

**DiD = (𝐴 − 𝑎 ) − (𝐵−𝑏)**

<p>Where:</p>
<div style="line-height: 1.2; margin-bottom: 15px;">
    𝑎 = count of distinct customers in the treatment group who made purchases before the treatment period;<br>
    A = count of distinct customers in the treatment group who made purchases after the treatment period;<br>
    𝑏 = count of distinct customers in the control group who made purchases before the treatment period;<br>
    𝐵 = count of distinct customers in the control group who made purchases after the treatment period.
</div>

<p align="justify"><b>Note</b>: This analysis focuses on the application of the DiD methodology in A/B testing within the scenario of a limited budget, which the Marketing Department was able to secure for executing the test, not exceeding 1,000 USD (12 million UZS).</p>

### 8. About the Dataset

<p align="justify">The dataset used for this project consists of two files: *order_master_did.csv* and *coupon_target_table.csv*. Below is the metadata for each dataset:</p>

#### **Coupons Dataset**

<p align="justify">This dataset contains information about the distribution of discount coupons and includes the following columns:</p>
<ul>
    <li><b>mem_no</b>: Unique customer ID (primary key), datatype: int;</li>
    <li><b>cpn_nm</b>: Type of distributed coupon (5% off coupon or 50,000 UZS fixed amount coupon), datatype: varchar(50);</li>
    <li><b>cpn_available_amt</b>: Minimum purchase amount required to use the coupon (1,000,000 UZS), datatype: varchar(50);</li>
    <li><b>cpn_issued_dt</b>: The date the coupons were issued (12 June 2024), datatype: varchar(50);</li>
    <li><b>group_class</b>: Group classification for A/B testing, datatype: varchar(50):  
        <ul>
            <li>CONTROL: Control group (did not receive any coupons);</li>
            <li>TEST1_percent: Treatment group that received a 5% off coupon;</li>
            <li>TEST1_fixed: Treatment group that received a 50,000 UZS fixed amount coupon.</li>
        </ul>
    </li>
</ul>

![SQL Query](https://github.com/yayra/Business-Analytics/blob/78b7fdadbcd7a8cdb8018888bba69e2b3f08aa3a/A-B_Testing/images/coupons.png) 

#### **Orders Dataset**

<p align="justify">This dataset provides details about customer orders and includes the following columns:</p>
<ul>
    <li><b>mem_no</b>: Customer ID (foreign key), datatype: int.</li>
    <li><b>ord_no</b>: Unique order ID, datatype: int.</li>
    <li><b>ord_dt</b>: Date the order was placed, datatype: varchar(50).</li>
</ul>

![SQL Query](https://github.com/yayra/Business-Analytics/blob/78b7fdadbcd7a8cdb8018888bba69e2b3f08aa3a/A-B_Testing/images/orders.png)

### 9. Tools Used
<p align="justify"><b>MySQL</b> will be utilized for data exploration and to conduct the A/B testing.</p>

*SQL Code Snippet with DiD analysis* 

![SQL Query](https://github.com/yayra/Business-Analytics/blob/78b7fdadbcd7a8cdb8018888bba69e2b3f08aa3a/A-B_Testing/images/SQL_code.png)

*Output:* 

![SQL Query](https://github.com/yayra/Business-Analytics/blob/78b7fdadbcd7a8cdb8018888bba69e2b3f08aa3a/A-B_Testing/images/output.png)

### 10. A/B Test Result
<p align="justify">The results of the A/B test are summarized in the table below, highlighting the changes in CVR (order conversion rate) for each group during the 'before' and 'after' treatment periods.</p>

![SQL Query](https://github.com/yayra/Business-Analytics/blob/78b7fdadbcd7a8cdb8018888bba69e2b3f08aa3a/A-B_Testing/images/DiD_result.png)

<p align="justify">
The analysis comparing the 'before' and 'after' treatment periods with the DiD method highlights significant changes in order conversion rates (CVR) across groups. The following observations were made:
</p>

<ul>
    <li>The control group experienced a <b>7% decrease</b> in order CVR during the test period.</li>
    <li>The <b>50,000 UZS fixed-amount coupon</b> led to an <b>11% increase</b> in order CVR compared to the control group.</li>
    <li>The <b>5% off coupon</b> demonstrated a <b>17% increase</b> in order CVR relative to the control group, outperforming the fixed-amount coupon.</li>
</ul>

<p align="justify">
Although the <b>5% off coupon</b> resulted in a higher CVR increase compared to the fixed-amount coupon, the <b>6% difference</b> between the two treatment groups is relatively modest.
</p>

<p align="justify">
The initial hypothesis suggested that the <b>fixed-amount discount (50,000 UZS)</b> would yield a higher CVR than the <b>5% off coupon</b>. However, the observed <b>6% difference</b>, as revealed by the DiD analysis, suggests otherwise, indicating that the initial hypothesis may not hold based on the available data and test results.
</p>

<p align="justify">
While this study focuses primarily on CVR, other business metrics—such as average purchase value—should also be considered to guide decisions regarding the optimal coupon type. Nevertheless, the analysis strongly supports the overarching conclusion that <b>offering discounts, regardless of their structure, consistently improves CVR compared to providing no discounts at all</b>.
</p>





