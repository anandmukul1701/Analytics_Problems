


--https://www.hackerrank.com/challenges/what-type-of-triangle/problem?isFullScreen=true


select
    case when not((A+B>=C) and (B+C>=A) and (C+A>=B)) then 'Not A triangle'
        when ((A=B) and (B=C)) then 'Equilateral'
        when ((A=B and A<>C) or (A=C and A<>B) or (B=C and B<>A)) then 'Isosceles'
        when ((A<>B) and (B<>C)) then 'Scalene'
         end as Type_T
from triangles
;

SELECT
  CASE 
    WHEN A + B <= C or A + C <= B or B + C <= A THEN 'Not A Triangle'
    WHEN A = B and B = C THEN 'Equilateral'
    WHEN A = B or A = C or B = C THEN 'Isosceles'
    WHEN A <> B and B <> C THEN 'Scalene'
  END tuple
FROM TRIANGLES;