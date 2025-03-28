-- models/staging/stg_rides_enriched.sql
-- Enriched version of raw ride data with typed fields, local datetime and ride duration

select
  -- Technical identifiers
  ride_id,
  source_file,
  ingestion_ts,

  -- Bike information
  cast(bici as int64) as bike_id,

  -- Origin station
  trim(split(ltrim(ciclo_estacion_retiro, '0'), '-')[safe_offset(0)]) as origin_station_id,
  fecha_retiro as origin_date,
  hora_retiro as origin_time,
  safe.parse_datetime('%d/%m/%Y %H:%M:%S', concat(fecha_retiro, ' ', hora_retiro)) as origin_datetime,

  -- Destination station
  trim(split(ltrim(ciclo_estacion_arribo, '0'), '-')[safe_offset(0)]) as destination_station_id,
  fecha_arribo as destination_date,
  hora_arribo as destination_time,
  safe.parse_datetime('%d/%m/%Y %H:%M:%S', concat(fecha_arribo, ' ', hora_arribo)) as destination_datetime,

  -- User info
  cast(edad_usuario as int64) as user_age,
  genero_usuario as user_gender,

  -- Ride duration in minutes
  datetime_diff(
    safe.parse_datetime('%d/%m/%Y %H:%M:%S', concat(fecha_arribo, ' ', hora_arribo)),
    safe.parse_datetime('%d/%m/%Y %H:%M:%S', concat(fecha_retiro, ' ', hora_retiro)),
    minute
  ) as ride_duration_minutes

from {{ source('ecobici', 'stg_rides') }}
where
  fecha_retiro is not null
  and hora_retiro is not null
  and fecha_arribo is not null
  and hora_arribo is not null
