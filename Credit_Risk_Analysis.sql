select* from "Credit_Risk_Analysis" limit 20
-- 1. What is the overall portfolio loan default rate?
SELECT ROUND(SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS default_rate_pct 
FROM "Credit_Risk_Analysis";
-- 2. How does default rate vary across different home ownership statuses?
SELECT person_home_ownership, COUNT(*) as total_loans, SUM(loan_status) as defaults,
       ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2) as default_rate_pct
FROM "Credit_Risk_Analysis" GROUP BY person_home_ownership ORDER BY default_rate_pct DESC;

-- 3. What is the average Debt-to-Income ratio for defaulters vs non-defaulters?
SELECT loan_status, ROUND(AVG(loan_percent_income)::numeric, 2) as avg_loan_income_ratio 
FROM "Credit_Risk_Analysis" GROUP BY loan_status;

-- 4. What is the default rate breakdown by loan intent categories?
SELECT loan_intent, COUNT(*) as total, ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2) as default_rate_pct 
FROM "Credit_Risk_Analysis" GROUP BY loan_intent ORDER BY default_rate_pct DESC;

-- 5. How does past credit default history impact future default rates?
SELECT cb_person_default_file, ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2) as default_rate_pct 
FROM "Credit_Risk_Analysis" GROUP BY cb_person_default_file;

-- 6. What is the total financial capital exposure tied up in defaults?
SELECT SUM(loan_amnt) as total_default_exposure FROM "Credit_Risk_Analysis" WHERE loan_status = 1;

-- 7. How does borrower income bracket affect default likelihood?
SELECT 
    CASE 
        WHEN person_income < 30000 THEN 'Low (<30k)'
        WHEN person_income BETWEEN 30000 AND 70000 THEN 'Medium (30k-70k)'
        ELSE 'High (70k+)'
    END as income_bracket,
    ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2) as default_rate_pct
FROM "Credit_Risk_Analysis" GROUP BY income_bracket ORDER BY default_rate_pct DESC;

-- 8. What is the average interest rate applied by final loan status?
SELECT loan_status, ROUND(AVG(loan_int_rate)::numeric, 2) as avg_interest_rate 
FROM "Credit_Risk_Analysis" GROUP BY loan_status;

-- 9. Who are the top 10 borrowers with the largest loan amounts who defaulted?
SELECT person_age, person_income, loan_amnt, loan_int_rate 
FROM "Credit_Risk_Analysis" WHERE loan_status = 1 ORDER BY loan_amnt DESC LIMIT 10;

-- 10. Does credit history length correlate with lower default frequencies?
SELECT 
    CASE 
        WHEN cb_person_cred_hist_length <= 2 THEN '0-2 Years'
        WHEN cb_person_cred_hist_length <= 5 THEN '3-5 Years'
        ELSE '5+ Years'
    END as credit_history_tier,
    ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2) as default_rate_pct
FROM "Credit_Risk_Analysis" GROUP BY credit_history_tier ORDER BY default_rate_pct DESC;

-- 11. What is the average employment length for defaulting vs performing borrowers?
SELECT loan_status, ROUND(AVG(person_emp_length)::numeric, 1) as avg_emp_length_years 
FROM "Credit_Risk_Analysis" GROUP BY loan_status;

-- 12. What is the default rate for loans where interest rates exceed 15%?
SELECT 
    CASE WHEN loan_int_rate > 15.0 THEN 'High Interest (>15%)' ELSE 'Standard (<=15%)' END as rate_category,
    ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2) as default_rate_pct
FROM "Credit_Risk_Analysis" GROUP BY rate_category;

-- 13. How do age groups split across credit default outcomes?
SELECT 
    CASE 
        WHEN person_age < 25 THEN 'Under 25'
        WHEN person_age BETWEEN 25 and 40 THEN '25-40'
        ELSE '41+'
    END as age_group,
    ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2) as default_rate_pct
FROM "Credit_Risk_Analysis"
GROUP BY
CASE
WHEN person_age <25 THEN 'Under 25'
WHEN person_age BETWEEN 25 AND age_group ORDER BY default_rate_pct DESC;

-- 14. What volume of loans originate from renters with high loan-to-income ratios (>0.4)?
SELECT COUNT(*) as high_risk_renter_count 
FROM credit_risk_data 
WHERE person_home_ownership = 'RENT' AND loan_percent_income > 0.4 AND loan_status = 1;

-- 15. What is average loan size requested across different loan intents?
SELECT loan_intent, ROUND(AVG(loan_amnt)::numeric, 2) as avg_loan_amount 
FROM credit_risk_data GROUP BY loan_intent ORDER BY avg_loan_amount DESC;