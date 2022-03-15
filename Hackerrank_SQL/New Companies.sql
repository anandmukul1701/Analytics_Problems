


--https://www.hackerrank.com/challenges/the-company/problem?isFullScreen=true&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen

select
    E.company_code
    ,C.founder
    ,count(distinct lead_manager_code) as lm_cnt
    ,count(distinct senior_manager_code) as sm_cnt
    ,count(distinct manager_code) as m_cnt
    ,count(distinct employee_code) as e_cnt
from 
    employee E
left join
    Company C
on E.company_code = C.company_code
group by 1,2
order by 1
;