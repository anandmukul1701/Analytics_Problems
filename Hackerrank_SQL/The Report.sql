

--https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=true

select name, grade, marks
from(
    select S.*, G.grade
    from 
        students S
    left join
        grades G
    on S.marks >= G.min_mark
    and S.marks <= G.max_mark
    ) Base
where grade >= 8
order by grade desc, Name asc
;

select NULL as name, grade, marks
from(
    select S.*, G.grade
    from 
        students S
    left join
        grades G
    on S.marks >= G.min_mark
    and S.marks <= G.max_mark
    ) Base
where grade < 8
order by grade desc, marks asc
;