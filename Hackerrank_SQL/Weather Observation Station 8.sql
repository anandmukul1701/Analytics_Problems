
--https://www.hackerrank.com/challenges/weather-observation-station-8/problem?isFullScreen=true&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen

select distinct t.city 
from station t 
where lower(RIGHT(city,1)) in ('a','e','i','o','u')
and lower(SUBSTR(city,1,1)) in ('a','e','i','o','u')
;