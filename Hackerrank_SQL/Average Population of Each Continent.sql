

---https://www.hackerrank.com/challenges/average-population-of-each-continent/problem?isFullScreen=true&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen


select
    T.continent, floor(avg(C.population)) as average_p
from 
    city C
inner join
    country t
on C.countrycode = t.code
group by 1
;