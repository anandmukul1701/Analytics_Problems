




select s.sales_date, sum(round((s.sales_amount * e.exchange_rate),2)) amt
from(
select 
	e.source_currency, e.exchange_rate, e.effective_start_date,
	isnull(lead(dateadd(day, -1,cast(effective_start_date as date))) over(partition by source_currency order by effective_start_date ),cast('9999-12-31' as date)) eff_end_date
from exchange_rate e
) e
 join sales_amount s
on e.source_currency = s.currency and
s.sales_date between e.effective_start_date and e.eff_end_date
group by s.sales_date
order by s.sales_date
;


