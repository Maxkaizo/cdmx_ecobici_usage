
  
    

    create or replace table `dataeng-448500`.`dataeng_448500_ecobici_ds`.`rides_with_stations`
      
    
    

    OPTIONS()
    as (
      -- models/core/rides_with_stations.sql
-- Join enriched ride data with station catalog for origin and destination context

select
  r.ride_id,
  r.source_file,
  r.ingestion_ts,

  r.bike_id,
  r.user_age,
  r.user_gender,
  r.origin_datetime,
  r.destination_datetime,
  r.ride_duration_minutes,

  -- Estación de origen
  r.origin_station_id,
  s_from.name as origin_station_name,
  s_from.lat as origin_lat,
  s_from.lon as origin_lon,

  -- Estación de destino
  r.destination_station_id,
  s_to.name as destination_station_name,
  s_to.lat as destination_lat,
  s_to.lon as destination_lon

from `dataeng-448500`.`dataeng_448500_ecobici_ds`.`stg_rides_enriched` r
left join `dataeng-448500`.`dataeng_448500_ecobici_ds`.`stg_stations` s_from
  on r.origin_station_id = s_from.station_id

left join `dataeng-448500`.`dataeng_448500_ecobici_ds`.`stg_stations` s_to
  on r.destination_station_id = s_to.station_id
    );
  