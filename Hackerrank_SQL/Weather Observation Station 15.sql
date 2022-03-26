
---https://www.hackerrank.com/challenges/weather-observation-station-15/problem?isFullScreen=true


select round(long_w, 4)
from station
where lat_n in (select max(lat_n) from station where lat_n < 137.2345)
;