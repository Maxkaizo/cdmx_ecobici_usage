

  create or replace view `dataeng-448500`.`dataeng_448500_ecobici_ds`.`fct_rides_daily`
  OPTIONS()
  as -- models/marts/fct_rides_daily.sql
-- Daily summary of Ecobici rides with basic metrics and long ride count

select
  date(origin_datetime) as ride_date,
  count(*) as total_rides,
  avg(ride_duration_minutes) as avg_duration_minutes,
  count(distinct bike_id) as unique_bikes_used,
  count(distinct origin_station_id) as unique_origin_stations,
  count(distinct destination_station_id) as unique_destination_stations,
  sum(case when ride_duration_minutes > 45 then 1 else 0 end) as rides_over_45_min
from `dataeng-448500`.`dataeng_448500_ecobici_ds`.`rides_with_stations`
where
  origin_datetime is not null
  and ride_quality_flag = 'valid'
group by 1
order by 1;

