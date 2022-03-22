Weather Observation Station 13


select round(sum(Lat_n), 4)
from station
where LAT_N > 38.7880 and LAT_N < 137.2345
;