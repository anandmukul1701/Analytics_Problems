



with base as(
select S.*, H.Name
from 
    submissions S
left join  
    challenges C
on S.challenge_id = C.challenge_id
and S.hacker_id = C.hacker_id
left join
    difficulty D
C.difficulty_level = D.difficulty_level
left join
    hackers H
on S.hacker_id = H.hacker_id
where S.score = D.score
    )

select concat(hacker_id, ' ', name)
from base 
where hacker_id in (select distinct hacker_id from(select hacker_id, count(distinct challenge_id) as cnt from base group by 1 having cnt > 1))
;

