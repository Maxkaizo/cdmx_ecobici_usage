-- models/staging/stg_stations.sql
-- Staging model for the Ecobici station catalog

select
  cast(station_id as string) as station_id,
  name,
  short_name,
  lat,
  lon,
  capacity,
  is_charging,
  has_kiosk,
  ingestion_ts
from `dataeng-448500`.`dataeng_448500_ecobici_ds`.`dim_stations`