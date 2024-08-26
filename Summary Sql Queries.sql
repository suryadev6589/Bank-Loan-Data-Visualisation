USE bank_loan_db;
SELECT * FROM financial_loan;


-- 1.1
SELECT COUNT(id) AS Total_loan_Applications FROM financial_loan;

-- 1.2
SELECT issue_date,STR_TO_DATE(issue_date,'%d-%m-%Y')  FROM financial_loan;
UPDATE financial_loan SET issue_date=STR_TO_DATE(issue_date,"%d-%m-%Y");
SELECT COUNT(id) AS MTD_Total_loan_Applications FROM financial_loan 
WHERE MONTH(issue_date)=(SELECT MAX(MONTH(issue_date)) FROM financial_loan);

-- 1.3
SELECT COUNT(id) AS PMTD_Total_loan_Applications FROM financial_loan 
WHERE MONTH(issue_date)=(SELECT MAX(MONTH(issue_date))-1 FROM financial_loan);

-- -- ------------------------------------------------------------------------------------------------------------------------------------------
-- 2.1
SELECT SUM(loan_amount) AS Total_Funded_amount FROM financial_loan;

-- 2.2
SELECT SUM(loan_amount) AS MTD_Total_Funded_amount FROM financial_loan
WHERE MONTH(issue_date)=(SELECT MAX(MONTH(issue_date)) FROM financial_loan);

-- 2.3
SELECT SUM(loan_amount) AS PMTD_Total_Funded_amount FROM financial_loan
WHERE MONTH(issue_date)=(SELECT MAX(MONTH(issue_date)-1) FROM financial_loan);

-- -- ------------------------------------------------------------------------------------------------------------------------------------------
-- 3.1
SELECT SUM(total_payment) AS Total_amount_recieved FROM financial_loan;

-- 3.2
SELECT SUM(total_payment) AS MTD_Total_amount_recieved FROM financial_loan
WHERE MONTH(issue_date)=(SELECT MAX(MONTH(issue_date)) FROM financial_loan);

-- 3.3
SELECT SUM(total_payment) AS PMTD_total_amount_recieved FROM financial_loan
WHERE MONTH(issue_date)=(SELECT MAX(MONTH(issue_date)-1) FROM financial_loan);

-- -- ------------------------------------------------------------------------------------------------------------------------------------------
-- 4.1
SELECT ROUND(AVG(int_rate)*100,2) AS Average_Interest_Rate FROM financial_loan;

-- 4.2
SELECT ROUND(AVG(int_rate)*100,2) AS MTD_Average_Interest_Rate FROM financial_loan
WHERE MONTH(issue_date)=(SELECT MAX(MONTH(issue_date)) FROM financial_loan);

-- 4.3
SELECT ROUND(AVG(int_rate)*100,2) AS PMTD_Average_Interest_Rate FROM financial_loan
WHERE MONTH(issue_date)=(SELECT MAX(MONTH(issue_date))-1 FROM financial_loan);

-- -- ------------------------------------------------------------------------------------------------------------------------------------------
-- 5.1
SELECT ROUND(AVG(dti)*100,2) AS Average_DTI FROM financial_loan;

-- 5.2
SELECT ROUND(AVG(dti)*100,2) AS MTD_Average_DTI FROM financial_loan
WHERE MONTH(issue_date)=(SELECT MAX(MONTH(issue_date)) FROM financial_loan);

-- 5.3
SELECT ROUND(AVG(dti)*100,2) AS PMTD_Average_DTI FROM financial_loan
WHERE MONTH(issue_date)=(SELECT MAX(MONTH(issue_date))-1 FROM financial_loan);

-- -- ------------------------------------------------------------------------------------------------------------------------------------------
-- Good Loan v/s Bad loans

SELECT DISTINCT(loan_status) FROM financial_loan;

-- 6.1
SELECT ROUND((COUNT(CASE WHEN loan_status='Fully Paid' OR loan_status='Current' THEN id END)*100/COUNT(id)),2) AS Good_loan_percentage
FROM financial_loan;

-- 6.2
SELECT COUNT(id) AS Good_loan_applications FROM financial_loan WHERE loan_status='Fully Paid' OR loan_status='Current';

-- 6.3
SELECT SUM(loan_amount) AS Good_loan_funded_amount FROM financial_loan WHERE loan_status='Fully Paid' OR loan_status='Current';

-- 6.4
SELECT SUM(total_payment) AS Good_loan_recieved_amount FROM financial_loan WHERE loan_status='Fully Paid' OR loan_status='Current';

-- 7.1
SELECT ROUND((COUNT(CASE WHEN loan_status='Charged off' THEN id END)*100/COUNT(id)),2) AS Bad_loan_percentage
FROM financial_loan;

-- 7.2
SELECT COUNT(id) AS Bad_loan_applications FROM financial_loan WHERE loan_status='Charged off';

-- 7.3
SELECT SUM(loan_amount) AS Bad_loan_funded_amount FROM financial_loan WHERE loan_status='Charged off';

-- 7.4
SELECT SUM(total_payment) AS Bad_loan_recieved_amount FROM financial_loan WHERE loan_status='Charged off';


-- -------------------------------------------------------------------------------------------------------------------------------------------------

-- 8.1
SELECT loan_status,COUNT(id) AS loan_count,
SUM(loan_amount) AS Total_funded_amount,
SUM(total_payment) AS Total_payment_recieved,
ROUND(AVG(int_rate) * 100,2) AS Interest_Rate,
ROUND(AVG(dti)*100,2) AS DTI
FROM financial_loan
GROUP BY loan_status;

-- 8.2
SELECT loan_status,COUNT(id) AS MTD_loan_count,
SUM(loan_amount) AS MTD_Total_funded_amount,
SUM(total_payment) AS MTD_Total_payment_recieved
FROM financial_loan
WHERE MONTH(issue_date)=(SELECT MAX(MONTH(issue_date)) FROM financial_loan)
GROUP BY loan_status;

-- 8.3
SELECT loan_status,COUNT(id) AS PMTD_loan_count,
SUM(loan_amount) AS PMTD_Total_funded_amount,
SUM(total_payment) AS PMTD_Total_payment_recieved
FROM financial_loan
WHERE MONTH(issue_date)=(SELECT MAX(MONTH(issue_date))-1 FROM financial_loan)
GROUP BY loan_status;


