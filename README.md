# fintech-credit-risk-analysis
## Project Overview
This repository contains an end-to-end credit risk analysis project aimed at identifying drivers of loan defaults, cleaning demographic and financial data, and building predictive models for risk assessment. The project spans database management, data science, and business intelligence reporting.

## Dataset
- **Source:** `credit_risk_dataset.csv`
- **Total Records:** 32,581 loan applicants
- **Key Features:** Borrower demographics (age, income, employment length, home ownership), loan details (intent, grade, amount, interest rate), and credit history.

## Project Structure
- `Credit_Risk_Analysis.sql`: SQL scripts for data cleaning, filtering outliers (e.g., extreme ages, unrealistic employment length), and aggregating performance KPIs by loan grade, intent, and ownership.
- `fintech-credit-risk-analysis.ipynb`: A Jupyter notebook containing the full data pipeline:
    - Exploratory Data Analysis (EDA).
    - Statistical correlation analysis against `loan_status`.
    - Feature engineering (e.g., income quartiles, loan-to-income ratios).
    - Machine learning classification pipeline (Random Forest/XGBoost).
- `fintech-credit-risk-analysis.pbix`: Power BI dashboard file providing visual insights into portfolio health, risk segmentation, and executive-level KPIs.

## Key Insights
- **Overall Default Rate:** 21.82%
- **Top Risk Drivers:** 
    - **Loan Percent Income:** Highest correlation (r=0.38) with default.
    - **Loan Grade:** Consistent escalation in risk from Grade A (9.96%) to Grade G (98.44%).
    - **Home Ownership:** Renters show significantly higher default risk (31.57%) compared to mortgage holders (12.57%).

## Getting Started
1. **Database:** Execute `Credit_Risk_Analysis.sql` in your SQL environment to prepare the data views.
2. **Analysis:** Run the `fintech-credit-risk-analysis.ipynb` notebook to reproduce the statistical analysis and model training.
3. **Visualization:** Open `fintech-credit-risk-analysis.pbix` in Power BI Desktop to explore the dashboard.

## Dependencies
- Python 3.x
- pandas, numpy, seaborn, matplotlib, scikit-learn
- Power BI Desktop
- SQL (PostgreSQL/MySQL/SQL Server compatible)

## License
This project is for educational and analytical purposes.
