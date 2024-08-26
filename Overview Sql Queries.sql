use bank_loan_db;
select * from financial_loan;

-- 1.1
select month(issue_date) as Month_Number,
monthname(issue_date) as Month_Name,
count(id) as Total_loan_Applications,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_amount_recieved
from financial_loan
group by month(issue_date),monthname(issue_date)
order by month(issue_date);

-- 1.2
select address_state,
count(id) as Total_loan_Applications,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_amount_recieved
from financial_loan
group by address_state
order by address_state;

-- 1.3
select term as loan_term,
count(id) as Total_loan_Applications,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_amount_recieved
from financial_loan
group by term
order by term;

-- 1.4
select emp_length as Employee_length,
count(id) as Total_loan_Applications,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_amount_recieved
from financial_loan
group by emp_length
order by count(id) desc ;

-- 1.5
select purpose as Purpose_of_Loan,
count(id) as Total_loan_Applications,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_amount_recieved
from financial_loan
group by purpose
order by count(id) desc;

-- 1.6
select home_ownership as Type_of_Home,
count(id) as Total_loan_Applications,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_amount_recieved
from financial_loan
group by home_ownership
order by count(id) desc;


