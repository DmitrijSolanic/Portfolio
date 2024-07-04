DROP TABLE IF EXISTS spy_max_base;
CREATE TABLE spy_max_base as (
SELECT "Date"
	, "Close"
    , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '1 year' 
     and "Date" > sm."Date" - INTERVAL '1 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float::float AS lag_1y
    , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '2 year' 
     and "Date" > sm."Date" - INTERVAL '2 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float::float AS lag_2y
    , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '3 year' 
     and "Date" > sm."Date" - INTERVAL '3 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_3y
   , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '4 year' 
     and "Date" > sm."Date" - INTERVAL '4 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_4y
   , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '5 year' 
     and "Date" > sm."Date" - INTERVAL '5 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_5y
    , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '6 year' 
     and "Date" > sm."Date" - INTERVAL '6 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_6y
    , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '7 year' 
     and "Date" > sm."Date" - INTERVAL '7 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_7y
   , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '8 year' 
     and "Date" > sm."Date" - INTERVAL '8 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_8y
   , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '9 year' 
     and "Date" > sm."Date" - INTERVAL '9 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_9y
    , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '10 year' 
     and "Date" > sm."Date" - INTERVAL '10 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_10y
   , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '11 year' 
     and "Date" > sm."Date" - INTERVAL '11 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_11y
   , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '12 year' 
     and "Date" > sm."Date" - INTERVAL '12 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_12y
    , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '13 year' 
     and "Date" > sm."Date" - INTERVAL '13 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_13y
    , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '14 year' 
     and "Date" > sm."Date" - INTERVAL '14 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_14y
   , (SELECT "Close" 
     FROM public.spy_max 
     WHERE "Date" <= sm."Date" - INTERVAL '15 year' 
     and "Date" > sm."Date" - INTERVAL '15 year 15 days' 
     ORDER BY "Date" DESC 
     LIMIT 1)::float AS lag_15y
	FROM public.spy_max sm
);

DROP TABLE IF EXISTS spy_max_yoy  ;	
CREATE TABLE spy_max_yoy as (
	SELECT "Date"
	, "Close"
	,ROUND("lag_1y"::numeric,2) as lag_1y
	,ROUND("lag_2y"::numeric,2) as lag_2y
	,ROUND("lag_3y"::numeric,2) as lag_3y
	,ROUND("lag_4y"::numeric,2) as lag_4y
	,ROUND("lag_5y"::numeric,2) as lag_5y
	,ROUND("lag_6y"::numeric,2) as lag_6y
	,ROUND("lag_7y"::numeric,2) as lag_7y
	,ROUND("lag_8y"::numeric,2) as lag_8y
	,ROUND("lag_9y"::numeric,2) as lag_9y
	,ROUND("lag_10y"::numeric,2) as lag_10y
	,ROUND("lag_11y"::numeric,2) as lag_11y
	,ROUND("lag_12y"::numeric,2) as lag_12y
	,ROUND("lag_13y"::numeric,2) as lag_13y
	,ROUND("lag_14y"::numeric,2) as lag_14y
	,ROUND("lag_15y"::numeric,2) as lag_15y
	,ROUND((("Close"/  "lag_1y")-1)::numeric,4) as yoy_1
	,ROUND((("Close"/  "lag_2y")-1)::numeric,4) as yoy_2
	,ROUND((("Close"/  "lag_3y")-1)::numeric,4) as yoy_3
	,ROUND((("Close"/  "lag_4y")-1)::numeric,4) as yoy_4
	,ROUND((("Close"/  "lag_5y")-1)::numeric,4) as yoy_5
	,ROUND((("Close"/  "lag_6y")-1)::numeric,4) as yoy_6
	,ROUND((("Close"/  "lag_7y")-1)::numeric,4) as yoy_7
	,ROUND((("Close"/  "lag_8y")-1)::numeric,4) as yoy_8
	,ROUND((("Close"/  "lag_9y")-1)::numeric,4) as yoy_9
	,ROUND((("Close"/  "lag_10y")-1)::numeric,4) as yoy_10
	,ROUND((("Close"/  "lag_11y")-1)::numeric,4) as yoy_11
	,ROUND((("Close"/  "lag_12y")-1)::numeric,4) as yoy_12
	,ROUND((("Close"/  "lag_13y")-1)::numeric,4) as yoy_13
	,ROUND((("Close"/  "lag_14y")-1)::numeric,4) as yoy_14
	,ROUND((("Close"/  "lag_15y")-1)::numeric,4) as yoy_15
	from public.spy_max_base smb 
);

DROP TABLE IF EXISTS profit_days  ;	
CREATE TABLE profit_days as (
SELECT smy.*
, CASE WHEN yoy_1 > 0 THEN 1 
	   WHEN yoy_1 IS NULL THEN NULL
	   ELSE 0 END AS yoy_1_profit_days
, CASE WHEN yoy_2 > 0 THEN 1 
	   WHEN yoy_2 IS NULL THEN NULL
	   ELSE 0 END AS yoy_2_profit_days
, CASE WHEN yoy_3 > 0 THEN 1 
	   WHEN yoy_3 IS NULL THEN NULL
	   ELSE 0 END AS yoy_3_profit_days
, CASE WHEN yoy_4 > 0 THEN 1 
	   WHEN yoy_4 IS NULL THEN NULL
	   ELSE 0 END AS yoy_4_profit_days
, CASE WHEN yoy_5 > 0 THEN 1 
	   WHEN yoy_5 IS NULL THEN NULL
	   ELSE 0 END AS yoy_5_profit_days
, CASE WHEN yoy_6 > 0 THEN 1 
	   WHEN yoy_6 IS NULL THEN NULL
	   ELSE 0 END AS yoy_6_profit_days
, CASE WHEN yoy_7 > 0 THEN 1 
	   WHEN yoy_7 IS NULL THEN NULL
	   ELSE 0 END AS yoy_7_profit_days
, CASE WHEN yoy_8 > 0 THEN 1 
	   WHEN yoy_8 IS NULL THEN NULL
	   ELSE 0 END AS yoy_8_profit_days
, CASE WHEN yoy_9 > 0 THEN 1 
	   WHEN yoy_9 IS NULL THEN NULL
	   ELSE 0 END AS yoy_9_profit_days
, CASE WHEN yoy_10 > 0 THEN 1 
	   WHEN yoy_10 IS NULL THEN NULL
	   ELSE 0 END AS yoy_10_profit_days
, CASE WHEN yoy_11 > 0 THEN 1 
	   WHEN yoy_11 IS NULL THEN NULL
	   ELSE 0 END AS yoy_11_profit_days
, CASE WHEN yoy_12 > 0 THEN 1 
	   WHEN yoy_12 IS NULL THEN NULL
	   ELSE 0 END AS yoy_12_profit_days
, CASE WHEN yoy_13 > 0 THEN 1 
	   WHEN yoy_13 IS NULL THEN NULL
	   ELSE 0 END AS yoy_13_profit_days
, CASE WHEN yoy_14 > 0 THEN 1 
	   WHEN yoy_14 IS NULL THEN NULL
	   ELSE 0 END AS yoy_14_profit_days
, CASE WHEN yoy_15 > 0 THEN 1 
	   WHEN yoy_15 IS NULL THEN NULL
	   ELSE 0 END AS yoy_15_profit_days
FROM public.spy_max_yoy smy
);

DROP TABLE IF EXISTS profit_days_in_row  ;	
CREATE TABLE profit_days_in_row as (
SELECT
    *
    , CASE WHEN yoy_1_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp1 ORDER BY "Date") -1 ELSE NULL END AS yoy_1y_profit_days_in_row
    , CASE WHEN yoy_2_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp2 ORDER BY "Date") -1 ELSE NULL END AS yoy_2y_profit_days_in_row
    , CASE WHEN yoy_3_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp3 ORDER BY "Date") -1 ELSE NULL END AS yoy_3y_profit_days_in_row
    , CASE WHEN yoy_4_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp4 ORDER BY "Date") -1 ELSE NULL END AS yoy_4y_profit_days_in_row
    , CASE WHEN yoy_5_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp5 ORDER BY "Date") -1 ELSE NULL END AS yoy_5y_profit_days_in_row
    , CASE WHEN yoy_6_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp6 ORDER BY "Date") -1 ELSE NULL END AS yoy_6y_profit_days_in_row
    , CASE WHEN yoy_7_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp7 ORDER BY "Date") -1 ELSE NULL END AS yoy_7y_profit_days_in_row
    , CASE WHEN yoy_8_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp8 ORDER BY "Date") -1 ELSE NULL END AS yoy_8y_profit_days_in_row
    , CASE WHEN yoy_9_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp9 ORDER BY "Date") -1 ELSE NULL END AS yoy_9y_profit_days_in_row
    , CASE WHEN yoy_10_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp10 ORDER BY "Date") -1 ELSE NULL END AS yoy_10y_profit_days_in_row
    , CASE WHEN yoy_11_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp11 ORDER BY "Date") -1 ELSE NULL END AS yoy_11y_profit_days_in_row
    , CASE WHEN yoy_12_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp12 ORDER BY "Date") -1 ELSE NULL END AS yoy_12y_profit_days_in_row
    , CASE WHEN yoy_13_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp13 ORDER BY "Date") -1 ELSE NULL END AS yoy_13y_profit_days_in_row
    , CASE WHEN yoy_14_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp14 ORDER BY "Date") -1 ELSE NULL END AS yoy_14y_profit_days_in_row
    , CASE WHEN yoy_15_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY grp15 ORDER BY "Date") -1 ELSE NULL END AS yoy_15y_profit_days_in_row
FROM (
    SELECT
        *
        , SUM(CASE WHEN yoy_1_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp1
        , SUM(CASE WHEN yoy_2_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp2
        , SUM(CASE WHEN yoy_3_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp3
        , SUM(CASE WHEN yoy_4_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp4
        , SUM(CASE WHEN yoy_5_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp5
        , SUM(CASE WHEN yoy_6_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp6
        , SUM(CASE WHEN yoy_7_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp7
        , SUM(CASE WHEN yoy_8_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp8
        , SUM(CASE WHEN yoy_9_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp9
        , SUM(CASE WHEN yoy_10_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp10
        , SUM(CASE WHEN yoy_11_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp11
        , SUM(CASE WHEN yoy_12_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp12
        , SUM(CASE WHEN yoy_13_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp13
        , SUM(CASE WHEN yoy_14_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp14
        , SUM(CASE WHEN yoy_15_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS grp15
    FROM
        public.profit_days
) AS subquery
);


DROP table IF EXISTS cpi_lags;
CREATE TABLE cpi_lags AS(
SELECT "Year"
	, "Month " as month
	, ROUND(("cpi" / 100)::numeric,3)+1  as cpi
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -1
     and "Month " = ucm."Month "
	) AS cpi_1y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -2
     and "Month " = ucm."Month "
	) AS cpi_2y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -3
     and "Month " = ucm."Month "
	) AS cpi_3y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -4
     and "Month " = ucm."Month "
	) AS cpi_4y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -5
     and "Month " = ucm."Month "
	) AS cpi_5y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -6
     and "Month " = ucm."Month "
	) AS cpi_6y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -7
     and "Month " = ucm."Month "
	) AS cpi_7y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -8
     and "Month " = ucm."Month "
	) AS cpi_8y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -9
     and "Month " = ucm."Month "
	) AS cpi_9y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -10
     and "Month " = ucm."Month "
	) AS cpi_10y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -11
     and "Month " = ucm."Month "
	) AS cpi_11y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -12
     and "Month " = ucm."Month "
	) AS cpi_12y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -13
     and "Month " = ucm."Month "
	) AS cpi_13y_lag
	, (SELECT ROUND(("cpi" / 100)::numeric,3)+1
     FROM public.us_cpi_monthly    
     WHERE "Year" = ucm."Year" -14
     and "Month " = ucm."Month "
	) AS cpi_14y_lag
FROM public.us_cpi_monthly ucm 
order by 1,2
);

DROP TABLE IF EXISTS cpi_cummulative;
CREATE TABLE cpi_cummulative AS( 
SELECT "Year"
	 , "month"
	 , cpi 
	 , ROUND(cpi * cpi_1y_lag,3) as cpi_2y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag ,3) as cpi_3y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag  * cpi_3y_lag ,3) as cpi_4y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag  * cpi_3y_lag  * cpi_4y_lag ,3) as cpi_5y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag  * cpi_3y_lag  * cpi_4y_lag  * cpi_5y_lag ,3) as cpi_6y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag  * cpi_3y_lag  * cpi_4y_lag  * cpi_5y_lag  * cpi_6y_lag ,3) as cpi_7y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag  * cpi_3y_lag  * cpi_4y_lag  * cpi_5y_lag  * cpi_6y_lag  * cpi_7y_lag ,3) as  cpi_8y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag  * cpi_3y_lag  * cpi_4y_lag  * cpi_5y_lag  * cpi_6y_lag  * cpi_7y_lag  * cpi_8y_lag ,3) as cpi_9y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag  * cpi_3y_lag  * cpi_4y_lag  * cpi_5y_lag  * cpi_6y_lag  * cpi_7y_lag  * cpi_8y_lag * cpi_9y_lag ,3) as cpi_10y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag  * cpi_3y_lag  * cpi_4y_lag  * cpi_5y_lag  * cpi_6y_lag  * cpi_7y_lag  * cpi_8y_lag * cpi_9y_lag * cpi_10y_lag ,3) as cpi_11y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag  * cpi_3y_lag  * cpi_4y_lag  * cpi_5y_lag  * cpi_6y_lag  * cpi_7y_lag  * cpi_8y_lag * cpi_9y_lag * cpi_10y_lag * cpi_11y_lag ,3) as cpi_12y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag  * cpi_3y_lag  * cpi_4y_lag  * cpi_5y_lag  * cpi_6y_lag  * cpi_7y_lag  * cpi_8y_lag * cpi_9y_lag * cpi_10y_lag * cpi_11y_lag * cpi_12y_lag ,3) as cpi_13y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag  * cpi_3y_lag  * cpi_4y_lag  * cpi_5y_lag  * cpi_6y_lag  * cpi_7y_lag  * cpi_8y_lag * cpi_9y_lag * cpi_10y_lag * cpi_11y_lag * cpi_12y_lag * cpi_13y_lag ,3) as cpi_14y
	 , ROUND(cpi * cpi_1y_lag * cpi_2y_lag  * cpi_3y_lag  * cpi_4y_lag  * cpi_5y_lag  * cpi_6y_lag  * cpi_7y_lag  * cpi_8y_lag * cpi_9y_lag * cpi_10y_lag * cpi_11y_lag * cpi_12y_lag * cpi_13y_lag * cpi_14y_lag ,3) as cpi_15y
FROM cpi_lags cl 
);


DROP TABLE IF EXISTS adding_cpi;
CREATE TABLE adding_cpi AS (
SELECT 
    pdir.*, 
    cpic.*
FROM 
    public.profit_days_in_row pdir
LEFT JOIN 
    public.cpi_cummulative cpic 
ON 
    EXTRACT(YEAR FROM pdir."Date") = cpic."Year" 
AND 
    EXTRACT(MONTH FROM pdir."Date") = cpic."month"
);


DROP TABLE IF EXISTS inflation_adjusted_yoy;
CREATE TABLE inflation_adjusted_yoy AS (
SELECT ac.* 
	, ROUND((((yoy_1 +1) / cpi) -1)::NUMERIC,4) as real_yoy_1
	, ROUND((((yoy_2 +1) / cpi_2y) -1)::NUMERIC,4) as real_yoy_2
	, ROUND((((yoy_3 +1) / cpi_3y) -1)::NUMERIC,4) as real_yoy_3
	, ROUND((((yoy_4 +1) / cpi_4y) -1)::NUMERIC,4) as real_yoy_4
	, ROUND((((yoy_5 +1) / cpi_5y) -1)::NUMERIC,4) as real_yoy_5
	, ROUND((((yoy_6 +1) / cpi_6y) -1)::NUMERIC,4) as real_yoy_6
	, ROUND((((yoy_7 +1) / cpi_7y) -1)::NUMERIC,4) as real_yoy_7
	, ROUND((((yoy_8 +1) / cpi_8y) -1)::NUMERIC,4) as real_yoy_8
	, ROUND((((yoy_9 +1) / cpi_9y) -1)::NUMERIC,4) as real_yoy_9
	, ROUND((((yoy_10 +1) / cpi_10y) -1)::NUMERIC,4) as real_yoy_10
	, ROUND((((yoy_11 +1) / cpi_11y) -1)::NUMERIC,4) as real_yoy_11
	, ROUND((((yoy_12 +1) / cpi_12y) -1)::NUMERIC,4) as real_yoy_12
	, ROUND((((yoy_13 +1) / cpi_13y) -1)::NUMERIC,4) as real_yoy_13
	, ROUND((((yoy_14 +1) / cpi_14y) -1)::NUMERIC,4) as real_yoy_14
	, ROUND((((yoy_15 +1) / cpi_15y) -1)::NUMERIC,4) as real_yoy_15
FROM public.adding_cpi ac
);

DROP TABLE IF EXISTS inflation_adjusted_profit_days  ;	
CREATE TABLE inflation_adjusted_profit_days as (
SELECT iayoy.*
, CASE WHEN real_yoy_1 > 0 THEN 1 
	   WHEN real_yoy_1 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_1_profit_days
, CASE WHEN real_yoy_2 > 0 THEN 1 
	   WHEN real_yoy_2 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_2_profit_days
, CASE WHEN real_yoy_3 > 0 THEN 1 
	   WHEN real_yoy_3 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_3_profit_days
, CASE WHEN real_yoy_4 > 0 THEN 1 
	   WHEN real_yoy_4 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_4_profit_days
, CASE WHEN real_yoy_5 > 0 THEN 1 
	   WHEN real_yoy_5 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_5_profit_days
, CASE WHEN real_yoy_6 > 0 THEN 1 
	   WHEN real_yoy_6 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_6_profit_days
, CASE WHEN real_yoy_7 > 0 THEN 1 
	   WHEN real_yoy_7 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_7_profit_days
, CASE WHEN real_yoy_8 > 0 THEN 1 
	   WHEN real_yoy_8 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_8_profit_days
, CASE WHEN real_yoy_9 > 0 THEN 1 
	   WHEN real_yoy_9 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_9_profit_days
, CASE WHEN real_yoy_10 > 0 THEN 1 
	   WHEN real_yoy_10 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_10_profit_days
, CASE WHEN real_yoy_11 > 0 THEN 1 
	   WHEN real_yoy_11 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_11_profit_days
, CASE WHEN real_yoy_12 > 0 THEN 1 
	   WHEN real_yoy_12 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_12_profit_days
, CASE WHEN real_yoy_13 > 0 THEN 1 
	   WHEN real_yoy_13 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_13_profit_days
, CASE WHEN real_yoy_14 > 0 THEN 1 
	   WHEN real_yoy_14 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_14_profit_days
, CASE WHEN real_yoy_15 > 0 THEN 1 
	   WHEN real_yoy_15 IS NULL THEN NULL
	   ELSE 0 END AS real_yoy_15_profit_days
FROM public.inflation_adjusted_yoy iayoy
);

DROP TABLE IF EXISTS inflation_adjusted_profit_days_in_row  ;	
CREATE TABLE inflation_adjusted_profit_days_in_row as (
SELECT
    *
    , CASE WHEN real_yoy_1_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp1 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_1y_profit_days_in_row
    , CASE WHEN real_yoy_2_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp2 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_2y_profit_days_in_row
    , CASE WHEN real_yoy_3_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp3 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_3y_profit_days_in_row
    , CASE WHEN real_yoy_4_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp4 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_4y_profit_days_in_row
    , CASE WHEN real_yoy_5_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp5 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_5y_profit_days_in_row
    , CASE WHEN real_yoy_6_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp6 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_6y_profit_days_in_row
    , CASE WHEN real_yoy_7_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp7 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_7y_profit_days_in_row
    , CASE WHEN real_yoy_8_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp8 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_8y_profit_days_in_row
    , CASE WHEN real_yoy_9_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp9 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_9y_profit_days_in_row
    , CASE WHEN real_yoy_10_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp10 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_10y_profit_days_in_row
    , CASE WHEN real_yoy_11_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp11 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_11y_profit_days_in_row
    , CASE WHEN real_yoy_12_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp12 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_12y_profit_days_in_row
    , CASE WHEN real_yoy_13_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp13 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_13y_profit_days_in_row
    , CASE WHEN real_yoy_14_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp14 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_14y_profit_days_in_row
    , CASE WHEN real_yoy_15_profit_days = 1 THEN ROW_NUMBER() OVER (PARTITION BY real_grp15 ORDER BY "Date") -1 ELSE NULL END AS real_yoy_15y_profit_days_in_row
FROM (
    SELECT
        *
        , SUM(CASE WHEN real_yoy_1_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp1
        , SUM(CASE WHEN real_yoy_2_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp2
        , SUM(CASE WHEN real_yoy_3_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp3
        , SUM(CASE WHEN real_yoy_4_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp4
        , SUM(CASE WHEN real_yoy_5_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp5
        , SUM(CASE WHEN real_yoy_6_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp6
        , SUM(CASE WHEN real_yoy_7_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp7
        , SUM(CASE WHEN real_yoy_8_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp8
        , SUM(CASE WHEN real_yoy_9_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp9
        , SUM(CASE WHEN real_yoy_10_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp10
        , SUM(CASE WHEN real_yoy_11_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp11
        , SUM(CASE WHEN real_yoy_12_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp12
        , SUM(CASE WHEN real_yoy_13_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp13
        , SUM(CASE WHEN real_yoy_14_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp14
        , SUM(CASE WHEN real_yoy_15_profit_days = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Date") AS real_grp15
    FROM
        public.inflation_adjusted_profit_days
) AS subquery
);


-- 15 YEAR VERSION --	

SELECT  "Date"
, "Close"
, yoy_1
, yoy_2
, yoy_3
, yoy_4
, yoy_5
, yoy_6
, yoy_7
, yoy_8
, yoy_9
, yoy_10
, yoy_11
, yoy_12
, yoy_13
, yoy_14
, yoy_15
, yoy_1_profit_days
, yoy_2_profit_days
, yoy_3_profit_days
, yoy_4_profit_days
, yoy_5_profit_days
, yoy_6_profit_days
, yoy_7_profit_days
, yoy_8_profit_days
, yoy_9_profit_days
, yoy_10_profit_days
, yoy_11_profit_days
, yoy_12_profit_days
, yoy_13_profit_days
, yoy_14_profit_days
, yoy_15_profit_days
, yoy_1y_profit_days_in_row
, yoy_2y_profit_days_in_row
, yoy_3y_profit_days_in_row
, yoy_4y_profit_days_in_row
, yoy_5y_profit_days_in_row
, yoy_6y_profit_days_in_row
, yoy_7y_profit_days_in_row
, yoy_8y_profit_days_in_row
, yoy_9y_profit_days_in_row
, yoy_10y_profit_days_in_row
, yoy_11y_profit_days_in_row
, yoy_12y_profit_days_in_row
, yoy_13y_profit_days_in_row
, yoy_14y_profit_days_in_row
, yoy_15y_profit_days_in_row
, cpi -1 as cpi 
, cpi_2y -1 as cpi_2y 
, cpi_3y -1 as cpi_3y
, cpi_4y -1 as cpi_4y
, cpi_5y -1 as cpi_5y
, cpi_6y -1 as cpi_6y
, cpi_7y -1 as cpi_7y
, cpi_8y -1 as cpi_8y
, cpi_9y -1 as cpi_9y
, cpi_10y -1 as cpi_10y
, cpi_11y -1 as cpi_11y
, cpi_12y -1 as cpi_12y
, cpi_13y -1 as cpi_13y
, cpi_14y -1 as cpi_14y
, cpi_15y -1 as cpi_15y
, real_yoy_1
, real_yoy_2
, real_yoy_3
, real_yoy_4
, real_yoy_5
, real_yoy_6
, real_yoy_7
, real_yoy_8
, real_yoy_9
, real_yoy_10
, real_yoy_11
, real_yoy_12
, real_yoy_13
, real_yoy_14
, real_yoy_15
, real_yoy_1_profit_days
, real_yoy_2_profit_days
, real_yoy_3_profit_days
, real_yoy_4_profit_days
, real_yoy_5_profit_days
, real_yoy_6_profit_days
, real_yoy_7_profit_days
, real_yoy_8_profit_days
, real_yoy_9_profit_days
, real_yoy_10_profit_days
, real_yoy_11_profit_days
, real_yoy_12_profit_days
, real_yoy_13_profit_days
, real_yoy_14_profit_days
, real_yoy_15_profit_days
, real_yoy_1y_profit_days_in_row
, real_yoy_2y_profit_days_in_row
, real_yoy_3y_profit_days_in_row
, real_yoy_4y_profit_days_in_row
, real_yoy_5y_profit_days_in_row
, real_yoy_6y_profit_days_in_row
, real_yoy_7y_profit_days_in_row
, real_yoy_8y_profit_days_in_row
, real_yoy_9y_profit_days_in_row
, real_yoy_10y_profit_days_in_row
, real_yoy_11y_profit_days_in_row
, real_yoy_12y_profit_days_in_row
, real_yoy_13y_profit_days_in_row
, real_yoy_14y_profit_days_in_row
, real_yoy_15y_profit_days_in_row
FROM  inflation_adjusted_profit_days_in_row

-- 30 YEAR VERSION --


-- SELECT
--   "Date"
--, "Close"
--, yoy_1
--, yoy_2
--, yoy_3
--, yoy_4
--, yoy_5
--, yoy_6
--, yoy_7
--, yoy_8
--, yoy_9
--, yoy_10
--, yoy_11
--, yoy_12
--, yoy_13
--, yoy_14
--, yoy_15
--, yoy_16
--, yoy_17
--, yoy_18
--, yoy_19
--, yoy_20
--, yoy_21
--, yoy_22
--, yoy_23
--, yoy_24
--, yoy_25
--, yoy_26
--, yoy_27
--, yoy_28
--, yoy_29
--, yoy_30
--, yoy_1_profit_days
--, yoy_2_profit_days
--, yoy_3_profit_days
--, yoy_4_profit_days
--, yoy_5_profit_days
--, yoy_6_profit_days
--, yoy_7_profit_days
--, yoy_8_profit_days
--, yoy_9_profit_days
--, yoy_10_profit_days
--, yoy_11_profit_days
--, yoy_12_profit_days
--, yoy_13_profit_days
--, yoy_14_profit_days
--, yoy_15_profit_days
--, yoy_16_profit_days
--, yoy_17_profit_days
--, yoy_18_profit_days
--, yoy_19_profit_days
--, yoy_20_profit_days
--, yoy_21_profit_days
--, yoy_22_profit_days
--, yoy_23_profit_days
--, yoy_24_profit_days
--, yoy_25_profit_days
--, yoy_26_profit_days
--, yoy_27_profit_days
--, yoy_28_profit_days
--, yoy_29_profit_days
--, yoy_30_profit_days
--, yoy_1y_profit_days_in_row
--, yoy_2y_profit_days_in_row
--, yoy_3y_profit_days_in_row
--, yoy_4y_profit_days_in_row
--, yoy_5y_profit_days_in_row
--, yoy_6y_profit_days_in_row
--, yoy_7y_profit_days_in_row
--, yoy_8y_profit_days_in_row
--, yoy_9y_profit_days_in_row
--, yoy_10y_profit_days_in_row
--, yoy_11y_profit_days_in_row
--, yoy_12y_profit_days_in_row
--, yoy_13y_profit_days_in_row
--, yoy_14y_profit_days_in_row
--, yoy_15y_profit_days_in_row
--, yoy_16y_profit_days_in_row
--, yoy_17y_profit_days_in_row
--, yoy_18y_profit_days_in_row
--, yoy_19y_profit_days_in_row
--, yoy_20y_profit_days_in_row
--, yoy_21y_profit_days_in_row
--, yoy_22y_profit_days_in_row
--, yoy_23y_profit_days_in_row
--, yoy_24y_profit_days_in_row
--, yoy_25y_profit_days_in_row
--, yoy_26y_profit_days_in_row
--, yoy_27y_profit_days_in_row
--, yoy_28y_profit_days_in_row
--, yoy_29y_profit_days_in_row
--, yoy_30y_profit_days_in_row
--, cpi -1 as cpi 
--, cpi_2y -1 as cpi_2y 
--, cpi_3y -1 as cpi_3y
--, cpi_4y -1 as cpi_4y
--, cpi_5y -1 as cpi_5y
--, cpi_6y -1 as cpi_6y
--, cpi_7y -1 as cpi_7y
--, cpi_8y -1 as cpi_8y
--, cpi_9y -1 as cpi_9y
--, cpi_10y -1 as cpi_10y
--, cpi_11y -1 as cpi_11y
--, cpi_12y -1 as cpi_12y
--, cpi_13y -1 as cpi_13y
--, cpi_14y -1 as cpi_14y
--, cpi_15y -1 as cpi_15y
--, cpi_16y - 1 as cpi_16y
--, cpi_17y - 1 as cpi_17y
--, cpi_18y - 1 as cpi_18y
--, cpi_19y - 1 as cpi_19y
--, cpi_20y - 1 as cpi_20y
--, cpi_21y - 1 as cpi_21y
--, cpi_22y - 1 as cpi_22y
--, cpi_23y - 1 as cpi_23y
--, cpi_24y - 1 as cpi_24y
--, cpi_25y - 1 as cpi_25y
--, cpi_26y - 1 as cpi_26y
--, cpi_27y - 1 as cpi_27y
--, cpi_28y - 1 as cpi_28y
--, cpi_29y - 1 as cpi_29y
--, cpi_30y - 1 as cpi_30y
--, real_yoy_1
--, real_yoy_2
--, real_yoy_3
--, real_yoy_4
--, real_yoy_5
--, real_yoy_6
--, real_yoy_7
--, real_yoy_8
--, real_yoy_9
--, real_yoy_10
--, real_yoy_11
--, real_yoy_12
--, real_yoy_13
--, real_yoy_14
--, real_yoy_15
--, real_yoy_16
--, real_yoy_17
--, real_yoy_18
--, real_yoy_19
--, real_yoy_20
--, real_yoy_21
--, real_yoy_22
--, real_yoy_23
--, real_yoy_24
--, real_yoy_25
--, real_yoy_26
--, real_yoy_27
--, real_yoy_28
--, real_yoy_29
--, real_yoy_30
--, real_yoy_1_profit_days
--, real_yoy_2_profit_days
--, real_yoy_3_profit_days
--, real_yoy_4_profit_days
--, real_yoy_5_profit_days
--, real_yoy_6_profit_days
--, real_yoy_7_profit_days
--, real_yoy_8_profit_days
--, real_yoy_9_profit_days
--, real_yoy_10_profit_days
--, real_yoy_11_profit_days
--, real_yoy_12_profit_days
--, real_yoy_13_profit_days
--, real_yoy_14_profit_days
--, real_yoy_15_profit_days
--, real_yoy_16_profit_days
--, real_yoy_17_profit_days
--, real_yoy_18_profit_days
--, real_yoy_19_profit_days
--, real_yoy_20_profit_days
--, real_yoy_21_profit_days
--, real_yoy_22_profit_days
--, real_yoy_23_profit_days
--, real_yoy_24_profit_days
--, real_yoy_25_profit_days
--, real_yoy_26_profit_days
--, real_yoy_27_profit_days
--, real_yoy_28_profit_days
--, real_yoy_29_profit_days
--, real_yoy_30_profit_days
--, real_yoy_1y_profit_days_in_row
--, real_yoy_2y_profit_days_in_row
--, real_yoy_3y_profit_days_in_row
--, real_yoy_4y_profit_days_in_row
--, real_yoy_5y_profit_days_in_row
--, real_yoy_6y_profit_days_in_row
--, real_yoy_7y_profit_days_in_row
--, real_yoy_8y_profit_days_in_row
--, real_yoy_9y_profit_days_in_row
--, real_yoy_10y_profit_days_in_row
--, real_yoy_11y_profit_days_in_row
--, real_yoy_12y_profit_days_in_row
--, real_yoy_13y_profit_days_in_row
--, real_yoy_14y_profit_days_in_row
--, real_yoy_15y_profit_days_in_row
--, real_yoy_16y_profit_days_in_row
--, real_yoy_17y_profit_days_in_row
--, real_yoy_18y_profit_days_in_row
--, real_yoy_19y_profit_days_in_row
--, real_yoy_20y_profit_days_in_row
--, real_yoy_21y_profit_days_in_row
--, real_yoy_22y_profit_days_in_row
--, real_yoy_23y_profit_days_in_row
--, real_yoy_24y_profit_days_in_row
--, real_yoy_25y_profit_days_in_row
--, real_yoy_26y_profit_days_in_row
--, real_yoy_27y_profit_days_in_row
--, real_yoy_28y_profit_days_in_row
--, real_yoy_29y_profit_days_in_row
--, real_yoy_30y_profit_days_in_row

-- FROM  inflation_adjusted_profit_days_in_row
-- order by "Date"

-- 5 YEAR JUMP VERSION

--
--SELECT  
--    "Date",
--    "Close",
--    yoy_1,
--    yoy_5,
--    yoy_10,
--    yoy_15,
--    yoy_20,
--    yoy_25,
--    yoy_30,
--    yoy_1_profit_days,
--    yoy_5_profit_days,
--    yoy_10_profit_days,
--    yoy_15_profit_days,
--    yoy_20_profit_days,
--    yoy_25_profit_days,
--    yoy_30_profit_days,
--    yoy_1y_profit_days_in_row,
--    yoy_5y_profit_days_in_row,
--    yoy_10y_profit_days_in_row,
--    yoy_15y_profit_days_in_row,
--    yoy_20y_profit_days_in_row,
--    yoy_25y_profit_days_in_row,
--    yoy_30y_profit_days_in_row,
--    cpi - 1 as cpi,
--    cpi_5y - 1 as cpi_5y,
--    cpi_10y - 1 as cpi_10y,
--    cpi_15y - 1 as cpi_15y,
--    cpi_20y - 1 as cpi_20y,
--    cpi_25y - 1 as cpi_25y,
--    cpi_30y - 1 as cpi_30y,
--    real_yoy_1,
--    real_yoy_5,
--    real_yoy_10,
--    real_yoy_15,
--    real_yoy_20,
--    real_yoy_25,
--    real_yoy_30,
--    real_yoy_1_profit_days,
--    real_yoy_5_profit_days,
--    real_yoy_10_profit_days,
--    real_yoy_15_profit_days,
--    real_yoy_20_profit_days,
--    real_yoy_25_profit_days,
--    real_yoy_30_profit_days,
--    real_yoy_1y_profit_days_in_row,
--    real_yoy_5y_profit_days_in_row,
--    real_yoy_10y_profit_days_in_row,
--    real_yoy_15y_profit_days_in_row,
--    real_yoy_20y_profit_days_in_row,
--    real_yoy_25y_profit_days_in_row,
--    real_yoy_30y_profit_days_in_row
--
--FROM  
--    inflation_adjusted_profit_days_in_row



-- ACCUMULATED VERSION --

SELECT
   "Date"
, ROUND(((yoy_1 + yoy_2 + yoy_3 + yoy_4 + yoy_5 + 5)/5)-1 ::NUMERIC,4) AS acc_5y_yoy
, ROUND(((yoy_1 + yoy_2 + yoy_3 + yoy_4 + yoy_5 + yoy_6 + yoy_7 + yoy_8 + yoy_9 + yoy_10 + 10) / 10)-1 ::NUMERIC,4) AS acc_10y_yoy
, ROUND(((yoy_1 + yoy_2 + yoy_3 + yoy_4 + yoy_5 + yoy_6 + yoy_7 + yoy_8 + yoy_9 + yoy_10 + yoy_11 + yoy_12 + yoy_13 + yoy_14 + yoy_15 + 15) / 15)-1 ::NUMERIC,4) AS acc_15y_yoy
, ROUND(((yoy_1 + yoy_2 + yoy_3 + yoy_4 + yoy_5 + yoy_6 + yoy_7 + yoy_8 + yoy_9 + yoy_10 + yoy_11 + yoy_12 + yoy_13 + yoy_14 + yoy_15 + yoy_16 + yoy_17 + yoy_18 + yoy_19 + yoy_20 + 20) / 20)-1 ::NUMERIC,4) AS acc_20y_yoy
, ROUND(((yoy_1 + yoy_2 + yoy_3 + yoy_4 + yoy_5 + yoy_6 + yoy_7 + yoy_8 + yoy_9 + yoy_10 + yoy_11 + yoy_12 + yoy_13 + yoy_14 + yoy_15 + yoy_16 + yoy_17 + yoy_18 + yoy_19 + yoy_20 + yoy_21 + yoy_22 + yoy_23 + yoy_24 + yoy_25 + 25) / 25)-1 ::NUMERIC,4) AS acc_25y_yoy
, ROUND(((yoy_1 + yoy_2 + yoy_3 + yoy_4 + yoy_5 + yoy_6 + yoy_7 + yoy_8 + yoy_9 + yoy_10 + yoy_11 + yoy_12 + yoy_13 + yoy_14 + yoy_15 + yoy_16 + yoy_17 + yoy_18 + yoy_19 + yoy_20 + yoy_21 + yoy_22 + yoy_23 + yoy_24 + yoy_25 + yoy_26 + yoy_27 + yoy_28 + yoy_29 + yoy_30 + 30) / 30)-1 ::NUMERIC,4) AS acc_30y_yoy
, ROUND(((real_yoy_1 + real_yoy_2 + real_yoy_3 + real_yoy_4 + real_yoy_5 + 5) / 5)-1 ::NUMERIC,4) AS acc_real_5y_yoy
, ROUND(((real_yoy_1 + real_yoy_2 + real_yoy_3 + real_yoy_4 + real_yoy_5 + real_yoy_6 + real_yoy_7 + real_yoy_8 + real_yoy_9 + real_yoy_10 + 10) / 10)-1 ::NUMERIC,4) AS acc_real_10y_yoy
, ROUND(((real_yoy_1 + real_yoy_2 + real_yoy_3 + real_yoy_4 + real_yoy_5 + real_yoy_6 + real_yoy_7 + real_yoy_8 + real_yoy_9 + real_yoy_10 + real_yoy_11 + real_yoy_12 + real_yoy_13 + real_yoy_14 + real_yoy_15 + 15) / 15)-1 ::NUMERIC,4) AS acc_real_15y_yoy
, ROUND(((real_yoy_1 + real_yoy_2 + real_yoy_3 + real_yoy_4 + real_yoy_5 + real_yoy_6 + real_yoy_7 + real_yoy_8 + real_yoy_9 + real_yoy_10 + real_yoy_11 + real_yoy_12 + real_yoy_13 + real_yoy_14 + real_yoy_15 + real_yoy_16 + real_yoy_17 + real_yoy_18 + real_yoy_19 + real_yoy_20 + 20) / 20)-1 ::NUMERIC,4) AS acc_real_20y_yoy
, ROUND(((real_yoy_1 + real_yoy_2 + real_yoy_3 + real_yoy_4 + real_yoy_5 + real_yoy_6 + real_yoy_7 + real_yoy_8 + real_yoy_9 + real_yoy_10 + real_yoy_11 + real_yoy_12 + real_yoy_13 + real_yoy_14 + real_yoy_15 + real_yoy_16 + real_yoy_17 + real_yoy_18 + real_yoy_19 + real_yoy_20 + real_yoy_21 + real_yoy_22 + real_yoy_23 + real_yoy_24 + real_yoy_25 + 25) / 25)-1::NUMERIC,4) AS acc_real_25y_yoy
, ROUND(((real_yoy_1 + real_yoy_2 + real_yoy_3 + real_yoy_4 + real_yoy_5 + real_yoy_6 + real_yoy_7 + real_yoy_8 + real_yoy_9 + real_yoy_10 + real_yoy_11 + real_yoy_12 + real_yoy_13 + real_yoy_14 + real_yoy_15 + real_yoy_16 + real_yoy_17 + real_yoy_18 + real_yoy_19 + real_yoy_20 + real_yoy_21 + real_yoy_22 + real_yoy_23 + real_yoy_24 + real_yoy_25 + real_yoy_26 + real_yoy_27 + real_yoy_28 + real_yoy_29 + real_yoy_30 + 30) / 30)-1::NUMERIC,4) AS acc_real_30y_yoy


FROM  inflation_adjusted_profit_days_in_row
where real_yoy_5 is not null 
order by "Date"


