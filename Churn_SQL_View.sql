USE [Crunch]
GO

/****** Object:  View [dbo].[churn_analysis_view]    Script Date: 24/3/2026 5:20:46 pm ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[churn_analysis_view] AS 
SELECT 
CustomerID,
Gender,
SeniorCitizen,
Partner,
Dependents,
    CASE 
        WHEN SeniorCitizen = 1 THEN 'Senior' 
        ELSE 'Non-Senior' 
    END AS Senior_Status,
    CASE 
        WHEN Partner = 'Yes' THEN 'Has Partner' 
        ELSE 'No Partner' 
    END AS Partner_Status,
    CASE 
        WHEN Dependents = 'Yes' THEN 'Has Dependents' 
        ELSE 'No Dependents' 
    END AS Dependent_Status,

Tenure,
Contract,
PaymentMethod,
PaperlessBilling,
---Service Info
InternetService,
OnlineSecurity,
TechSupport,
StreamingMovies,
StreamingTV,
--Revenue Info
MonthlyCharges,
TotalCharges,
---churn info
Churn,

CASE
WHEN Churn='Yes' THEN 1
ELSE 0
END AS ChurnFlag,
CASE
WHEN Churn='No' THEN 1
ELSE 0
END AS Retained_flag,
---tenure group
CASE
WHEN Tenure<=12 THEN '0-12 Months' 
WHEN  Tenure <=24 THEN '13-24 Months'
WHEN  Tenure <= 48 THEN '25-48 Months'
ELSE '49-72 Months' 
end as TenureGroup,

---Risk Segment

CASE
         WHEN  Contract = 'Month-to-month'  
             AND PaymentMethod = 'Electronic check'
        THEN 'High Risk'
        WHEN  Contract = 'Month-to-month'
		 AND Tenure<=12
        THEN 'Medium Risk'
        WHEN Contract IN('One Year','Two year')
		AND Tenure>12
		THEN 'Low Risk'
       ELSE 'Safe'
      END AS Risk_Segment,

    -- ✅ Contract Risk Level (Data Proven)
    -- Month-to-month = 42.71%
    -- One year = 11.27%
    -- Two year = 2.83%
    CASE
        WHEN Contract = 'Month-to-month' THEN ' High Risk'
        WHEN Contract = 'One year'       THEN ' Medium Risk'
        WHEN Contract = 'Two year'       THEN 'Low Risk'
    END AS Contract_Risk_Level

from [Telco Customer Churn]
GO


