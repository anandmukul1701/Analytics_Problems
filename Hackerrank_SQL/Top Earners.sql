Top Earners
---https://www.hackerrank.com/challenges/earnings-of-employees/problem?isFullScreen=true




select concat(max(months*salary), ' ', count(employee_id))
from employee
where (months*salary) = (select max(months*salary) from employee)
;