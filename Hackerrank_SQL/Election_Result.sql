





select
    party,
    constituency_id
from
(
    select
      party,
      constituency_id,
      sum(votes) as total_votes,
      dense_rank() over (partition by party order by sum(votes) desc) as rnk
  from qbiz_candidates qc
  join qbiz_results qr
  on qc.id = qr.candidate_id
  group by
      party,
      constituency_id
) val
where rnk = 1