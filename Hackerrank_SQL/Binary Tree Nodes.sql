Binary Tree Nodes

---https://www.hackerrank.com/challenges/binary-search-tree-1/problem?isFullScreen=true

select  case 
        when p is null then concat(n, ' Root')
        when n in (select distinct p from bst) then concat(n, ' Inner')
        else concat(n, ' Leaf')
    end
from bst
order by n asc
;