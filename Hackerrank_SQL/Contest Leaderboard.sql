

----https://www.hackerrank.com/challenges/contest-leaderboard/problem?isFullScreen=true&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen

select
    A.hacker_id
    ,h.name
    ,A.score_sum
from(
    select
        hacker_id
        ,sum(score) as score_sum
    from(
        select
            hacker_id
            ,challenge_id
            ,max(score) as score
        from
            submissions
        group by 1,2
        ) I
    group by 1
    --having score_sum > 0
    ) A
left join
    hackers h
on A.hacker_id = h.hacker_id
order by score_sum desc, hacker_id
;
