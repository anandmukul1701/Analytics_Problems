
--https://www.hackerrank.com/challenges/weather-observation-station-6/problem?isFullScreen=true&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen

select distinct city
from station
where lower(city) like any ('a%', 'e%', 'i%', 'o%', 'u%')
;




select t.city from station t where lower(SUBSTR(city,1,1)) in ('a','e','i','o','u')
;