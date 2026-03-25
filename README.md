Customer Churn Analysis
SQL Server | Power BI | DAX
This project analyzes telecom customer churn behavior to identify high-risk segments, quantify revenue impact, and provide actionable business recommendations.

The goal is to move beyond basic reporting and enable *data-driven decision-making for customer retention*.

##  Business Problem
Telecom companies face significant revenue loss due to customer churn. However, most analysis is reactive — identifying churn after it happens.

This project focuses on:
- Identifying customers likely to churn
- Understanding key drivers of churn
- Quantifying revenue impact
- Enabling proactive retention strategies

---

##  Dataset Information

| Detail | Information |
|--------|-------------|
| Dataset Name | Telco Customer Churn |
| Source | Kaggle.com |
| Link | https://www.kaggle.com/datasets/blastchar/telco-customer-churn |
| Total Records | 7,043 customers |
| Total Columns | 21 columns |
| File Format | CSV |

### Columns in Dataset
| Column | Description |
|--------|-------------|
| CustomerID | Unique customer ID |
| Gender | Male or Female |
| SeniorCitizen | 1=Senior 0=Non Senior |
| Partner | Has partner Yes/No |
| Dependents | Has dependents Yes/No |
| Tenure | Months with company |
| InternetService | DSL/Fiber/No |
| Contract | Monthly/1yr/2yr |
| PaymentMethod | Payment type |
| MonthlyCharges | Monthly bill amount |
| TotalCharges | Total amount paid |
| Churn | Yes=Churned No=Retained |

---

## Data Preparation

### Step 1 — Data Understanding
- Loaded CSV data into SQL Server
- Analyzed all 21 columns
- Identified null values
- Understood data types

### Step 2 — SQL Analysis Queries
Ran analysis queries BEFORE
building dashboards to prove
which segments have highest churn:

Query 1 — Payment Method Analysis
Result:
Electronic Check = 45.29% ← HIGHEST

Query 2 — Contract Analysis
Result:
Month-to-month = 42.71% ← HIGHEST

### Step 3 — Master SQL View Created
. Tenure grouping logic
. Risk segment classification
. Senior citizen status
. Partner & dependent status
. Churn flag calculation

### Step 4 — Connected to Power BI
- SQL Server → Power BI connection
- Loaded vw_Churn_Master view
- Verified all columns loaded
- Created 20 DAX measures

---

##  Key Highlights
| Metric | Value |
|--------|-------|
| Total Customers | 7,043 |
| Customers Churned | 1,869 |
| Overall Churn Rate | 26.54% |
| Monthly Revenue Lost | ₹139.13K |
| Highest Risk Contract | Month-to-month (42.71%) |
| Highest Risk Payment | Electronic Check (45.29%) |
| Highest Revenue Loss | Fiber Optic (₹114K) |
| Senior Citizen Churn | 41.68% |
| New Customer Churn | 1,037 (0-12 months) |

---

##  Tools & Technologies
| Tool | Usage |
|------|-------|
| SQL Server | Data preparation |
| Power BI Desktop | Dashboards |
| DAX | 20 measures |
| T-SQL | Analysis queries |
| Kaggle | Dataset source |

---
## DAX Measures Created (20)
### Basic Measures
. Total Customers
. Customers Lost
. Customers Retained
. Churn Rate
. Retention Rate

### Revenue Measures
. Total Monthly Revenue
. Monthly Revenue Lost
. Monthly Revenue Retained
. Monthly Revenue Loss %
. Historical Revenue Lost

### Advanced Measures
. Senior Churn %
. Male Churn %
. Female Churn %
. Avg Tenure Churned
. Avg Tenure Retained
. Month-to-Month Churn %
. High Risk Customers
. Medium Risk Customers
. Fiber Optic Churn %
. Avg Monthly Charges Churned

## Key DAX Measures
### Churn Rate Measure
dax
Churn Rate =
DIVIDE(
    [Customers Lost],
    [Total Customers]
) * 100

### Monthly Revenue Lost
dax
Monthly Revenue Lost =
CALCULATE(
    SUM(vw_Churn_Master
        [MonthlyCharges]),
    vw_Churn_Master[Churn]
    = "Yes"
)

### Senior Churn %
dax
Senior Churn % =
DIVIDE(
    CALCULATE(
        COUNTROWS(vw_Churn_Master),
        vw_Churn_Master[Churn]
        = "Yes",
        vw_Churn_Master
        [Senior_Status] = "Senior"
    ),
    CALCULATE(
        COUNTROWS(vw_Churn_Master),
        vw_Churn_Master
        [Senior_Status] = "Senior"
    )
) * 100

### Month-to-Month Churn %
dax
Month-to-Month Churn % =
DIVIDE(
    CALCULATE(
        COUNTROWS(vw_Churn_Master),
        vw_Churn_Master[Churn]
        = "Yes",
        vw_Churn_Master[Contract]
        = "Month-to-month"
    ),
    CALCULATE(
        COUNTROWS(vw_Churn_Master),
        vw_Churn_Master[Contract]
        = "Month-to-month"
    )
) * 100

---

## 📊 Dashboards Overview

### Page 1 — Executive Overview
- 5 KPI Cards
- Churn Vs Retained donut chart
- Churn by Payment Method
- Churn by Internet Service
- Churn by Contract Type
- Interactive slicers

### Page 2 — Demographics Analysis
- Senior Citizen churn analysis
- Tenure group churn patterns
- Gender impact analysis
- Partner & Dependents analysis
- 3 KPI Cards

### Page 3 — Revenue & Risk Analysis
- Monthly revenue lost
- Revenue lost by contract
- Revenue lost by internet service
- Risk Segment Matrix with
  conditional formatting
- Scatter chart analysis

### Page 4 — Project Summary
- Complete project overview
- Key findings summary
- Business recommendations
- Skills demonstrated

---
## Dashboard Highlights

- KPI tracking for churn rate and revenue loss
- Risk-based customer segmentation
- Interactive filtering for deep analysis
- Conditional formatting to highlight critical segments

---
##  Risk Segmentation Approach

Customers were segmented into risk categories based on behavioral attributes such as:
- Contract type
- Payment method
- Tenure

This approach ensures segmentation is *predictive in nature* rather than dependent on past churn, making it useful for real-world decision-making.

-----

## 🔍 Key Insights Found

### Insight 1 — Contract Risk
Month-to-month = 42.71% churn
One year = 11.27% churn
Two year = 2.83% churn
→ Longer contracts = more loyal

### Insight 2 — Payment Risk
Electronic check = 45.29% churn
Mailed check = 19.1% churn
Bank transfer = 16.7% churn
Credit card = 15.2% churn
→ Electronic check is highest risk

### Insight 3 — Tenure Pattern
0-12 months = 1,037 churned
13-24 months = 294 churned
25-48 months = 325 churned
49-72 months = 213 churned
→ New customers churn most

### Insight 4 — Revenue Impact
Fiber optic = ₹114K loss
DSL = ₹23K loss
No internet = ₹2K loss
→ Fiber optic needs attention

### Insight 5 — Demographics
Senior citizens = 41.68% churn
Non-seniors = lower churn
→ Special plans needed

---

## 📊 Risk Segmentation Validation

| Risk Segment | Churn Rate |
|--------------|------------|
| High Risk | 53.7% |
| Medium Risk | 40.5% |
| Low Risk | 21.4% |
| Safe | 6.7% |

The segmentation is validated by clear differences in churn rates across segments, confirming its effectiveness in identifying at-risk customers

----

##  Business Recommendations

1. *Target High-Risk Customers*
   - Focus on customers with month-to-month contracts and electronic payment methods

2. *Encourage Long-Term Contracts*
   - Provide incentives for annual or long-term plans to improve retention

3. *Improve Payment Experience*
   - Promote automatic payment methods to reduce friction

4. *Strengthen Early Customer Engagement*
   - Introduce onboarding programs for new customers (0–12 months)

5. *Enhance High-Revenue Services*
   - Improve service quality in fiber optic segment to reduce revenue loss


---

## Impact Simulation

If business acts on recommendations:

| Action | Current | Target | Impact |
|--------|---------|--------|--------|
| Reduce M-M churn by 10% | 42.71% | 32.71% | Save ₹13K/month |
| Reduce Elec check churn by 10% | 45.29% | 35.29% | Save ₹14K/month |
| Improve fiber retention by 5% | High loss | Reduced | Save ₹5.7K/month |
| Better onboarding 0-12 months | 1037 churned | Reduce by 15% | Save 155 customers |

Total potential monthly saving:
→ ₹32.7K per month
→ ₹3.9 Lakhs per year

---

## Dashboard Screenshots

### Executive Overview
Executive Overview(Dashboard1.png)

### Demographics Analysis
Demographics Analysis(Dashboard2.png)

### Revenue & Risk Analysis
Revenue Risk Analysis(Dashboard3.png)

### Project Summary
Project Summary(Dashboard4.png)

---

##  Skills Demonstrated
. SQL View Creation
. Data Driven Analysis
. Power BI Dashboard Design
. DAX Formula Writing
. Conditional Formatting
. Business Intelligence
. Data Storytelling
. Revenue Impact Analysis
. Risk Segmentation
. Business Recommendations
. Impact Simulation
. Data Preparation

---

## Repository Contents
| File | Description |
|------|-------------|
| Churn_Dashboard.pdf | All 4 dashboards |
| Churn_SQL_View.sql | Master SQL view |
| Dashboard1.png | Executive Overview |
| Dashboard2.png | Demographics |
| Dashboard3.png | Revenue & Risk |
| Dashboard4.png | Project Summary |



---
⭐ If you find this project
useful please give it a star!




