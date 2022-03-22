




select concat(max(salary*months), ' ', count(salary))
from employee
where salary*months = (select max(salary*months) from employee)
;