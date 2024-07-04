-- 1ST VERSION : 15 YEARS --


DROP TABLE IF EXISTS yearly_prep_one  ;	
CREATE TABLE yearly_prep_one as (
with subquery as (
select 
"Year" ,
min(date_part('day',"Date")) AS first_trading_day_of_year
FROM inflation_adjusted_profit_days_in_row
where date_part('month',"Date") = 2
group by "Year"
)
select iaprdir.*
from inflation_adjusted_profit_days_in_row iaprdir
join subquery on date_part('day',iaprdir."Date") = subquery.first_trading_day_of_year
and date_part('year',"Date") = subquery."Year"
where date_part('month',"Date") = 2 
order by "Date"
);


DROP TABLE IF EXISTS yearly_prep_two  ;	
CREATE TABLE yearly_prep_two as (
SELECT
    ypo.*
    , CASE WHEN yoy_1 > 0 THEN 1
    WHEN yoy_1 IS NULL THEN NULL
    ELSE 0 END AS yoy_1_profit_years
    , CASE WHEN yoy_2 > 0 THEN 1
    WHEN yoy_2 IS NULL THEN NULL
    ELSE 0 END AS yoy_2_profit_years
    , CASE WHEN yoy_3 > 0 THEN 1
    WHEN yoy_3 IS NULL THEN NULL
    ELSE 0 END AS yoy_3_profit_years
    , CASE WHEN yoy_4 > 0 THEN 1
    WHEN yoy_4 IS NULL THEN NULL
    ELSE 0 END AS yoy_4_profit_years
    , CASE WHEN yoy_5 > 0 THEN 1
    WHEN yoy_5 IS NULL THEN NULL
    ELSE 0 END AS yoy_5_profit_years
    , CASE WHEN yoy_6 > 0 THEN 1
    WHEN yoy_6 IS NULL THEN NULL
    ELSE 0 END AS yoy_6_profit_years
    , CASE WHEN yoy_7 > 0 THEN 1
    WHEN yoy_7 IS NULL THEN NULL
    ELSE 0 END AS yoy_7_profit_years
    , CASE WHEN yoy_8 > 0 THEN 1
    WHEN yoy_8 IS NULL THEN NULL
    ELSE 0 END AS yoy_8_profit_years
    , CASE WHEN yoy_9 > 0 THEN 1
    WHEN yoy_9 IS NULL THEN NULL
    ELSE 0 END AS yoy_9_profit_years
    , CASE WHEN yoy_10 > 0 THEN 1
    WHEN yoy_10 IS NULL THEN NULL
    ELSE 0 END AS yoy_10_profit_years
    , CASE WHEN yoy_11 > 0 THEN 1
    WHEN yoy_11 IS NULL THEN NULL
    ELSE 0 END AS yoy_11_profit_years
    , CASE WHEN yoy_12 > 0 THEN 1
    WHEN yoy_12 IS NULL THEN NULL
    ELSE 0 END AS yoy_12_profit_years
    , CASE WHEN yoy_13 > 0 THEN 1
    WHEN yoy_13 IS NULL THEN NULL
    ELSE 0 END AS yoy_13_profit_years
    , CASE WHEN yoy_14 > 0 THEN 1
    WHEN yoy_14 IS NULL THEN NULL
    ELSE 0 END AS yoy_14_profit_years
    , CASE WHEN yoy_15 > 0 THEN 1
    WHEN yoy_15 IS NULL THEN NULL
    ELSE 0 END AS yoy_15_profit_years
FROM yearly_prep_one ypo
);


DROP TABLE IF EXISTS yearly_prep_three  ;	
CREATE TABLE yearly_prep_three as (
SELECT
ypt.*
    , CASE WHEN real_yoy_1 > 0 THEN 1
    WHEN real_yoy_1 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_1_profit_years
    , CASE WHEN real_yoy_2 > 0 THEN 1
    WHEN real_yoy_2 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_2_profit_years
    , CASE WHEN real_yoy_3 > 0 THEN 1
    WHEN real_yoy_3 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_3_profit_years
    , CASE WHEN real_yoy_4 > 0 THEN 1
    WHEN real_yoy_4 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_4_profit_years
    , CASE WHEN real_yoy_5 > 0 THEN 1
    WHEN real_yoy_5 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_5_profit_years
    , CASE WHEN real_yoy_6 > 0 THEN 1
    WHEN real_yoy_6 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_6_profit_years
    , CASE WHEN real_yoy_7 > 0 THEN 1
    WHEN real_yoy_7 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_7_profit_years
    , CASE WHEN real_yoy_8 > 0 THEN 1
    WHEN real_yoy_8 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_8_profit_years
    , CASE WHEN real_yoy_9 > 0 THEN 1
    WHEN real_yoy_9 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_9_profit_years
    , CASE WHEN real_yoy_10 > 0 THEN 1
    WHEN real_yoy_10 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_10_profit_years
    , CASE WHEN real_yoy_11 > 0 THEN 1
    WHEN real_yoy_11 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_11_profit_years
    , CASE WHEN real_yoy_12 > 0 THEN 1
    WHEN real_yoy_12 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_12_profit_years
    , CASE WHEN real_yoy_13 > 0 THEN 1
    WHEN real_yoy_13 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_13_profit_years
    , CASE WHEN real_yoy_14 > 0 THEN 1
    WHEN real_yoy_14 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_14_profit_years
    , CASE WHEN real_yoy_15 > 0 THEN 1
    WHEN real_yoy_15 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_15_profit_years
    FROM yearly_prep_two ypt
);

 

DROP TABLE IF EXISTS yearly_prep_four  ;	
CREATE TABLE yearly_prep_four as (
SELECT
    *
    , CASE WHEN yoy_1_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp1 ORDER BY "Year") -1 ELSE NULL END AS yoy_1y_profit_years_in_row
    , CASE WHEN yoy_2_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp2 ORDER BY "Year") -1 ELSE NULL END AS yoy_2y_profit_years_in_row
    , CASE WHEN yoy_3_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp3 ORDER BY "Year") -1 ELSE NULL END AS yoy_3y_profit_years_in_row
    , CASE WHEN yoy_4_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp4 ORDER BY "Year") -1 ELSE NULL END AS yoy_4y_profit_years_in_row
    , CASE WHEN yoy_5_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp5 ORDER BY "Year") -1 ELSE NULL END AS yoy_5y_profit_years_in_row
    , CASE WHEN yoy_6_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp6 ORDER BY "Year") -1 ELSE NULL END AS yoy_6y_profit_years_in_row
    , CASE WHEN yoy_7_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp7 ORDER BY "Year") -1 ELSE NULL END AS yoy_7y_profit_years_in_row
    , CASE WHEN yoy_8_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp8 ORDER BY "Year") -1 ELSE NULL END AS yoy_8y_profit_years_in_row
    , CASE WHEN yoy_9_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp9 ORDER BY "Year") -1 ELSE NULL END AS yoy_9y_profit_years_in_row
    , CASE WHEN yoy_10_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp10 ORDER BY "Year") -1 ELSE NULL END AS yoy_10y_profit_years_in_row
    , CASE WHEN yoy_11_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp11 ORDER BY "Year") -1 ELSE NULL END AS yoy_11y_profit_years_in_row
    , CASE WHEN yoy_12_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp12 ORDER BY "Year") -1 ELSE NULL END AS yoy_12y_profit_years_in_row
    , CASE WHEN yoy_13_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp13 ORDER BY "Year") -1 ELSE NULL END AS yoy_13y_profit_years_in_row
    , CASE WHEN yoy_14_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp14 ORDER BY "Year") -1 ELSE NULL END AS yoy_14y_profit_years_in_row
    , CASE WHEN yoy_15_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp15 ORDER BY "Year") -1 ELSE NULL END AS yoy_15y_profit_years_in_row
    , CASE WHEN real_yoy_1_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp1 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_1y_profit_years_in_row
    , CASE WHEN real_yoy_2_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp2 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_2y_profit_years_in_row
    , CASE WHEN real_yoy_3_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp3 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_3y_profit_years_in_row
    , CASE WHEN real_yoy_4_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp4 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_4y_profit_years_in_row
    , CASE WHEN real_yoy_5_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp5 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_5y_profit_years_in_row
    , CASE WHEN real_yoy_6_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp6 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_6y_profit_years_in_row
    , CASE WHEN real_yoy_7_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp7 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_7y_profit_years_in_row
    , CASE WHEN real_yoy_8_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp8 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_8y_profit_years_in_row
    , CASE WHEN real_yoy_9_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp9 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_9y_profit_years_in_row
    , CASE WHEN real_yoy_10_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp10 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_10y_profit_years_in_row
    , CASE WHEN real_yoy_11_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp11 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_11y_profit_years_in_row
    , CASE WHEN real_yoy_12_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp12 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_12y_profit_years_in_row
    , CASE WHEN real_yoy_13_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp13 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_13y_profit_years_in_row
    , CASE WHEN real_yoy_14_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp14 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_14y_profit_years_in_row
    , CASE WHEN real_yoy_15_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp15 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_15y_profit_years_in_row
FROM (
    SELECT
        *
        , SUM(CASE WHEN yoy_1_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp1
        , SUM(CASE WHEN yoy_2_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp2
        , SUM(CASE WHEN yoy_3_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp3
        , SUM(CASE WHEN yoy_4_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp4
        , SUM(CASE WHEN yoy_5_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp5
        , SUM(CASE WHEN yoy_6_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp6
        , SUM(CASE WHEN yoy_7_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp7
        , SUM(CASE WHEN yoy_8_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp8
        , SUM(CASE WHEN yoy_9_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp9
        , SUM(CASE WHEN yoy_10_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp10
        , SUM(CASE WHEN yoy_11_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp11
        , SUM(CASE WHEN yoy_12_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp12
        , SUM(CASE WHEN yoy_13_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp13
        , SUM(CASE WHEN yoy_14_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp14
        , SUM(CASE WHEN yoy_15_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp15
        , SUM(CASE WHEN real_yoy_1_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp1
        , SUM(CASE WHEN real_yoy_2_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp2
        , SUM(CASE WHEN real_yoy_3_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp3
        , SUM(CASE WHEN real_yoy_4_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp4
        , SUM(CASE WHEN real_yoy_5_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp5
        , SUM(CASE WHEN real_yoy_6_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp6
        , SUM(CASE WHEN real_yoy_7_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp7
        , SUM(CASE WHEN real_yoy_8_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp8
        , SUM(CASE WHEN real_yoy_9_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp9
        , SUM(CASE WHEN real_yoy_10_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp10
        , SUM(CASE WHEN real_yoy_11_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp11
        , SUM(CASE WHEN real_yoy_12_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp12
        , SUM(CASE WHEN real_yoy_13_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp13
        , SUM(CASE WHEN real_yoy_14_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp14
        , SUM(CASE WHEN real_yoy_15_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp15
    FROM
        public.yearly_prep_three
) AS subquery
);


select
"Year"
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
, yoy_1_profit_years
, yoy_2_profit_years
, yoy_3_profit_years
, yoy_4_profit_years
, yoy_5_profit_years
, yoy_6_profit_years
, yoy_7_profit_years
, yoy_8_profit_years
, yoy_9_profit_years
, yoy_10_profit_years
, yoy_11_profit_years
, yoy_12_profit_years
, yoy_13_profit_years
, yoy_14_profit_years
, yoy_15_profit_years
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
, real_yoy_1_profit_years
, real_yoy_2_profit_years
, real_yoy_3_profit_years
, real_yoy_4_profit_years
, real_yoy_5_profit_years
, real_yoy_6_profit_years
, real_yoy_7_profit_years
, real_yoy_8_profit_years
, real_yoy_9_profit_years
, real_yoy_10_profit_years
, real_yoy_11_profit_years
, real_yoy_12_profit_years
, real_yoy_13_profit_years
, real_yoy_14_profit_years
, real_yoy_15_profit_years
, yoy_1y_profit_years_in_row
, yoy_2y_profit_years_in_row
, yoy_3y_profit_years_in_row
, yoy_4y_profit_years_in_row
, yoy_5y_profit_years_in_row
, yoy_6y_profit_years_in_row
, yoy_7y_profit_years_in_row
, yoy_8y_profit_years_in_row
, yoy_9y_profit_years_in_row
, yoy_10y_profit_years_in_row
, yoy_11y_profit_years_in_row
, yoy_12y_profit_years_in_row
, yoy_13y_profit_years_in_row
, yoy_14y_profit_years_in_row
, yoy_15y_profit_years_in_row
, real_yoy_1y_profit_years_in_row
, real_yoy_2y_profit_years_in_row
, real_yoy_3y_profit_years_in_row
, real_yoy_4y_profit_years_in_row
, real_yoy_5y_profit_years_in_row
, real_yoy_6y_profit_years_in_row
, real_yoy_7y_profit_years_in_row
, real_yoy_8y_profit_years_in_row
, real_yoy_9y_profit_years_in_row
, real_yoy_10y_profit_years_in_row
, real_yoy_11y_profit_years_in_row
, real_yoy_12y_profit_years_in_row
, real_yoy_13y_profit_years_in_row
, real_yoy_14y_profit_years_in_row
, real_yoy_15y_profit_years_in_row
,"Close"
from yearly_prep_four

-- SECOND VERSION : 30 years



DROP TABLE IF EXISTS yearly_prep_one  ;	
CREATE TABLE yearly_prep_one as (
with subquery as (
select 
"Year" ,
min(date_part('day',"Date")) AS first_trading_day_of_year
FROM inflation_adjusted_profit_days_in_row
where date_part('month',"Date") = 2
group by "Year"
)
select iaprdir.*
from inflation_adjusted_profit_days_in_row iaprdir
join subquery on date_part('day',iaprdir."Date") = subquery.first_trading_day_of_year
and date_part('year',"Date") = subquery."Year"
where date_part('month',"Date") = 2 
order by "Date"
);


DROP TABLE IF EXISTS yearly_prep_two  ;	
CREATE TABLE yearly_prep_two as (
SELECT
    ypo.*
    , CASE WHEN yoy_1 > 0 THEN 1
    WHEN yoy_1 IS NULL THEN NULL
    ELSE 0 END AS yoy_1_profit_years
    , CASE WHEN yoy_2 > 0 THEN 1
    WHEN yoy_2 IS NULL THEN NULL
    ELSE 0 END AS yoy_2_profit_years
    , CASE WHEN yoy_3 > 0 THEN 1
    WHEN yoy_3 IS NULL THEN NULL
    ELSE 0 END AS yoy_3_profit_years
    , CASE WHEN yoy_4 > 0 THEN 1
    WHEN yoy_4 IS NULL THEN NULL
    ELSE 0 END AS yoy_4_profit_years
    , CASE WHEN yoy_5 > 0 THEN 1
    WHEN yoy_5 IS NULL THEN NULL
    ELSE 0 END AS yoy_5_profit_years
    , CASE WHEN yoy_6 > 0 THEN 1
    WHEN yoy_6 IS NULL THEN NULL
    ELSE 0 END AS yoy_6_profit_years
    , CASE WHEN yoy_7 > 0 THEN 1
    WHEN yoy_7 IS NULL THEN NULL
    ELSE 0 END AS yoy_7_profit_years
    , CASE WHEN yoy_8 > 0 THEN 1
    WHEN yoy_8 IS NULL THEN NULL
    ELSE 0 END AS yoy_8_profit_years
    , CASE WHEN yoy_9 > 0 THEN 1
    WHEN yoy_9 IS NULL THEN NULL
    ELSE 0 END AS yoy_9_profit_years
    , CASE WHEN yoy_10 > 0 THEN 1
    WHEN yoy_10 IS NULL THEN NULL
    ELSE 0 END AS yoy_10_profit_years
    , CASE WHEN yoy_11 > 0 THEN 1
    WHEN yoy_11 IS NULL THEN NULL
    ELSE 0 END AS yoy_11_profit_years
    , CASE WHEN yoy_12 > 0 THEN 1
    WHEN yoy_12 IS NULL THEN NULL
    ELSE 0 END AS yoy_12_profit_years
    , CASE WHEN yoy_13 > 0 THEN 1
    WHEN yoy_13 IS NULL THEN NULL
    ELSE 0 END AS yoy_13_profit_years
    , CASE WHEN yoy_14 > 0 THEN 1
    WHEN yoy_14 IS NULL THEN NULL
    ELSE 0 END AS yoy_14_profit_years
    , CASE WHEN yoy_15 > 0 THEN 1
    WHEN yoy_15 IS NULL THEN NULL
    ELSE 0 END AS yoy_15_profit_years
, CASE WHEN yoy_16 > 0 THEN 1
    WHEN yoy_16 IS NULL THEN NULL
    ELSE 0 END AS yoy_16_profit_years
, CASE WHEN yoy_17 > 0 THEN 1
    WHEN yoy_17 IS NULL THEN NULL
    ELSE 0 END AS yoy_17_profit_years
, CASE WHEN yoy_18 > 0 THEN 1
    WHEN yoy_18 IS NULL THEN NULL
    ELSE 0 END AS yoy_18_profit_years
, CASE WHEN yoy_19 > 0 THEN 1
    WHEN yoy_19 IS NULL THEN NULL
    ELSE 0 END AS yoy_19_profit_years
, CASE WHEN yoy_20 > 0 THEN 1
    WHEN yoy_20 IS NULL THEN NULL
    ELSE 0 END AS yoy_20_profit_years
, CASE WHEN yoy_21 > 0 THEN 1
    WHEN yoy_21 IS NULL THEN NULL
    ELSE 0 END AS yoy_21_profit_years
, CASE WHEN yoy_22 > 0 THEN 1
    WHEN yoy_22 IS NULL THEN NULL
    ELSE 0 END AS yoy_22_profit_years
, CASE WHEN yoy_23 > 0 THEN 1
    WHEN yoy_23 IS NULL THEN NULL
    ELSE 0 END AS yoy_23_profit_years
, CASE WHEN yoy_24 > 0 THEN 1
    WHEN yoy_24 IS NULL THEN NULL
    ELSE 0 END AS yoy_24_profit_years
, CASE WHEN yoy_25 > 0 THEN 1
    WHEN yoy_25 IS NULL THEN NULL
    ELSE 0 END AS yoy_25_profit_years
, CASE WHEN yoy_26 > 0 THEN 1
    WHEN yoy_26 IS NULL THEN NULL
    ELSE 0 END AS yoy_26_profit_years
, CASE WHEN yoy_27 > 0 THEN 1
    WHEN yoy_27 IS NULL THEN NULL
    ELSE 0 END AS yoy_27_profit_years
, CASE WHEN yoy_28 > 0 THEN 1
    WHEN yoy_28 IS NULL THEN NULL
    ELSE 0 END AS yoy_28_profit_years
, CASE WHEN yoy_29 > 0 THEN 1
    WHEN yoy_29 IS NULL THEN NULL
    ELSE 0 END AS yoy_29_profit_years
, CASE WHEN yoy_30 > 0 THEN 1
    WHEN yoy_30 IS NULL THEN NULL
    ELSE 0 END AS yoy_30_profit_years
FROM yearly_prep_one ypo
);


DROP TABLE IF EXISTS yearly_prep_three  ;	
CREATE TABLE yearly_prep_three as (
SELECT
ypt.*
    , CASE WHEN real_yoy_1 > 0 THEN 1
    WHEN real_yoy_1 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_1_profit_years
    , CASE WHEN real_yoy_2 > 0 THEN 1
    WHEN real_yoy_2 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_2_profit_years
    , CASE WHEN real_yoy_3 > 0 THEN 1
    WHEN real_yoy_3 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_3_profit_years
    , CASE WHEN real_yoy_4 > 0 THEN 1
    WHEN real_yoy_4 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_4_profit_years
    , CASE WHEN real_yoy_5 > 0 THEN 1
    WHEN real_yoy_5 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_5_profit_years
    , CASE WHEN real_yoy_6 > 0 THEN 1
    WHEN real_yoy_6 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_6_profit_years
    , CASE WHEN real_yoy_7 > 0 THEN 1
    WHEN real_yoy_7 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_7_profit_years
    , CASE WHEN real_yoy_8 > 0 THEN 1
    WHEN real_yoy_8 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_8_profit_years
    , CASE WHEN real_yoy_9 > 0 THEN 1
    WHEN real_yoy_9 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_9_profit_years
    , CASE WHEN real_yoy_10 > 0 THEN 1
    WHEN real_yoy_10 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_10_profit_years
    , CASE WHEN real_yoy_11 > 0 THEN 1
    WHEN real_yoy_11 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_11_profit_years
    , CASE WHEN real_yoy_12 > 0 THEN 1
    WHEN real_yoy_12 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_12_profit_years
    , CASE WHEN real_yoy_13 > 0 THEN 1
    WHEN real_yoy_13 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_13_profit_years
    , CASE WHEN real_yoy_14 > 0 THEN 1
    WHEN real_yoy_14 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_14_profit_years
    , CASE WHEN real_yoy_15 > 0 THEN 1
    WHEN real_yoy_15 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_15_profit_years
, CASE WHEN real_yoy_16 > 0 THEN 1
    WHEN real_yoy_16 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_16_profit_years
, CASE WHEN real_yoy_17 > 0 THEN 1
    WHEN real_yoy_17 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_17_profit_years
, CASE WHEN real_yoy_18 > 0 THEN 1
    WHEN real_yoy_18 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_18_profit_years
, CASE WHEN real_yoy_19 > 0 THEN 1
    WHEN real_yoy_19 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_19_profit_years
, CASE WHEN real_yoy_20 > 0 THEN 1
    WHEN real_yoy_20 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_20_profit_years
, CASE WHEN real_yoy_21 > 0 THEN 1
    WHEN real_yoy_21 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_21_profit_years
, CASE WHEN real_yoy_22 > 0 THEN 1
    WHEN real_yoy_22 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_22_profit_years
, CASE WHEN real_yoy_23 > 0 THEN 1
    WHEN real_yoy_23 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_23_profit_years
, CASE WHEN real_yoy_24 > 0 THEN 1
    WHEN real_yoy_24 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_24_profit_years
, CASE WHEN real_yoy_25 > 0 THEN 1
    WHEN real_yoy_25 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_25_profit_years
, CASE WHEN real_yoy_26 > 0 THEN 1
    WHEN real_yoy_26 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_26_profit_years
, CASE WHEN real_yoy_27 > 0 THEN 1
    WHEN real_yoy_27 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_27_profit_years
, CASE WHEN real_yoy_28 > 0 THEN 1
    WHEN real_yoy_28 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_28_profit_years
, CASE WHEN real_yoy_29 > 0 THEN 1
    WHEN real_yoy_29 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_29_profit_years
, CASE WHEN real_yoy_30 > 0 THEN 1
    WHEN real_yoy_30 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_30_profit_years
    FROM yearly_prep_two ypt
);

 

DROP TABLE IF EXISTS yearly_prep_four  ;	
CREATE TABLE yearly_prep_four as (
SELECT
    *
    , CASE WHEN yoy_1_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp1 ORDER BY "Year") -1 ELSE NULL END AS yoy_1y_profit_years_in_row
    , CASE WHEN yoy_2_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp2 ORDER BY "Year") -1 ELSE NULL END AS yoy_2y_profit_years_in_row
    , CASE WHEN yoy_3_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp3 ORDER BY "Year") -1 ELSE NULL END AS yoy_3y_profit_years_in_row
    , CASE WHEN yoy_4_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp4 ORDER BY "Year") -1 ELSE NULL END AS yoy_4y_profit_years_in_row
    , CASE WHEN yoy_5_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp5 ORDER BY "Year") -1 ELSE NULL END AS yoy_5y_profit_years_in_row
    , CASE WHEN yoy_6_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp6 ORDER BY "Year") -1 ELSE NULL END AS yoy_6y_profit_years_in_row
    , CASE WHEN yoy_7_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp7 ORDER BY "Year") -1 ELSE NULL END AS yoy_7y_profit_years_in_row
    , CASE WHEN yoy_8_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp8 ORDER BY "Year") -1 ELSE NULL END AS yoy_8y_profit_years_in_row
    , CASE WHEN yoy_9_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp9 ORDER BY "Year") -1 ELSE NULL END AS yoy_9y_profit_years_in_row
    , CASE WHEN yoy_10_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp10 ORDER BY "Year") -1 ELSE NULL END AS yoy_10y_profit_years_in_row
    , CASE WHEN yoy_11_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp11 ORDER BY "Year") -1 ELSE NULL END AS yoy_11y_profit_years_in_row
    , CASE WHEN yoy_12_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp12 ORDER BY "Year") -1 ELSE NULL END AS yoy_12y_profit_years_in_row
    , CASE WHEN yoy_13_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp13 ORDER BY "Year") -1 ELSE NULL END AS yoy_13y_profit_years_in_row
    , CASE WHEN yoy_14_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp14 ORDER BY "Year") -1 ELSE NULL END AS yoy_14y_profit_years_in_row
    , CASE WHEN yoy_15_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp15 ORDER BY "Year") -1 ELSE NULL END AS yoy_15y_profit_years_in_row
, CASE WHEN yoy_16_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp16 ORDER BY "Year") -1 ELSE NULL END AS yoy_16y_profit_years_in_row
, CASE WHEN yoy_17_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp17 ORDER BY "Year") -1 ELSE NULL END AS yoy_17y_profit_years_in_row
, CASE WHEN yoy_18_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp18 ORDER BY "Year") -1 ELSE NULL END AS yoy_18y_profit_years_in_row
, CASE WHEN yoy_19_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp19 ORDER BY "Year") -1 ELSE NULL END AS yoy_19y_profit_years_in_row
, CASE WHEN yoy_20_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp20 ORDER BY "Year") -1 ELSE NULL END AS yoy_20y_profit_years_in_row
, CASE WHEN yoy_21_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp21 ORDER BY "Year") -1 ELSE NULL END AS yoy_21y_profit_years_in_row
, CASE WHEN yoy_22_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp22 ORDER BY "Year") -1 ELSE NULL END AS yoy_22y_profit_years_in_row
, CASE WHEN yoy_23_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp23 ORDER BY "Year") -1 ELSE NULL END AS yoy_23y_profit_years_in_row
, CASE WHEN yoy_24_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp24 ORDER BY "Year") -1 ELSE NULL END AS yoy_24y_profit_years_in_row
, CASE WHEN yoy_25_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp25 ORDER BY "Year") -1 ELSE NULL END AS yoy_25y_profit_years_in_row
, CASE WHEN yoy_26_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp26 ORDER BY "Year") -1 ELSE NULL END AS yoy_26y_profit_years_in_row
, CASE WHEN yoy_27_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp27 ORDER BY "Year") -1 ELSE NULL END AS yoy_27y_profit_years_in_row
, CASE WHEN yoy_28_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp28 ORDER BY "Year") -1 ELSE NULL END AS yoy_28y_profit_years_in_row
, CASE WHEN yoy_29_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp29 ORDER BY "Year") -1 ELSE NULL END AS yoy_29y_profit_years_in_row
, CASE WHEN yoy_30_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp30 ORDER BY "Year") -1 ELSE NULL END AS yoy_30y_profit_years_in_row
    , CASE WHEN real_yoy_1_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp1 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_1y_profit_years_in_row
    , CASE WHEN real_yoy_2_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp2 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_2y_profit_years_in_row
    , CASE WHEN real_yoy_3_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp3 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_3y_profit_years_in_row
    , CASE WHEN real_yoy_4_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp4 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_4y_profit_years_in_row
    , CASE WHEN real_yoy_5_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp5 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_5y_profit_years_in_row
    , CASE WHEN real_yoy_6_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp6 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_6y_profit_years_in_row
    , CASE WHEN real_yoy_7_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp7 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_7y_profit_years_in_row
    , CASE WHEN real_yoy_8_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp8 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_8y_profit_years_in_row
    , CASE WHEN real_yoy_9_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp9 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_9y_profit_years_in_row
    , CASE WHEN real_yoy_10_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp10 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_10y_profit_years_in_row
    , CASE WHEN real_yoy_11_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp11 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_11y_profit_years_in_row
    , CASE WHEN real_yoy_12_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp12 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_12y_profit_years_in_row
    , CASE WHEN real_yoy_13_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp13 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_13y_profit_years_in_row
    , CASE WHEN real_yoy_14_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp14 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_14y_profit_years_in_row
    , CASE WHEN real_yoy_15_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp15 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_15y_profit_years_in_row
    , CASE WHEN real_yoy_16_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp16 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_16y_profit_years_in_row
, CASE WHEN real_yoy_17_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp17 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_17y_profit_years_in_row
, CASE WHEN real_yoy_18_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp18 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_18y_profit_years_in_row
, CASE WHEN real_yoy_19_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp19 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_19y_profit_years_in_row
, CASE WHEN real_yoy_20_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp20 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_20y_profit_years_in_row
, CASE WHEN real_yoy_21_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp21 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_21y_profit_years_in_row
, CASE WHEN real_yoy_22_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp22 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_22y_profit_years_in_row
, CASE WHEN real_yoy_23_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp23 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_23y_profit_years_in_row
, CASE WHEN real_yoy_24_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp24 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_24y_profit_years_in_row
, CASE WHEN real_yoy_25_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp25 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_25y_profit_years_in_row
, CASE WHEN real_yoy_26_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp26 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_26y_profit_years_in_row
, CASE WHEN real_yoy_27_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp27 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_27y_profit_years_in_row
, CASE WHEN real_yoy_28_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp28 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_28y_profit_years_in_row
, CASE WHEN real_yoy_29_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp29 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_29y_profit_years_in_row
, CASE WHEN real_yoy_30_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp30 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_30y_profit_years_in_row
FROM (
    SELECT
        *
        , SUM(CASE WHEN yoy_1_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp1
        , SUM(CASE WHEN yoy_2_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp2
        , SUM(CASE WHEN yoy_3_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp3
        , SUM(CASE WHEN yoy_4_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp4
        , SUM(CASE WHEN yoy_5_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp5
        , SUM(CASE WHEN yoy_6_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp6
        , SUM(CASE WHEN yoy_7_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp7
        , SUM(CASE WHEN yoy_8_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp8
        , SUM(CASE WHEN yoy_9_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp9
        , SUM(CASE WHEN yoy_10_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp10
        , SUM(CASE WHEN yoy_11_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp11
        , SUM(CASE WHEN yoy_12_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp12
        , SUM(CASE WHEN yoy_13_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp13
        , SUM(CASE WHEN yoy_14_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp14
        , SUM(CASE WHEN yoy_15_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp15
        , SUM(CASE WHEN yoy_16_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp16
, SUM(CASE WHEN yoy_17_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp17
, SUM(CASE WHEN yoy_18_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp18
, SUM(CASE WHEN yoy_19_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp19
, SUM(CASE WHEN yoy_20_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp20
, SUM(CASE WHEN yoy_21_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp21
, SUM(CASE WHEN yoy_22_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp22
, SUM(CASE WHEN yoy_23_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp23
, SUM(CASE WHEN yoy_24_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp24
, SUM(CASE WHEN yoy_25_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp25
, SUM(CASE WHEN yoy_26_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp26
, SUM(CASE WHEN yoy_27_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp27
, SUM(CASE WHEN yoy_28_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp28
, SUM(CASE WHEN yoy_29_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp29
, SUM(CASE WHEN yoy_30_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp30
        , SUM(CASE WHEN real_yoy_1_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp1
        , SUM(CASE WHEN real_yoy_2_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp2
        , SUM(CASE WHEN real_yoy_3_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp3
        , SUM(CASE WHEN real_yoy_4_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp4
        , SUM(CASE WHEN real_yoy_5_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp5
        , SUM(CASE WHEN real_yoy_6_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp6
        , SUM(CASE WHEN real_yoy_7_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp7
        , SUM(CASE WHEN real_yoy_8_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp8
        , SUM(CASE WHEN real_yoy_9_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp9
        , SUM(CASE WHEN real_yoy_10_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp10
        , SUM(CASE WHEN real_yoy_11_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp11
        , SUM(CASE WHEN real_yoy_12_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp12
        , SUM(CASE WHEN real_yoy_13_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp13
        , SUM(CASE WHEN real_yoy_14_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp14
        , SUM(CASE WHEN real_yoy_15_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp15
        , SUM(CASE WHEN real_yoy_16_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp16
, SUM(CASE WHEN real_yoy_17_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp17
, SUM(CASE WHEN real_yoy_18_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp18
, SUM(CASE WHEN real_yoy_19_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp19
, SUM(CASE WHEN real_yoy_20_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp20
, SUM(CASE WHEN real_yoy_21_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp21
, SUM(CASE WHEN real_yoy_22_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp22
, SUM(CASE WHEN real_yoy_23_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp23
, SUM(CASE WHEN real_yoy_24_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp24
, SUM(CASE WHEN real_yoy_25_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp25
, SUM(CASE WHEN real_yoy_26_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp26
, SUM(CASE WHEN real_yoy_27_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp27
, SUM(CASE WHEN real_yoy_28_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp28
, SUM(CASE WHEN real_yoy_29_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp29
, SUM(CASE WHEN real_yoy_30_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp30
    FROM
        public.yearly_prep_three
) AS subquery
);

SELECT
    "Year"
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
    , yoy_16
    , yoy_17
    , yoy_18
    , yoy_19
    , yoy_20
    , yoy_21
    , yoy_22
    , yoy_23
    , yoy_24
    , yoy_25
    , yoy_26
    , yoy_27
    , yoy_28
    , yoy_29
    , yoy_30
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
    , cpi_16y -1 as cpi_16y
    , cpi_17y -1 as cpi_17y
    , cpi_18y -1 as cpi_18y
    , cpi_19y -1 as cpi_19y
    , cpi_20y -1 as cpi_20y
    , cpi_21y -1 as cpi_21y
    , cpi_22y -1 as cpi_22y
    , cpi_23y -1 as cpi_23y
    , cpi_24y -1 as cpi_24y
    , cpi_25y -1 as cpi_25y
    , cpi_26y -1 as cpi_26y
    , cpi_27y -1 as cpi_27y
    , cpi_28y -1 as cpi_28y
    , cpi_29y -1 as cpi_29y
    , cpi_30y -1 as cpi_30y
    , yoy_1_profit_years
    , yoy_2_profit_years
    , yoy_3_profit_years
    , yoy_4_profit_years
    , yoy_5_profit_years
    , yoy_6_profit_years
    , yoy_7_profit_years
    , yoy_8_profit_years
    , yoy_9_profit_years
    , yoy_10_profit_years
    , yoy_11_profit_years
    , yoy_12_profit_years
    , yoy_13_profit_years
    , yoy_14_profit_years
    , yoy_15_profit_years
    , yoy_16_profit_years
    , yoy_17_profit_years
    , yoy_18_profit_years
    , yoy_19_profit_years
    , yoy_20_profit_years
    , yoy_21_profit_years
    , yoy_22_profit_years
    , yoy_23_profit_years
    , yoy_24_profit_years
    , yoy_25_profit_years
    , yoy_26_profit_years
    , yoy_27_profit_years
    , yoy_28_profit_years
    , yoy_29_profit_years
    , yoy_30_profit_years
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
    , real_yoy_16
    , real_yoy_17
    , real_yoy_18
    , real_yoy_19
    , real_yoy_20
    , real_yoy_21
    , real_yoy_22
    , real_yoy_23
    , real_yoy_24
    , real_yoy_25
    , real_yoy_26
    , real_yoy_27
    , real_yoy_28
    , real_yoy_29
    , real_yoy_30
    , real_yoy_1_profit_years
    , real_yoy_2_profit_years
    , real_yoy_3_profit_years
    , real_yoy_4_profit_years
    , real_yoy_5_profit_years
    , real_yoy_6_profit_years
    , real_yoy_7_profit_years
    , real_yoy_8_profit_years
    , real_yoy_9_profit_years
    , real_yoy_10_profit_years
    , real_yoy_11_profit_years
    , real_yoy_12_profit_years
    , real_yoy_13_profit_years
    , real_yoy_14_profit_years
    , real_yoy_15_profit_years
    , real_yoy_16_profit_years
    , real_yoy_17_profit_years
    , real_yoy_18_profit_years
    , real_yoy_19_profit_years
    , real_yoy_20_profit_years
    , real_yoy_21_profit_years
    , real_yoy_22_profit_years
    , real_yoy_23_profit_years
    , real_yoy_24_profit_years
    , real_yoy_25_profit_years
    , real_yoy_26_profit_years
    , real_yoy_27_profit_years
    , real_yoy_28_profit_years
    , real_yoy_29_profit_years
    , real_yoy_30_profit_years
    , yoy_1y_profit_years_in_row
    , yoy_2y_profit_years_in_row
    , yoy_3y_profit_years_in_row
    , yoy_4y_profit_years_in_row
    , yoy_5y_profit_years_in_row
    , yoy_6y_profit_years_in_row
    , yoy_7y_profit_years_in_row
    , yoy_8y_profit_years_in_row
    , yoy_9y_profit_years_in_row
    , yoy_10y_profit_years_in_row
    , yoy_11y_profit_years_in_row
    , yoy_12y_profit_years_in_row
    , yoy_13y_profit_years_in_row
    , yoy_14y_profit_years_in_row
    , yoy_15y_profit_years_in_row
    , yoy_16y_profit_years_in_row
    , yoy_17y_profit_years_in_row
    , yoy_18y_profit_years_in_row
    , yoy_19y_profit_years_in_row
    , yoy_20y_profit_years_in_row
    , yoy_21y_profit_years_in_row
    , yoy_22y_profit_years_in_row
    , yoy_23y_profit_years_in_row
    , yoy_24y_profit_years_in_row
    , yoy_25y_profit_years_in_row
    , yoy_26y_profit_years_in_row
    , yoy_27y_profit_years_in_row
    , yoy_28y_profit_years_in_row
    , yoy_29y_profit_years_in_row
    , yoy_30y_profit_years_in_row
    , real_yoy_1y_profit_years_in_row
    , real_yoy_2y_profit_years_in_row
    , real_yoy_3y_profit_years_in_row
    , real_yoy_4y_profit_years_in_row
    , real_yoy_5y_profit_years_in_row
    , real_yoy_6y_profit_years_in_row
    , real_yoy_7y_profit_years_in_row
    , real_yoy_8y_profit_years_in_row
    , real_yoy_9y_profit_years_in_row
    , real_yoy_10y_profit_years_in_row
    , real_yoy_11y_profit_years_in_row
    , real_yoy_12y_profit_years_in_row
    , real_yoy_13y_profit_years_in_row
    , real_yoy_14y_profit_years_in_row
    , real_yoy_15y_profit_years_in_row
    , real_yoy_16y_profit_years_in_row
    , real_yoy_17y_profit_years_in_row
    , real_yoy_18y_profit_years_in_row
    , real_yoy_19y_profit_years_in_row
    , real_yoy_20y_profit_years_in_row
    , real_yoy_21y_profit_years_in_row
    , real_yoy_22y_profit_years_in_row
    , real_yoy_23y_profit_years_in_row
    , real_yoy_24y_profit_years_in_row
    , real_yoy_25y_profit_years_in_row
    , real_yoy_26y_profit_years_in_row
    , real_yoy_27y_profit_years_in_row
    , real_yoy_28y_profit_years_in_row
    , real_yoy_29y_profit_years_in_row
    , real_yoy_30y_profit_years_in_row
    , "Close"
FROM yearly_prep_four


-- THIRD VERSION : 5 YEAR JUMP VERSION	


SELECT
    "Year"
    , yoy_1
    , yoy_5
    , yoy_10
    , yoy_15
    , yoy_20
    , yoy_25
    , yoy_30
    , yoy_1_profit_years
    , yoy_5_profit_years
    , yoy_10_profit_years
    , yoy_15_profit_years
    , yoy_20_profit_years
    , yoy_25_profit_years
    , yoy_30_profit_years
    , real_yoy_1
    , real_yoy_5
    , real_yoy_10
    , real_yoy_15
    , real_yoy_20
    , real_yoy_25
    , real_yoy_30
    , real_yoy_1_profit_years
    , real_yoy_5_profit_years
    , real_yoy_10_profit_years
    , real_yoy_15_profit_years
    , real_yoy_20_profit_years
    , real_yoy_25_profit_years
    , real_yoy_30_profit_years
    , yoy_1y_profit_years_in_row
    , yoy_5y_profit_years_in_row
    , yoy_10y_profit_years_in_row
    , yoy_15y_profit_years_in_row
    , yoy_20y_profit_years_in_row
    , yoy_25y_profit_years_in_row
    , yoy_30y_profit_years_in_row
    , real_yoy_1y_profit_years_in_row
    , real_yoy_5y_profit_years_in_row
    , real_yoy_10y_profit_years_in_row
    , real_yoy_15y_profit_years_in_row
    , real_yoy_20y_profit_years_in_row
    , real_yoy_25y_profit_years_in_row
    , real_yoy_30y_profit_years_in_row
    ,"Close"
FROM yearly_prep_four

-- FOURTH VERSION : ACCUMULATED VERSION	



DROP TABLE IF EXISTS remapping  ;	
CREATE TABLE remapping as (
SELECT
*
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
from inflation_adjusted_profit_days_in_row iaprdir
);

DROP TABLE IF EXISTS yearly_prep_one  ;	
CREATE TABLE yearly_prep_one as (
with subquery as (
select 
"Year" ,
min(date_part('day',"Date")) AS first_trading_day_of_year
FROM remapping
where date_part('month',"Date") = 2
group by "Year"
)
select iaprdir.*
from remapping iaprdir
join subquery on date_part('day',iaprdir."Date") = subquery.first_trading_day_of_year
and date_part('year',"Date") = subquery."Year"
where date_part('month',"Date") = 2 
order by "Date"
);


DROP TABLE IF EXISTS yearly_prep_two  ;	
CREATE TABLE yearly_prep_two as (
SELECT
    ypo.*
    , CASE WHEN yoy_1 > 0 THEN 1
    WHEN yoy_1 IS NULL THEN NULL
    ELSE 0 END AS yoy_1_profit_years
    , CASE WHEN acc_5y_yoy > 0 THEN 1
    WHEN acc_5y_yoy IS NULL THEN NULL
    ELSE 0 END AS yoy_5_profit_years
    , CASE WHEN acc_10y_yoy > 0 THEN 1
    WHEN acc_10y_yoy IS NULL THEN NULL
    ELSE 0 END AS yoy_10_profit_years
    , CASE WHEN acc_15y_yoy > 0 THEN 1
    WHEN acc_15y_yoy IS NULL THEN NULL
    ELSE 0 END AS yoy_15_profit_years
, CASE WHEN acc_20y_yoy > 0 THEN 1
    WHEN acc_20y_yoy IS NULL THEN NULL
    ELSE 0 END AS yoy_20_profit_years
, CASE WHEN acc_25y_yoy > 0 THEN 1
    WHEN acc_25y_yoy IS NULL THEN NULL
    ELSE 0 END AS yoy_25_profit_years
, CASE WHEN acc_30y_yoy > 0 THEN 1
    WHEN acc_30y_yoy IS NULL THEN NULL
    ELSE 0 END AS yoy_30_profit_years
FROM yearly_prep_one ypo
);


DROP TABLE IF EXISTS yearly_prep_three  ;	
CREATE TABLE yearly_prep_three as (
SELECT
ypt.*
    , CASE WHEN real_yoy_1 > 0 THEN 1
    WHEN real_yoy_1 IS NULL THEN NULL
    ELSE 0 END AS real_yoy_1_profit_years
   , CASE WHEN acc_real_5y_yoy > 0 THEN 1
    WHEN acc_real_5y_yoy IS NULL THEN NULL
    ELSE 0 END AS real_yoy_5_profit_years
    , CASE WHEN acc_real_10y_yoy > 0 THEN 1
    WHEN acc_real_10y_yoy IS NULL THEN NULL
    ELSE 0 END AS real_yoy_10_profit_years
    , CASE WHEN acc_real_15y_yoy > 0 THEN 1
    WHEN acc_real_15y_yoy IS NULL THEN NULL
    ELSE 0 END AS real_yoy_15_profit_years
, CASE WHEN acc_real_20y_yoy > 0 THEN 1
    WHEN acc_real_20y_yoy IS NULL THEN NULL
    ELSE 0 END AS real_yoy_20_profit_years
, CASE WHEN acc_real_25y_yoy > 0 THEN 1
    WHEN acc_real_25y_yoy IS NULL THEN NULL
    ELSE 0 END AS real_yoy_25_profit_years
, CASE WHEN acc_real_30y_yoy > 0 THEN 1
    WHEN acc_real_30y_yoy IS NULL THEN NULL
    ELSE 0 END AS real_yoy_30_profit_years
    FROM yearly_prep_two ypt
);

 

DROP TABLE IF EXISTS yearly_prep_four  ;	
CREATE TABLE yearly_prep_four as (
SELECT
    *
    , CASE WHEN yoy_1_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp1 ORDER BY "Year") -1 ELSE NULL END AS yoy_1y_profit_years_in_row
    , CASE WHEN yoy_5_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp5 ORDER BY "Year") -1 ELSE NULL END AS yoy_5y_profit_years_in_row
    , CASE WHEN yoy_10_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp10 ORDER BY "Year") -1 ELSE NULL END AS yoy_10y_profit_years_in_row
    , CASE WHEN yoy_15_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp15 ORDER BY "Year") -1 ELSE NULL END AS yoy_15y_profit_years_in_row
, CASE WHEN yoy_20_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp20 ORDER BY "Year") -1 ELSE NULL END AS yoy_20y_profit_years_in_row
, CASE WHEN yoy_25_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp25 ORDER BY "Year") -1 ELSE NULL END AS yoy_25y_profit_years_in_row
, CASE WHEN yoy_30_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_grp30 ORDER BY "Year") -1 ELSE NULL END AS yoy_30y_profit_years_in_row
    , CASE WHEN real_yoy_1_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp1 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_1y_profit_years_in_row
    , CASE WHEN real_yoy_5_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp5 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_5y_profit_years_in_row
    , CASE WHEN real_yoy_10_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp10 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_10y_profit_years_in_row
    , CASE WHEN real_yoy_15_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp15 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_15y_profit_years_in_row
, CASE WHEN real_yoy_20_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp20 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_20y_profit_years_in_row
, CASE WHEN real_yoy_25_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp25 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_25y_profit_years_in_row
, CASE WHEN real_yoy_30_profit_years = 1 THEN ROW_NUMBER() OVER (PARTITION BY yrs_real_grp30 ORDER BY "Year") -1 ELSE NULL END AS real_yoy_30y_profit_years_in_row
FROM (
    SELECT
        *
        , SUM(CASE WHEN yoy_1_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp1
        , SUM(CASE WHEN yoy_5_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp5
        , SUM(CASE WHEN yoy_10_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp10
        , SUM(CASE WHEN yoy_15_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp15
        , SUM(CASE WHEN yoy_20_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp20
, SUM(CASE WHEN yoy_25_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp25
, SUM(CASE WHEN yoy_30_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_grp30
        , SUM(CASE WHEN real_yoy_1_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp1
        , SUM(CASE WHEN real_yoy_5_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp5
        , SUM(CASE WHEN real_yoy_10_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp10
        , SUM(CASE WHEN real_yoy_15_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp15
, SUM(CASE WHEN real_yoy_20_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp20
, SUM(CASE WHEN real_yoy_25_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp25
, SUM(CASE WHEN real_yoy_30_profit_years = 0 THEN 1 ELSE 0 END) OVER (ORDER BY "Year") AS yrs_real_grp30
    FROM
        public.yearly_prep_three
) AS subquery
);

select
    "Year"
    , yoy_1
    ,  acc_5y_yoy
, acc_10y_yoy
, acc_15y_yoy
, acc_20y_yoy
, acc_25y_yoy
, acc_30y_yoy
    , yoy_1_profit_years
    , acc_yoy_5_profit_years
    , acc_yoy_10_profit_years
    , acc_yoy_15_profit_years
    , acc_yoy_20_profit_years
    , acc_yoy_25_profit_years
    , acc_yoy_30_profit_years
    , real_yoy_1
    , acc_real_5y_yoy
, acc_real_10y_yoy
, acc_real_15y_yoy
, acc_real_20y_yoy
, acc_real_25y_yoy
, acc_real_30y_yoy
    , real_yoy_1_profit_years
    , acc_real_yoy_5_profit_years
    , acc_real_yoy_10_profit_years
    , acc_real_yoy_15_profit_years
    , acc_real_yoy_20_profit_years
    , acc_real_yoy_25_profit_years
    , acc_real_yoy_30_profit_years
    , yoy_1y_profit_years_in_row
    , acc_yoy_5y_profit_years_in_row
    , acc_yoy_10y_profit_years_in_row
    , acc_yoy_15y_profit_years_in_row
    , acc_yoy_20y_profit_years_in_row
    , acc_yoy_25y_profit_years_in_row
    , acc_yoy_30y_profit_years_in_row
    , real_yoy_1y_profit_years_in_row
    , acc_real_yoy_5y_profit_years_in_row
    , acc_real_yoy_10y_profit_years_in_row
    , acc_real_yoy_15y_profit_years_in_row
    , acc_real_yoy_20y_profit_years_in_row
    , acc_real_yoy_25y_profit_years_in_row
    , acc_real_yoy_30y_profit_years_in_row
    ,"Close"
FROM yearly_prep_four


