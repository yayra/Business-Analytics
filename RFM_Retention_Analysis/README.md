# **RFM-Based Customer Segmentation and Retention Analysis**
<a href="https://colab.research.google.com/drive/10C29RftA01msJso34xqJ6UyC9uyGmpuf?usp=sharing" target="_blank">Open in Colab via the provided link to explore interactive visualizations created with Plotly.</a>

<div style="text-align: justify">

The Recency, Frequency, and Monetary (RFM) model is widely adopted by e-commerce businesses to segment customers based on their past purchasing behavior. This model categorizes customers into groups with similar purchasing patterns, helping businesses tailor their marketing strategies and improve customer retention.

The RFM model evaluates customers based on 3 key quantitative factors:

•	**Recency (R)**: The number of days since the last purchase.

•	**Frequency (F)**: The total number of purchases made.

•	**Monetary (M)**: The total monetary value of purchases.

Each customer is ranked within these factors, typically on a scale of 1 to 5, where a higher score indicates a greater likelihood of continued engagement with the business. Customers with higher RFM scores are considered more valuable and are more likely to make repeat purchases.

---

## Project Overview
In this project, I will assess customer value using the RFM model by segmenting customers into *percentiles* and calculating a total RFM score by applying weights derived from *logistic regression coefficients*. Additionally, an *analysis of churned customers* will be conducted to uncover behavioral patterns and derive actionable insights for improving retention strategies

---

## Project Scenario
An e-commerce platform has a database of **1,000 customers** who made purchases in **January 2024**. The objective is to segment customers based on their RFM values, analyze the behavior of churned customers, and provide actionable recommendations to improve customer retention.

•	**Dependent variable**: Customer retention status (1 = Returned, 0 = Churned).

•	**Independent variables**: RFM values (Recency, Frequency, and Monetary).

---

## Dataset Overview

The dataset includes the following attributes:

•	*mem_no*: Unique customer identifier

•	*recency*: Number of days since the last purchase

•	*frequency*: Total number of orders placed

•	*monetary*: Average order value

•	*is_back*: Customer retention status (0 = Churned, 1 = Returned)

---

## Tool

**Python Libraries**: NumPy, pandas, Plotly, scikit-learn 

---

## RFM Analysis Workflow

**Step 1: Data Cleaning and Outlier Handling**

**Step 2: Exploratory Data Analysis (EDA)**

**Step 3: Data Preparation for Logistic Regression Model**

•	**Correlation Analysis**: Evaluate the correlation between independent variables (RFM metrics) to detect potential multicollinearity issues.

•	**Variance Inflation Factor (VIF)**: Quantify the degree of multicollinearity to make decision either remove redundant variables or leave them.

•	**Data Stratification**: Ensure proportional representation of the dependent variable across training and testing datasets to avoid biased model performance.

•	**Feature Scaling**: Apply standard scaling using StandardScaler to normalize feature values and bring all independent variables to a common scale.

•	**Regularization**: Implement *L2* regularization (Ridge) to prevent overfitting and effectively handle multicollinearity. The logistic regression model is configured with the *‘lbfgs’* solver, known for its efficiency in handling small datasets, and the *maximum number of iterations* is set to *500* to ensure convergence.

**Step 4: Model Development and Coefficient Extraction**

•	Train the logistic regression model to predict customer retention and obtain the regression coefficients for RFM variables.

**Step 5: RFM Score Normalization**

•	Convert each RFM value into *percentiles* to standardize the scoring across all customers to ensure consistency in comparisons.

**Step 6: Total RFM Score Calculation**

•	Compute the total RFM score using the following weighted formula based on logistic regression coefficients:

**Total Score**= *(Recency Score×Regression Coefficient)+(Frequency Score×Regression Coefficient)+(Monetary Score×Regression Coefficient)*

**Step 7: Customer Segmentation Based on Total RFM Score**

Customers were divided into five score categories based on their standardized total RFM scores:

  • **Category 1**: Best Customers – Highest Engagement.
  
  • **Category 2**: Loyal Customers.
  
  • **Category 3**: (Potential Loyal Customers)
    
  • **Category 4**: At-Risk Customers.
  
  •	**Category 5**: Lost Customers.

---

## RFM Analysis Results and Recommendations 

![Retention, monetary output](https://github.com/yayra/Business-Analytics/blob/32659452e904f40858ab4b6dbf5338a04f565cb3/RFM_Retention_Analysis/images/Retention%2C%20Monetary.png)


![Recency, Frequency output](https://github.com/yayra/Business-Analytics/blob/32659452e904f40858ab4b6dbf5338a04f565cb3/RFM_Retention_Analysis/images/Recency%2C%20Frequency.png)



**Customer Segmentation Insights:**

**1.	Category 1 – Best Customers (Highest Engagement)**

   •	**Retention Rate**: 76% (highest among all categories).
      
   •	**Insights**: These customers demonstrate the most frequent interactions with the platform, with an average purchase frequency of 4 purchases per month.
      
   •	**Recommendation**: Implement loyalty programs, exclusive offers, and personalized marketing strategies to further enhance engagement and reward their loyalty.

**2. Category 2 – Loyal Customers**

   •	**Retention Rate**: 59%.
   
   •	**Insights**: Customers in this category have a relatively high engagement rate but show potential for increased frequency and spending.
   
   •	**Recommendation**: Encourage repeat purchases through targeted promotions, early access to sales, and personalized recommendations based on past behavior.
   
**3.	Category 3 – Potential Loyal Customers**

   •	**Retention Rate**: 46%.
   
   •	**Insights**: Customers in this category exhibit the highest median purchase value of 274,000 UZS, indicating a preference for higher-value goods compared to other segments. However, their purchasing behavior demonstrates significant variability, suggesting inconsistency in buying patterns. With an average purchase frequency of 2 times and a recency of 16 days, these customers may be at an increased risk of churn.
   
   •	**Recommendation**: Focus on retention strategies such as personalized follow-ups, timely reminders, and tailored promotional incentives for high-end products to encourage repeat purchases and foster customer loyalty.
   
**4.	Category 4 – At-Risk Customers**

   •	**Retention Rate**: 8% (extremely low).
   
   •	**Insights**: These customers exhibit a high average recency of 24 days, indicating reduced engagement. Additionally, they have the lowest median purchase value among all categories, amounting to 229,000 UZS.
   
   •	**Recommendation**: Deploy re-engagement campaigns, such as personalized email marketing and time-sensitive offers, to bring them back to the platform. Conduct customer satisfaction surveys to identify potential barriers to retention.
   
**5.	Category 5 – Lost Customers**

  •	 **Retention Rate**: 0%.
  
  •	 **Insights**: These customers have completely disengaged from the platform. Efforts to reactivate them should be prioritized based on their past purchasing patterns and potential value.
  
  •	 **Recommendation**: Run win-back campaigns with strong incentives, such as discounts or exclusive promotions, and analyze their previous interactions to tailor outreach efforts effectively.

---

**Overall Behavioral Insights**:

•	The average purchase value among all retained customers is **266,000 UZS**, with the highest median purchase value observed in **Category 3**. This suggests that although Category 3 customers spend more per transaction, they may require targeted engagement to increase frequency.

•	Customers in **Category 1** exhibit the highest purchase frequency, averaging **4 purchases per month**, but demonstrate lower spending power in terms of average monetary value per transaction.

•	Customers in **Categories 3 and 4**, which have the **lowest retention rates**, show higher recency values (**16 and 24 days**, respectively), suggesting a longer duration since their last purchase and an increased likelihood of churn.

---

## Churn Analysis Results and Recommendations

![Churn analysis output](https://github.com/yayra/Business-Analytics/blob/6918e0e0509b1e53fe4cd66432adaebef84d78be/RFM_Retention_Analysis/images/Churn_Rate.png)

**1. Key Findings**

The analysis of churned customers reveals a strong correlation between lower RFM score categories and higher churn rates. Specifically:

•	**Category 1 (Best Customers - Highest Engagement)**: Churn rate of 24%.

• **Category 2 (Loyal Customers)**: Churn rate of 41%.

• **Category 3 (Potential Loyal Customers)**: Churn rate of 54%.

• **Category 4 (At-Risk Customers)**: Churn rate of 92%.

• **Category 5 (Lost Customers)**: 100% churn rate.

Insights derived from logistic regression coefficients indicate that recency and frequency are the most significant factors influencing churn:

• **Impact of Recency**: Higher recency values (longer gaps since the last purchase) are strongly associated with an increased likelihood of churn. Customers in categories 4 and 5 had an average recency of 29 and 30 days, respectively, indicating prolonged inactivity before churn.

• **Impact of Frequency**: Lower purchase frequency correlates with higher churn rates. Customers in categories 4 and 5 made, on average, only one purchase before discontinuing their engagement with the platform.

---

**2. Monetary Analysis**

A deeper examination of spending patterns among churned customers highlights the following insights:

**Total Spending Contribution**: Customers in **Category 4** (359 individuals) collectively contributed over **120 million UZS**, representing a significant portion of total revenue.

**Average Spending**: Customers in **Category 4** had a median total spending of **299,000 UZS**, higher than other segments, indicating a tendency to purchase higher-value items.

**Spending Volatility**: The spending standard deviation for **Category 4** was **180,000 UZS**, reflecting significant variability in purchase amounts.

Further analysis shows that churned customers in **Categories 4 and 5** typically made only one purchase, with notable differences in spending behavior:

• **Category 4**: Median purchase amount of **299,000 UZS**, indicating preference for higher-value products but a lack of repeat purchases.

• **Category 5**: Median purchase amount of **179,000 UZS**, the lowest among all segments, suggesting a preference for lower-cost products before churn.

**Category 1** customers (Best Customers - Highest Engagement) represent a crucial segment with a relatively high retention rate of 76%, yet a churn rate of 24% remains. 
On average, they made **4 purchases per month** and spent **282,000 UZS** per transaction. This suggests an opportunity to further strengthen loyalty through targeted engagement initiatives.

---

**3. Inferences and Business Implications**

Based on the churn analysis, the following key conclusions and strategic implications can be drawn:

**Churn Risk Factors**:

Customers with higher recency and lower frequency values are at a significantly higher risk of churn.

High-spending, low-frequency customers (Category 4) may have unmet expectations or experience dissatisfaction after their initial purchase, requiring improved post-purchase engagement strategies.

Increased volatility in spending behavior suggests irregular purchasing patterns, highlighting the need for personalized engagement and targeted communication.

---

**4. Retention Strategy Recommendations**:

To mitigate churn and improve customer retention, the following strategic actions are recommended:

  **1. Enhanced Customer Engagement**:

  •  Implement targeted re-engagement campaigns (e.g., personalized emails, push notifications) within the first 30 days of inactivity.
  
  •  Leverage loyalty programs to incentivize repeat purchases.
     
  **2. Improved Customer Onboarding**:
  
  •  Offer guided onboarding experiences and proactive support to ensure a positive first-time purchase experience.
  
  **3. Tailored Promotions and Discounts**:
  
  •  Introduce exclusive offers based on purchasing patterns to encourage repeat transactions.
    
  •  Offer discounts or bundles on high-value products to increase purchase frequency.
     
  **4. Customer Feedback and Analysis**:
  
  •  Conduct surveys or collect feedback from churned customers to identify potential service or product gaps.
     
  **5. Improved Customer Experience**: 
  
  •  Address potential pain points by enhancing customer service, optimizing the checkout process, and offering post-purchase support to boost satisfaction and reduce churn risk.

</div>
