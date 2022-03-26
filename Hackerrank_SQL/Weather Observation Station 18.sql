

Weather Observation Station 18
--https://www.hackerrank.com/challenges/weather-observation-station-18/problem?isFullScreen=true&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen

select round(ABS(max(lat_n) - min(lat_n)) + ABS(max(long_w) - min(long_w)) , 4)
from station
;