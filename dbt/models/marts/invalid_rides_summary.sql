-- models/marts/invalid_rides_summary.sql
-- Summary of invalid or questionable ride records

select
  ride_quality_flag,
  count(*) as total_records,
  round(100.0 * count(*) / sum(count(*)) over(), 2) as percentage
from {{ ref('rides_with_stations') }}
group by ride_quality_flag
order by total_records desc
