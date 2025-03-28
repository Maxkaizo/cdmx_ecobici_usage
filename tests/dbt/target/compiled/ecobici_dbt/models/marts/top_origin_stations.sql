-- models/marts/top_origin_stations.sql
-- Top 10 most frequent origin stations (with known names)

select
  origin_station_id,
  origin_station_name,
  count(*) as ride_count
from `dataeng-448500`.`dataeng_448500_ecobici_ds`.`rides_with_stations`
where origin_station_name is not null
group by 1, 2
order by ride_count desc
limit 10