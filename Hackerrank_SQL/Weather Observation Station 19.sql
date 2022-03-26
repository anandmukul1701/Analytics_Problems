Weather Observation Station 19

--https://www.hackerrank.com/challenges/weather-observation-station-19/problem?isFullScreen=true&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen


select round(SQRT(power(min(lat_n) - max(lat_n),2) + power(min(long_w) - max(long_w), 2)), 4)
from STATION
;