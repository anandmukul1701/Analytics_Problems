The Blunder




select
    ceil(avg(salary) - avg(mis_typed_salary))
from(
    select *, cast(replace(salary_char,'0' , '') as DECIMAL) as mis_typed_salary
    from(
        select *, cast(salary as CHAR) as salary_char
        from
            Employees
        ) A 
    ) B
;

