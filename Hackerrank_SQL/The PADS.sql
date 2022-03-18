


---https://www.hackerrank.com/challenges/the-pads/problem?isFullScreen=true&h_r=next-challenge&h_v=zen






(select
    concat(Name, '(', LEFT(occupation, 1), ')') as Col
from 
    Occupations
order by 1
 )
UNION
(
select
    concat('There are a total of ', cnt, ' ', occupation, 's.') as col
from(
    select
        count(NAME) as cnt
        ,lower(occupation) as occupation
    from 
        OCCUPATIONS
    group by 2
    order by 1,2
    ) a
)
;







(select
    concat(Name, '(', LEFT(occupation, 1), ')') as Col
from 
    Occupations
order by 1
 )
;
(
select
    concat('There are a total of ', cnt, ' ', occupation, 's.') as col
from(
    select
        count(NAME) as cnt
        ,lower(occupation) as occupation
    from 
        OCCUPATIONS
    group by 2
    order by 1,2
    ) a
)
;



