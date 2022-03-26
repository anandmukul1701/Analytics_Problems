

--https://www.hackerrank.com/challenges/full-score/problem?isFullScreen=true&h_r=next-challenge&h_v=zen



select h.hacker_id, h.name 
from Submissions as s 
join Hackers as h 
on s.hacker_id = h.hacker_id 
join Challenges as c 
on s.challenge_id = c.challenge_id
join Difficulty as d 
on c.Difficulty_level = d.Difficulty_level
where s.score = d.score 
group by h.hacker_id, h.name 
having count(*) > 1
order by count(*) desc, h.hacker_id
;








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
where hacker_id in (select distinct hacker_id 
					from(
						select hacker_id, count(distinct challenge_id) as cnt from base group by 1 having cnt > 1)
					)
;

