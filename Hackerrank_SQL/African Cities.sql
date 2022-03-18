

--https://www.hackerrank.com/challenges/african-cities/problem?isFullScreen=true&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen


select
    C.NAME
from 
    city C
left join
    country t
on C.countrycode = t.code
where T.continent = 'Africa'
;