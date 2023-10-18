select 
shipping_fee
, logCost as log_cost
, cast (ship_cost as  FLOAT64) as ship_cost
,orders_id

from gz_raw_data.raw_gz_ship