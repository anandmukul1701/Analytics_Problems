
--https://www.hackerrank.com/challenges/weather-observation-station-5/problem?isFullScreen=true&h_r=next-challenge&h_v=zen

(
select city, length(city) as len_city
from station
order by 2 asc, 1 asc
limit 1
)
UNION ALL
(
select city, length(city) as len_city
from station
order by 2 desc, 1 asc
limit 1
)

;