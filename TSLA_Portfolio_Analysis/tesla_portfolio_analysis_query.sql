drop table if exists tesla;
create temp table tesla as 	(
	SELECT "Date" as date
	,"Open" as t_open
	,"Close" as t_close
	, volume as t_volume
	FROM public.tsla t
	where "Date"  is not null 
	order by "Date" desc 
);

drop table if exists cal;
create temp table cal as (
	SELECT *
	FROM calendar n 
);

drop table if exists spyy;
create temp table spyy as (
	select "Date" as date
	, "Open" as spy_open
	,"Close" as spy_close,
	volume as spy_volume
	from spy s 
	where "Date"  is not null 
	order by "Date" desc 
);

drop table if exists portfolio_prep;
create temp table portfolio_prep as (
	select date --grouping by DATE to ensure one line per date in final dataset
		   ,ROUND(sum(units)::numeric,2) as units
		   ,SUM(buy_price_usd) as buy_price_usd
	from (select date
		, units
		, buy_price_usd
		, buy_price_eur
		, open_price_usd
		from tsl_portfolio tp) subquery
		group by 1
		order by date
);


drop table if exists portfolio;
create temp table portfolio as (
	select * 
			, round( sum(buy_price_usd) over(ROWS BETWEEN UNBOUNDED PRECEDING AND current row)
		       / sum(units) over(ROWS BETWEEN UNBOUNDED PRECEDING AND current row) ) as avg_buy_price
	from portfolio_prep
	order by date
);


drop table if exists combined;
create temp table combined as (
	select c.dt::date as dt
	, spy_close
	, t_close
	, spy_volume
	, t_volume 
	, units
	, avg_buy_price 
	, count(avg_buy_price) over (order by dt::date) +1 as partitioner
	, sum(units) over (order by dt::date) as cummulative_units
	from cal c
	left join tesla t on c.dt::date  = t.date::date
	left join spyy s on c.dt::date = s.date::date
	left join portfolio p on c.dt::date = p.date::date 
	order by dt
);

drop table if exists final;
create temp table final as ( 

select dt
	, spy_close
	, round(t_close::numeric,2) as t_close
	, spy_volume
	, t_volume 
	, units
	,round(cummulative_units::numeric,2) as cummulative_units
	, ROUND(cummulative_units * t_close) as portfolio_running_value
	, MAX(cummulative_units * avg_buy_price) over(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT row) as funds_invested
	, (ROUND(((cummulative_units * t_close) / MAX(cummulative_units * avg_buy_price) over(ROWS BETWEEN UNBOUNDED PRECEDING AND  CURRENT row))::numeric,4))-1 AS p_l
	, first_value (avg_buy_price) over (partition by partitioner order by dt) as avg_buy_price
	, case when date_part('month',dt) = coalesce (date_part('month',(lag(dt) over (order by dt))),date_part('month',dt)) then 0 else 1 end AS is_first_day_of_month
	, case when date_part('week',dt) = coalesce (date_part('week',(lag(dt) over (order by dt))),date_part('week',dt)) then 0 else 1 end AS is_first_day_of_week
	, case when date_part('year',dt) = coalesce (date_part('year',(lag(dt) over (order by dt))),date_part('year',dt)) then 0 else 1 end AS is_first_day_of_year
--	, avg(t_volume) over (ROWS BETWEEN 6 preceding  AND current row) as T7D_t_volume
	, round(((t_volume / avg(t_volume) over (ROWS BETWEEN 29 preceding  AND current row) -1) *100)::numeric,2)as T30D_t_volume_avg_comparison
	, round((((t_close / lag(t_close) over() )-1) *100)::numeric,2) as t_interday_pct
	, round((((spy_close / lag(spy_close) over() )-1) *100)::numeric,2) as spy_interday_pct
	, round(((t_close / avg(t_close) over (ROWS BETWEEN 29 preceding  AND current row) -1) *100)::numeric,2)as T30D_stock_vs_avg_comparison	
	, round(((spy_close / avg(spy_close) over (ROWS BETWEEN 29 preceding  AND current row) -1) *100)::numeric,2)as SPY30D_stock_vs_avg_comparison
	from combined
	where  dt > '2010-06-30 '  and spy_close is not null     
	order by dt
);

SELECT *

, ROUND((SUM( (units*t_close)/spy_close) over(order by dt::date) * spy_close)::numeric,2) AS hyp_spy_portfolio
FROM FINAL 
where dt > '2020-06-29 '  and spy_close is not null 