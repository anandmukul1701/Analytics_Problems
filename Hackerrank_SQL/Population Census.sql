Population Census

--https://www.hackerrank.com/challenges/asian-population/problem?isFullScreen=true


select sum(C.population)
from city C
inner join country t
on C.CountryCode = t.Code
where T.continent = 'Asia'
;